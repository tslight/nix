{ config, ... }:
{
  services.xserver = {
    enable = true; # Turn the fucker on
    layout = "gb"; # Set the keyboard layout
    xkbOptions = "terminate:ctrl_alt_bksp";

    # Enable touchpad support.
    libinput.enable = true;
    libinput.tapping = false; # disable tap to click

    displayManager = {
      # sddm.enable = true;
      # slim.enable = true;
      lightdm.enable = true;
      # Auto login
      auto.enable = true;
      auto.user = "toby";
    };

    desktopManager = {
      # plasma5.enable = true;
      xfce.enable = true;
      # gnome3.enable = true;
      # mate.enable = true;
      default = "xfce";
    };

    windowManager = {
      awesome.enable = true;
      exwm.enable = true;
      fluxbox.enable = true;
      fvwm.enable = true;
      openbox.enable = true;
      i3.enable = true;
      icewm.enable = true;
      ratpoison.enable = true;
      spectrwm.enable = true;
      stumpwm.enable = true;
      twm.enable = true;
      windowmaker.enable = true;
      xmonad.enable = true;
      default = "none";
    };
  };
}
