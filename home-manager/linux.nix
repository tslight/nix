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

  programs.kitty.enable = true;
  programs.kitty.extraConfig = ''
    font_size 12.0
    scrollback_lines 10000
    copy_on_select yes
    strip_trailing_spaces smart
    terminal_select_modifiers ctrl
    hide_window_decorations yes
    clipboard_control write-clipboard write-primary no-append
    term xterm-256color
    map ctrl+Tab        next_tab
    map kitty_mod+Tab   previous_tab
    map ctrl+Escape goto_tab -1
    map ctrl+equal      change_font_size all +2.0
    map ctrl+minus      change_font_size all -2.0
    map kitty_mod+equal change_font_size all 0
  '';

  services.emacs = {
    enable = true;
    client.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-key-theme = "Emacs";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
