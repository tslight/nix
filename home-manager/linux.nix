{ inputs, lib, config, pkgs, ...}: {
  imports = [ ./home.nix ];

  home = {
    username = "toby";
    homeDirectory = "/home/toby";
  };

  home.packages = [ pkgs.emacs29-pgtk ];

  gtk.enable = true;
  gtk.theme.name = "Adwaita";
  gtk.gtk2.extraConfig = ''
    gtk-key-theme-name = "Emacs"
    gtk-application-prefer-dark-theme = 1
  '';
  gtk.gtk3.extraConfig = {
    gtk-key-theme-name = "Emacs";
    gtk-application-prefer-dark-theme = 1;
  };
  gtk.gtk4.extraConfig = {
    gtk-key-theme-name = "Emacs";
    gtk-application-prefer-dark-theme = 1;
  };

  programs.firefox.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # gnome-extensions
    ];
  };

  services.emacs = { enable = true; client.enable = true; };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-key-theme = "Emacs";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "chromium.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "emacsclient.desktop"
      ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
