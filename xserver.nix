{ config, ... }: {
  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "terminate:ctrl_alt_bksp";

    # Enable touchpad support.
    libinput.enable = true;
    libinput.tapping = false; # disable tap to click
    libinput.clickMethod = "clickfinger";
    libinput.middleEmulation = true;

    displayManager = {
      # gdm = {
      #   enable = true;
      #   autoLogin.enable = true;
      #   autoLogin.user = "toby";
      # };
      # lightdm = {
      #   enable = true;
      #   autoLogin.enable = true;
      #   autoLogin.user = "toby";
      # };
      sddm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "toby";
      };
      # slim = {
      #   enable = true;
      #   autoLogin.enable = true;
      #   autoLogin.user = "toby";
      # };
    };

    desktopManager = {
      # enlightenment.enable = true;
      # gnome3.enable = true;
      # lumina.enable = true;
      lxqt.enable = true;
      # mate.enable = true;
      plasma5.enable = true;
      # xfce.enable = true;
      default = "plasma5";
    };

    windowManager = {
      awesome.enable = true;
      exwm.enable = true;
      # exwm.enableDefaultConfig = true; # vanilla
      fvwm.enable = true;
      # fluxbox.enable = true;
      i3.enable = true;
      # icewm.enable = true;
      jwm.enable = true;
      openbox.enable = true;
      # sawfish.enable = true;
      stumpwm.enable = true;
      windowmaker.enable = true;
      xmonad.enable = true;
      default = "none";
    };
  };
}
