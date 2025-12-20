{ pkgs, ... }: {
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  environment.systemPackages = with pkgs; [ tuigreet niri ];
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "anon";
      };
      # By adding default_session it ensures you can still access the tty
      # terminal if you logout of your windows manager otherwise you would just
      # relaunch into it.
      default_session = {
        command = ''
tuigreet --greeting "(0x2b) || !(0x2b) == 00xff" --asterisks --remember --remember-user-session --time --cmd niri-session
        '';
        user = "greeter"; # DO NOT CHANGE THIS USER
      };
    };
  };
  security.rtkit.enable = true; # for audio I think

  programs.niri.enable = true;
}
