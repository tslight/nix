# Help is available in the configuration.nix(5) man page and in the
# NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./mbr.nix
      # ./efi.nix
      ./packages.nix
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  services.openssh.enable = true;
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users = {
    toby = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "networkmanager"
        "systemd-journal"
        "wheel" # Enable ‘sudo’ for the user.
      ];
      shell = "${pkgs.bashInteractive_5}${pkgs.bashInteractive_5.shellPath}";
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
