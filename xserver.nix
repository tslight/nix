{ config, ... }: {
  services.xserver = {
    enable = true; # Turn the fucker on
    layout = "gb"; # Set the keyboard layout
    xkbOptions = "terminate:ctrl_alt_bksp";

    # Enable touchpad support.
    libinput.enable = true;
    libinput.tapping = false; # disable tap to click

    displayManager = {
      sddm.enable = true;
      auto.enable = true; # Auto login
      auto.user = "toby";
    };

    desktopManager = {
      plasma5.enable = true;
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
