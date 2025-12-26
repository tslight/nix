{ config, lib, modulesPath, host, system, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/kbd-thinkpad-chicklet.nix
    ../modules/etc-issue-cardiel.nix
    ../modules/battery.nix
    ../modules/minimal.nix
    ../modules/wayland.nix
  ];

  # The system & host vars are getting passed in from the flake
  nixpkgs.hostPlatform = lib.mkDefault system;
  networking.hostName = host;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/49455ca6-37b4-4264-9840-c443044c1b14";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0FDE-5315";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/luks-997fd61c-5591-4a05-88c6-1e3e50ec7bd1";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-997fd61c-5591-4a05-88c6-1e3e50ec7bd1".device = "/dev/disk/by-uuid/997fd61c-5591-4a05-88c6-1e3e50ec7bd1";
  boot.initrd.luks.devices."luks-997fd61c-5591-4a05-88c6-1e3e50ec7bd1".allowDiscards = true;

  swapDevices =
    [ { device = "/dev/disk/by-uuid/46c726ed-a443-455f-8fdd-f82a45c92c3f"; }
    ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
