{
  programs.tmux = {
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
}
