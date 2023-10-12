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

  # https://the-empire.systems/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-key-theme = "Emacs";
      clock-show-weekday = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-message-tray = "disabled"; # needs to be for maximize to work
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
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-panel@jderose9.github.com"
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
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "kitty -e tmux attach";
      name = "open-tmux";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>e";
      command = "emacsclient -c -a ''";
      name = "open-emacs";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Super>w";
      command = "firefox";
      name = "open-firefox";
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-margin = 4;
      appicon-padding = 4;
      dot-position = "LEFT";
      dot-style-focused = "SOLID";
      dot-style-unfocused = "DASHES";
      panel-anchors = "{\"0\":\"MIDDLE\"}";
      panel-lengths = "{\"0\":100}";
      panel-positions = "{\"0\":\"LEFT\"}";
      panel-sizes = "{\"0\":48}";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion  =  "23.05";
}
