{ config, ... }: {
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
      # Auto login - only works with LightDM
      auto.enable = true; 
      auto.user = "toby";
    };

    desktopManager = {
      # gnome3.enable = true;
      # mate.enable = true;
      plasma5.enable = true;
      xfce.enable = true;
      default = "plasma5";
    };

    windowManager = {
      exwm.enable = true;
      stumpwm.enable = true;
      xmonad.enable = true;
      default = "none";
    };
  };
}
