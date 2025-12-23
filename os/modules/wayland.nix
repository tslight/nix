{ pkgs, ... }:
let
  waylandEmacsVterm =
    (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]);
in
{
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true; # for audio I think

  fonts.packages = with pkgs; [
    font-awesome# for waybar
    nerd-fonts.jetbrains-mono # for foot glyphs
  ];

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    brightnessctl
    dropbox-cli
    foot
    fuzzel
    imagemagick
    niri
    playerctl
    swayidle
    swaylock
    tuigreet
    waylandEmacsVterm
    waybar
    wlsunset
  ];

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

  programs.niri.enable = true;
}
