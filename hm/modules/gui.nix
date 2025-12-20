{ pkgs, ... }: {
  home.packages = [
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-science
    pkgs.aspellDicts.en-computers
    pkgs.dropbox-cli
    pkgs.brightnessctl
    pkgs.emacs-pgtk
    pkgs.fuzzel
    pkgs.imagemagick
    pkgs.kitty
    pkgs.playerctl
    pkgs.swaylock
    pkgs.swayidle
    pkgs.waybar
    pkgs.wlsunset
  ];

  home.file = {
    ".config/emacs/init.el".source = ../config/emacs/init.el;
    ".config/fuzzel/fuzzel.ini".source = ../config/fuzzel/fuzzel.ini;
    ".config/niri/config.kdl".source = ../config/niri/config.kdl;
    ".config/waybar/config.jsonc".source = ../config/waybar/config.jsonc;
    ".config/waybar/style.css".source = ../config/waybar/style.css;
    ".config/waybar/power_menu.xml".source = ../config/waybar/power_menu.xml;
  };

  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+Tab" = "next_tab";
      "kitty_mod+Tab" = "previous_tab";
      "ctrl+Escape" = "goto_tab -1";
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 0";
      "cmd+c" = "copy_to_clipboard";
      "cmd+v" = "paste_from_clipboard";
    };
    settings = {
      font_size = 12;
      scrollback_lines = 10000;
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
      hide_window_decorations = "yes";
      clipboard_control = "write-clipboard write-primary no-append";
      macos_option_as_alt = "yes";
    };
  };
}
