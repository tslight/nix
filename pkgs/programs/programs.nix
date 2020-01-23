{ pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      userName  = "Toby Slight";
      userEmail = "tslight@pm.me";
      aliases = {
        a = "add";
        aa = "add -A";
        ba = "branch -a";
        bd = "branch -d";
        b = "branch";
        c = "commit";
        ca = "commit -a";
        cl = "clone";
        cm = "commit -m";
        co = "checkout";
        l = "log --graph --decorate --pretty=oneline --abbrev-commit";
        m = "merge";
        P = "pull";
        p = "push";
        pa = "push --all -u";
        pm = "push origin master";
        po = "push origin";
        rb = "rebase";
        rv = "revert";
        r = "remote";
        s = "status";
        ua = "remote set-url --add --push origin";
        ud = "remote set-url --delete --push origin";
      };
      ignores = [
        "*~"
        "*.swp"
      ];
      extraConfig = {
        core = {
          autocrlf = false;
          whitespace = "trailing-space,space-before-tab";
        };
      };
    };

    man.enable = false;

    readline = {
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

    tmux = {
      enable = true;
      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 42000;
      keyMode = "emacs";
      newSession = true;
      shortcut = "b";
      terminal = "screen-256color";
      extraConfig = builtins.readFile(./assets/tmux.conf);
    };
  };
}
