{ inputs, lib, config, pkgs, ...}: {
  imports = [ ../desktop.nix ./home.nix ];

  # mainly all for emacs :-)
  home.packages = [
    pkgs.aspell
    pkgs.emacs29-pgtk
    pkgs.hunspell
    pkgs.imagemagick
    pkgs.ispell
    pkgs.mupdf
  ];

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
      { id = "gfbliohnnapiefjpjlpjnehglfpaknnc"; } # surfing-keys
    ];
  };

  services.emacs = { enable = true; client.enable = true; };

  # https://the-empire.systems/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-key-theme = "Emacs";
      clock-show-weekday = true;
      show-battery-percentage = true;
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };
    "org/gnome/shell/weather" = {
      automatic-location = true;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 7200;
      sleep-inactive-battery-timeout = 600;
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-message-tray = "disabled"; # needs to be for maximize to work
      close = ["<Super>q"];
      show-desktop = ["<Super>d"];
      toggle-maximized = ["<Super><Control>m"];
      maximize = ["<Alt>F10"];
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
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "chromium-browser.desktop"
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
  };
}
