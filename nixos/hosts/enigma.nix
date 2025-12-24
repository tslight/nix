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

  boot.initrd.availableKernelModules = [
    "nvme"
    "ehci_pci"
    "xhci_pci_renesas"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  # https://github.com/NixOS/nixpkgs/issues/219239#issuecomment-1879595054
  boot.initrd.kernelModules = [ "amdgpu" ]; # or else setting console font breaks, use i915 for intel
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-b1f65770-0746-40ad-a557-cdd31604771f";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-4da17729-a689-4796-bf9d-5df51c3e5934" = {
    device = "/dev/disk/by-uuid/4da17729-a689-4796-bf9d-5df51c3e5934";
  };
  boot.initrd.luks.devices."luks-b1f65770-0746-40ad-a557-cdd31604771f" = {
    device = "/dev/disk/by-uuid/b1f65770-0746-40ad-a557-cdd31604771f";
    allowDiscards = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E7F3-B5BA";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [{device = "/dev/mapper/luks-4da17729-a689-4796-bf9d-5df51c3e5934";}];
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
