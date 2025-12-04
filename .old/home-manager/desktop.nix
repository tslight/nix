{ inputs, lib, config, pkgs, ...}: {
  imports = [./home.nix];
  programs.kitty.enable = true;
  programs.kitty.keybindings = {
    "ctrl+Tab" = "next_tab";
    "kitty_mod+Tab" = "previous_tab";
    "ctrl+Escape" = "goto_tab -1";
    "ctrl+equal" = "change_font_size all +2.0";
    "ctrl+minus" = "change_font_size all -2.0";
    "kitty_mod+equal" = "change_font_size all 0";
    "cmd+c" = "copy_to_clipboard";
    "cmd+v" = "paste_from_clipboard";
  };
  programs.kitty.settings = {
    font_size = 12;
    scrollback_lines = 10000;
    copy_on_select = "yes";
    strip_trailing_spaces = "smart";
    terminal_select_modifiers = "/ctrl";
    hide_window_decorations = "yes";
    clipboard_control = "write-clipboard write-primary no-append";
    term = "xterm-256color";
    macos_option_as_alt = "yes";
    tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
  };
}
