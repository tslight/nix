{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ./lsp.nix ];

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.greetd = {
    enable = true;
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
        ${pkgs.tuigreet}/bin/tuigreet \
          --greeting "Welcome To NixOS" \
          --asterisks \
          --remember \
          --remember-session \
          --remember-user-session \
          --time \
          --cmd niri-session
        '';
        user = "greeter"; # DO NOT CHANGE THIS USER
      };
    };
  };

  programs.niri.enable = true;
}
