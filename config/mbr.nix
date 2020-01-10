{ config, pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      # Use the GRUB 2 boot loader.
      grub.enable = true;
      grub.version = 2;
      # Define on which hard drive you want to install Grub.
      grub.device = "/dev/sda"; # or "nodev" for efi only
    };
  };
}
