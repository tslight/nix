{ config, lib, pkgs, modulesPath, host, system, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ../modules/issue.nix { issueName = "wordsworth"; })
    ../modules/kbd-apple-standard.nix
    ../modules/battery.nix
    ../modules/minimal.nix
    ../modules/wayland.nix
  ];

  # The system & host vars are getting passed in from the flake
  nixpkgs.hostPlatform = lib.mkDefault system;
  networking.hostName = host;

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "wl" ];
  nixpkgs.config.permittedInsecurePackages = [ "broadcom-sta-6.30.223.271-59-6.17.9" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bbfb3cdc-f7a7-4798-9b22-5feb5f3559d5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E590-A5EE";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/e0553170-48af-4b7c-a295-1a521fd78d40"; } ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
