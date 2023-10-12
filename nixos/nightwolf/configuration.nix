{ inputs, lib, config, pkgs, ... }: {
  imports = [../configuration.nix];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nightwolf"; # Define your hostname.
  services.udev.extraHwdb = ''
  evdev:input:b0003v05ACp0291*
    KEYBOARD_KEY_70029=capslock         # esc   --> caps
    KEYBOARD_KEY_70039=esc              # caps  --> esc
    KEYBOARD_KEY_700e7=leftctrl         # cmd --> ctrl
    KEYBOARD_KEY_700e3=leftctrl         # cmd  --> ctrl
    KEYBOARD_KEY_700e6=leftalt          # rightalt --> leftalt
    KEYBOARD_KEY_700e0=leftmeta         # ctrl  --> meta
    KEYBOARD_KEY_70050=leftmeta         # right_arrow -> meta
  '';
}
