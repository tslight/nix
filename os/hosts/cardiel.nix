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

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/918fe89d-2e81-4710-aaea-0f5c43d67a26";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0820-1D5D";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/luks-c5748b76-2409-4b74-a094-76d4b5bc7045";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-c5748b76-2409-4b74-a094-76d4b5bc7045".device = "/dev/disk/by-uuid/c5748b76-2409-4b74-a094-76d4b5bc7045";
  boot.initrd.luks.devices."luks-c5748b76-2409-4b74-a094-76d4b5bc7045".allowDiscards = true;

  swapDevices = [ { device = "/dev/disk/by-uuid/7f7997a6-05f3-4a54-acbe-4658a4ba0f82"; } ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
}
