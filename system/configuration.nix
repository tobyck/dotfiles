{  pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		inputs.apple-silicon.nixosModules.default

		./services/mosquitto
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nixpkgs.config.allowUnfree = true;
	
	environment.systemPackages = with pkgs; [
		# Command line tools
  	git
		killall

    # System
		alsa-utils
		brightnessctl
		playerctl
		wl-clipboard

		# Languages
		cargo rustc rustup
		nodejs bun
		python3
		sassc

		# Language servers
		# (Install rust-analyzer with rustup: `rustup component add rust-analyzer`)
		nodePackages.typescript-language-server
		lua-language-server
		nil # For Nix
	];

	# Speed up Hyprland install
	nix.settings = {
		substituters = [ "https://hyprland.cachix.org" ];
		trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
	};

	programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.default;
	};

	# Idk what this does but apparently I need it
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = false;

	hardware.asahi.useExperimentalGPUDriver = true;

	networking = {
		hostName = "deepthought";

		# These are the recommended settings apparently
		networkmanager.enable = true;
		wireless.iwd = {
			enable = true;
			settings.General.EnableNetworkConfiguration = true;
		};
	};

	# NZ
	time.timeZone = "Pacific/Auckland";

	# X config just in case Hyprland has a meltdown
	services.xserver = {
		enable = true;
		desktopManager.xfce.enable = true;
		xkb.layout = "us";
		# Kanata handles this now
		# xkb.variant = "colemak";
		# xkb.options = "caps:backspace";
	};

	# Use xkb options in tty
	console.useXkbConfig = true;

	# Enable CUPS to print documents
	services.printing.enable = true;

	sound.enable = true;

	programs.fish.enable = true;

	# uinput group for Kanata
	users.groups.uinput = {};
	services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';

	users.users.toby = {
		isNormalUser = true;
		extraGroups = [
			"wheel" # Root permissions

			# Input groups for Kanata to work
			"uinput"
			"input" # There's no way that this is safe lol

			# So that I can read from USB devices like Arduinos
			"dialout"
		];
		initialPassword = "password";
		shell = pkgs.fish;
	};

	# Don't change this unless you really know what you're doing
	system.stateVersion = "24.05";
}
