{ inputs, lib, config, pkgs, ... }: {
  imports = [../desktop.nix];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "porridge"; # Define your hostname.
  services.fwupd.enable = true;
  services.udev.extraHwdb = ''
  evdev:input:b0011v0001p0001*
    KEYBOARD_KEY_01=capslock
    KEYBOARD_KEY_3a=esc
    KEYBOARD_KEY_b8=leftctrl
    KEYBOARD_KEY_38=leftctrl
    KEYBOARD_KEY_b7=leftalt
    KEYBOARD_KEY_db=leftalt
    KEYBOARD_KEY_9d=leftmeta
    KEYBOARD_KEY_1d=leftmeta
  '';
}
