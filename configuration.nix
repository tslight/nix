# Help is available in the configuration.nix(5) man page and in the
# NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./emacs.nix
      ./udev.nix
      ./xserver.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      # Use the GRUB 2 boot loader.
      grub.enable = true;
      grub.version = 2;
      # Define on which hard drive you want to install Grub.
      grub.device = "/dev/sda"; # or "nodev" for efi only
      # grub.efiSupport = true;
      # grub.efiInstallAsRemovable = true;
      # efi.efiSysMountPoint = "/boot/efi";

      # Use the systemd-boot EFI boot loader.
      # systemd-boot.enable = true;
      # efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "throg"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    # useDHCP = false;
    interfaces.enp0s25.useDHCP = true;
    interfaces.wls3.useDHCP = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:
  services.openssh.enable = true;
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    toby = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "networkmanager"
        "wheel" # Enable ‘sudo’ for the user.
      ];
    };
    guest = {
      isNormalUser = true;
      extraGroups = [
      ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
