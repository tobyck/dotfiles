{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.apple-silicon.nixosModules.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

	nixpkgs.overlays = [ inputs.hyprland.overlays.default ];

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
		cargo # Rust
		nodejs bun # JS/TS

		# Language servers
		rust-analyzer
		nodePackages.typescript-language-server
		lua-language-server
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

	hardware = {
		opengl = {
			enable = true;
			driSupport32Bit = lib.mkForce false;
			driSupport = true;
		};

		asahi.useExperimentalGPUDriver = true;
	};

	networking = {
		hostName = "deepthought";

		# These are the recommended settings apparently
		networkmanager.enable = true;
		wireless.iwd = {
			enable = true;
			settings.General.EnableNetworkConfiguration = true;
		};
	};

	time.timeZone = "Pacific/Auckland";

	# Use xkb options in tty
	console.useXkbConfig = true;

	# Temporary X11 config
	services.xserver = {
		enable = true;
		desktopManager.xfce.enable = true;
		xkb.layout = "us";
		# Kanata handles this now
		# xkb.variant = "colemak";
		# xkb.options = "caps:backspace";
	};

	# Enable CUPS to print documents.
	# services.printing.enable = true;

	# Enable sound.
	sound.enable = true;
	# Might need this later?
	# hardware.pulseaudio.enable = true;

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
		];
		initialPassword = "password";
		shell = pkgs.fish;
	};

	# Don't change this unless you really know what you're doing
	system.stateVersion = "24.05";
}
