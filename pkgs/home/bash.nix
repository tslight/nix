{
  programs.bash = {
    enable = true;
    # enableAutojump = true;

    historyControl = [
      "erasedups"
      "ignorespace"
    ];
    historyFileSize = 999999;
    historyIgnore = [
      "h"
      "history"
      "ls"
      "cd"
      "exit"
    ];
    historySize = 999999;

    sessionVariables = {
      BLOCK_SIZE = "human-readable";
      EDITOR = "emacsclient -c -nw";
      ALTERNATE_EDITOR = "";
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      PAGER = "less";
      GTK_THEME = "Emacs";
      GOPATH = "$HOME/go";
      ANSIBLE = "$HOME/src/gitlab/tspub/devops/ansible";
      DEVPATH = "$HOME/src/oe-developers";
      DEVOPS = "$HOME/src/oe-developers/be/devops";
      PATH = "$HOME/conda/bin:$HOME/.local/bin:$DEVOPS/bin:$HOME/bin:$PATH";
      XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
      # LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive";
    };

    initExtra = builtins.readFile(./assets/init.bash);
    profileExtra = builtins.readFile(./assets/profile.bash);

    shellAliases = {
      bye = "systemctl poweroff";
      cat = "bat";
      cp = "cp -i";
      d = "docker";
      di = "docker images";
      dp = "docker ps";
      df = "df -h";
      dh = "dirs -v";
      du = "du -h";
      e = "emacs";
      ec = "emacsclient -c -a ''";
      enabled_services = "systemctl list-unit-files | grep enabled";
      g = "git";
      h = "history";
      ha = "history 0";
      j = "jobs -l";
      lc = "grep -cv '^$'";
      less = "bat";
      ls = "exa";
      l = "exa";
      la = "exa --all";
      ll = "exa --long --group --git";
      lla = "exa --long --group --git --all";
      llg = "exa --long --group --git --grid";
      lt = "exa --tree --group";
      llt = "exa --tree --long --group --git";
      llta = "exa --all --tree --long --group --git";
      lgf = "lazygitfind.sh";
      lgh = "lazygithub.sh";
      lghs = "lazygithub.sh status -s";
      lghp = "lazygithub.sh status pull";
      lgl = "lazygitlab";
      lgls = "lazygitlab --run status";
      lglf = "lazygitlab --run fetch-or-clone";
      m = "make";
      mc = "make clean";
      mi = "make install clean";
      mkdir = "mkdir -p";
      more = "bat";
      mv = "mv -i";
      nix-install = "nix-env -iA";
      nix-remove = "nix-env -e";
      nix-search = "nix-env -qaP";
      nix-update = "nix-channel --update && nix-env -u '*'";
      p = "pwd";
      pg = "pgrep -ail";
      ping4 = "ping -c 4";
      pingg = "ping -c 4 8.8.8.8";
      pip = "pip3";
      powertune = "sudo powertop --auto-tune";
      python = "python3";
      py = "python3";
      rb = "systemctl reboot";
      rm = "rm -i";
      srch = "sudo updatedb && locate -i";
      se = "sudoedit";
      sshaa = "eval $(ssh-agent) && ssh-add";
      t = "tmux_create_or_attach";
      tk = "tmux kill-session";
      tka = "tmux kill-session -a";
      uc = "grep -Ev '^#|^\s+#|^\t+#|^$'";
      up = "uptime";
      v = "vim";
      x = "exec; startx; logout";
      zzz = "systemctl suspend";
      ZZZ = "systemctl hibernate";
    };

    shellOptions = [
      "autocd"       # cd without cd. who knew?
      "checkjobs"    # don't exit if we still have jobs running
      "dirspell"     # correct directory spelling
      "globstar"     # pattern match ** in filename context
      "cdspell"      # correct minor cd spelling errors
      "checkwinsize" # update lines and columns when resizing
      "cmdhist"      # save multi line cmds as one entry
      "dotglob"      # show dotfiles when expanding
      "extglob"      # enable extended pattern matching
      "histappend"   # don't overwrite history file on exit
      "nocaseglob"   # match filename case insensitively
    ];
  };
}
