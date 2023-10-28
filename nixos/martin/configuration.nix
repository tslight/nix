{ inputs, lib, config, pkgs, ... }: {
  imports = [../desktop.nix];
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  services.udev.extraHwdb = ''
    evdev:input:b0003v258Ap001E*
      KEYBOARD_KEY_70029=capslock         # esc   --> caps
      KEYBOARD_KEY_70039=esc              # caps  --> esc
      KEYBOARD_KEY_700e6=leftctrl         # alt   --> ctrl
      KEYBOARD_KEY_700e2=leftctrl         # altgr --> ctrl
      KEYBOARD_KEY_700e4=leftalt          # super --> alt
      KEYBOARD_KEY_700e3=leftalt          # ctrl  --> alt
      KEYBOARD_KEY_700e0=leftmeta         # left  --> meta
      KEYBOARD_KEY_70050=leftmeta         # ctrl  --> meta
      KEYBOARD_KEY_700a5=brightnessdown
      KEYBOARD_KEY_700a6=brightnessup
      KEYBOARD_KEY_70066=sleep
    evdev:input:b0003v258Ap001Ee0110-e0,1,2,4,k110,111,112,r0,1,am4,lsfw
      ID_INPUT=0
      ID_INPUT_MOUSE=0
  '';

  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  # This list of modules is not entirely minified, but represents
  # a set of modules that is required for the display to work in stage-1.
  # Further minification can be done, but requires trial-and-error mainly.
  boot.initrd.kernelModules = [
    # Rockchip modules
    "rockchip_rga"
    "rockchip_saradc"
    "rockchip_thermal"
    "rockchipdrm"

    # GPU/Display modules
    "analogix_dp"
    "cec"
    "drm"
    "drm_kms_helper"
    "dw_hdmi"
    "dw_mipi_dsi"
    "gpu_sched"
    "panel_edp"
    "panel_simple"
    "panfrost"
    "pwm_bl"

    # USB / Type-C related modules
    "fusb302"
    "tcpm"
    "typec"

    # Misc. modules
    "cw2015_battery"
    "gpio_charger"
    "rtc_rk808"
  ];

  # https://github.com/elementary/os/blob/05a5a931806d4ed8bc90396e9e91b5ac6155d4d4/build-pinebookpro.sh#L253-L257
  # Mark the keyboard as internal, so that "disable when typing" works for the touchpad
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Pinebook Pro Keyboard]
    MatchUdevType=keyboard
    MatchBus=usb
    MatchVendor=0x258A
    MatchProduct=0x001E
    AttrKeyboardIntegration=internal
  '';

  hardware.enableRedistributableFirmware = true;

  systemd.tmpfiles.rules = [
    # Tweak the minimum frequencies of the GPU and CPU governors to get a bit more performance
    # https://github.com/elementary/os/blob/05a5a931806d4ed8bc90396e9e91b5ac6155d4d4/build-pinebookpro.sh#L288-L294
    "w- /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq - - - - 1200000"
    "w- /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq - - - - 1008000"
    "w- /sys/class/devfreq/ff9a0000.gpu/min_freq - - - - 600000000"
  ];

  # The default powersave makes the wireless connection unusable.
  networking.networkmanager.wifi.powersave = lib.mkDefault false;
}
