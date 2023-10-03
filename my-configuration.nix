{ config, pkgs, ... }:
{
  imports = [
    ./configuration.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
    experimental-features = nix-command flakes
  '';
  };

  services.udev.extraHwdb = ''
      # cat /proc/bus/input/devices | grep -i keyboard -A 9 -B 1
      # Lenovo 100E 2nd Gen
      evdev:input:b0011v0001p0001*
       KEYBOARD_KEY_01=capslock         # esc   --> caps
       KEYBOARD_KEY_3a=esc              # caps  --> esc
       KEYBOARD_KEY_38=leftctrl         # alt   --> leftctrl
       KEYBOARD_KEY_db=leftalt          # super --> leftalt
       KEYBOARD_KEY_1d=leftmeta         # ctrl  --> super
       KEYBOARD_KEY_b8=leftctrl         # altgr --> leftctrl
       KEYBOARD_KEY_9d=leftalt          # ctrl  --> leftalt (otherwise altgr)
    '';

  programs = {
    neovim.enable = true;
    hyprland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ansible
    mg
    firefox
    kitty
    wofi
  ];
}
