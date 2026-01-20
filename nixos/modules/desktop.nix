# Display server agnostic configuration & packages
{ pkgs, ... }:
{
  imports = [
    ../../common/browsers.nix
    ../../common/emacs.nix
  ];

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true; # for audio I think

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

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    dropbox-cli
    libreoffice
    mpv
    playerctl
    protonvpn-gui
    qbittorrent
  ];
}
