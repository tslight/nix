{ lib, modulesPath, host, system, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ../modules/issue.nix { issueName = "shri"; })
    ../modules/etc-issue-shri.nix
    ../modules/kbd-thinkpad-chicklet.nix
    ../modules/battery.nix
    ../modules/minimal.nix
    ../modules/wayland.nix
  ];

  # The system & host vars are getting passed in from the flake
  nixpkgs.hostPlatform = lib.mkDefault system;
  networking.hostName = host;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-48809d94-b2b6-4c33-987d-d43065357dbf";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-48809d94-b2b6-4c33-987d-d43065357dbf".device = "/dev/disk/by-uuid/48809d94-b2b6-4c33-987d-d43065357dbf";
  boot.initrd.luks.devices."luks-48809d94-b2b6-4c33-987d-d43065357dbf".allowDiscards = true;

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/98DB-DB29";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [{ device = "/var/lib/swapfile"; size = 2*1024; }];
}
