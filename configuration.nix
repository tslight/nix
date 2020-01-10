# Help is available in the configuration.nix(5) man page and in the
# NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    # ./config/mbr.nix
    ./config/efi.nix
    ./config/udev.nix
    ./config/networking.nix
    ./config/services.nix
    ./config/misc.nix
    ./config/env.nix
    ./config/xserver.nix
    ./config/packages.nix
    ./config/programs.nix
    ./config/users.nix
    ./config/home.nix
  ];

  # You should change this only after NixOS release notes say you should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
