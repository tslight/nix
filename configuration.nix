# Help is available in the configuration.nix(5) man page and in the
# NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    # ./mbr.nix
    ./efi.nix
    ./udev.nix
    ./env.nix
    ./xserver.nix
    ./packages.nix
    ./programs.nix
    ./home.nix
  ];

  networking = {
    hostName = "probook";
    networkmanager.enable = true;
    useDHCP = false;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  time.timeZone = "Europe/London";

  services.openssh.enable = true;
  services.printing.enable = true;
  services.tlp.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Reload touchpad after resume on HP Probook
  powerManagement.resumeCommands = ''
    echo "Reloading i2c_hid..." && \
        ${pkgs.kmod}/bin/rmmod i2c_hid && \
        ${pkgs.kmod}/bin/modprobe i2c_hid && \
        echo "Successfully reloaded i2c_hid :-)"
  '';

  # hardware.trackpoint.enable = true;
  # hardware.trackpoint.emulateWheel = true;
  # hardware.trackpoint.sensitivity = 142;
  # hardware.trackpoint.speed = 100;

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
        "wireshark"
      ];
      shell = pkgs.zsh;
    };
  };

  # You should change this only after NixOS release notes say you should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
