{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.apple-silicon.nixosModules.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Apps
    foot
    firefox
    vscode    

    # Tools
    git
    alsa-utils
  ];

  # Speed up Hyprland install
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Use the systemd-boot EFI boot loader (idek what this means lol)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Use the Asahi GPU driver
  nixpkgs.overlays = [ inputs.apple-silicon.overlays.default ];
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

  time.timeZone = "Pacific/Auckland";

  # Use xkb options in tty
  console.useXkbConfig = true;

  # Temporary X11 config
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak";
  services.xserver.xkb.options = "caps:backspace";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # Might need this later?
  # hardware.pulseaudio.enable = true;

  users.users.toby = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Allow sudo
    initialPassword = "password";
  };

  # Don't change this unless you really know what you're doing
  system.stateVersion = "24.05";
}
