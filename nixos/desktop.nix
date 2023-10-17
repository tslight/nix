{ inputs, lib, config, pkgs, ... }: {
  imports = [./configuration.nix];

  services.printing.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "toby";
  services.xserver.excludePackages = [ pkgs.xterm ];
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    gnome.cheese
    gnome.evince
    gnome.gnome-themes-extra
    gnome.gnome-tweaks
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    mpv
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    atomix
    epiphany
    geary
    gedit
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-terminal
    hitori
    iagno
    tali
    totem
    yelp
  ]);

  programs.dconf.enable = true;

  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  [org/gnome/desktop/interface]
  color-scheme='prefer-dark'
  gtk-key-theme='Emacs'
  '';

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
