{ inputs, lib, config, pkgs, ... }: {
  imports = [../configuration.nix];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "cardiel"; # Define your hostname.
  services.udev.extraHwdb = ''
    evdev:atkbd:dmi:bvn*:bvr*:svnLENOVO*:pvrThinkPadX131e*
      KEYBOARD_KEY_01=capslock         # esc   --> caps
      KEYBOARD_KEY_3a=esc              # caps  --> esc
      KEYBOARD_KEY_38=leftctrl         # alt   --> leftctrl
      KEYBOARD_KEY_db=leftalt          # super --> leftalt
      KEYBOARD_KEY_1d=leftmeta         # leftctrl  --> leftsuper
      KEYBOARD_KEY_b8=leftctrl         # altgr --> leftctrl
      KEYBOARD_KEY_b7=leftalt          # prtsc --> leftalt
      KEYBOARD_KEY_9d=leftmeta         # rightctrl  --> leftmeta
  '';
}
