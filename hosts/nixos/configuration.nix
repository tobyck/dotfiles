{  pkgs, inputs, config, ... }:

{
	imports = [
		./hardware-configuration.nix
		inputs.apple-silicon.nixosModules.default
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nixpkgs.config.allowUnfree = true;
	
	environment.systemPackages = with pkgs; [
		greetd.tuigreet

		# Command line tools
		git
		killall
		config.boot.kernelPackages.perf

		# System
		alsa-utils
		brightnessctl
		playerctl
		wl-clipboard

		# Languages
		cargo rustc rustup
		nodejs bun typescript
		python3
		clang
		sassc
	];

	# uinput group for Kanata
	users.groups.uinput = {};
	services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';

	programs.fish.enable = true;

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
		shell = pkgs.nushell;
	};

	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "tuigreet --cmd sway";
			};
		};
	};

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

		firewall.allowedTCPPorts = [
			1883 8883 # For Mosquitto
		];
	};

	# NZ
	time.timeZone = "Pacific/Auckland";

	# Enable CUPS
	services.printing = {
		enable = true;
	};

	# I only added this to automatically discover printers
	# I have no clue what nssmdns4 means
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

	nix.settings = {
		substituters = [ "https://hyprland.cachix.org" ];
		trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
	};

	programs.hyprland = {
		enable = false;
		package = inputs.hyprland.packages.${pkgs.system}.default;
	};

	programs.sway = {
		enable = true;
		package = pkgs.swayfx;
	};

	# X config just in case Wayland has a meltdown
	services.xserver = {
		enable = true;
		desktopManager.xfce.enable = true;
		# Sway xkb config changes this to Māori, and Kanata does all the Colemak and HRM stuff
		xkb.layout = "us";
	};

	# Use xkb options in tty
	console.useXkbConfig = true;

	# Don't change this unless you really know what you're doing
	system.stateVersion = "24.05";
}
