{
  programs.readline = {
    enable = true;
    bindings = {
      "\\en" = "history-search-forward";
      "\\ep" = "history-search-backward";
      "\\em" = "\\C-a\\eb\\ed\\C-y\\e#man \\C-y\\C-m\\C-p\\C-p\\C-a\\C-d\\C-e";
      "\\eh" = "\\C-a\\eb\\ed\\C-y\\e#man \\C-y\\C-m\\C-p\\C-p\\C-a\\C-d\\C-e";
    };
    extraConfig = ''
      set show-all-if-ambiguous on
      set show-all-if-unmodified on
      set completion-ignore-case on
      '';
    includeSystemConfig = true;
  };
}
