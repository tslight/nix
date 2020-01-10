{ config, pkgs, ... }: {
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  time.timeZone = "Europe/London";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware.trackpoint.enable = true;
  # hardware.trackpoint.emulateWheel = true;
  # hardware.trackpoint.sensitivity = 142;
  # hardware.trackpoint.speed = 100;

  # Reload touchpad after resume on HP Probook
  powerManagement.resumeCommands = ''
    echo "Reloading i2c_hid..." && \
        ${pkgs.kmod}/bin/rmmod i2c_hid && \
        ${pkgs.kmod}/bin/modprobe i2c_hid && \
        echo "Successfully reloaded i2c_hid :-)"
  '';
}
