# Help is available in the configuration.nix(5) man page and in the
# NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      # ./mbr.nix
      ./efi.nix
      ./packages.nix
      ./programs.nix
      ./udev.nix
      ./xserver.nix
    ];

  networking = {
    hostName = "throg";
    networkmanager.enable = true;
    interfaces.enp0s25.useDHCP = true;
    interfaces.wls3.useDHCP = true;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  time.timeZone = "Europe/London";

  services.openssh.enable = true;
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Don't forget to set a password with ‘passwd’.
  # users.defaultUserShell = pkgs.zsh;
  users.users = {
    toby = {
      isNormalUser = true;
      description = "Toby Slight";
      extraGroups = [
        "docker"
        "networkmanager"
        "systemd-journal"
        "wheel" # Enable ‘sudo’ for the user.
      ];
      shell = pkgs.zsh;
    };
  };

  # You should change this only after NixOS release notes say you should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
