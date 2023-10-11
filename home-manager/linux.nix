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
      clock-show-weekday = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      toggle-maximized = ["<Super>m"];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enable-hot-corners = true;
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
        "emacs.desktop"
        "kitty.desktop"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "kitty";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "emacsclient -c -a ''";
      name = "open-emacs";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>w";
      command = "firefox";
      name = "open-firefox";
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      dock-fixed = true;
      dock-position = "LEFT";
      extend-height = true;
      icon-size-fixed = true;
      multi-monitor = true;
      show-trash=false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
