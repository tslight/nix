{ ... }: {
  environment =  {
    variables = {
      BLOCK_SIZE = "human-readable";
      EDITOR = "emacsclient -c -nw";
      ALTERNATE_EDITOR = "";
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      PAGER = "less";
      GTK_THEME = "Emacs";
    };

    shellAliases = {
      bye = "systemctl poweroff";
      cp = "cp -i";
      d = "docker";
      df = "df -h";
      dh = "dirs -v";
      du = "du -h";
      enabled_services = "systemctl list-unit-files | grep enabled";
      h = "history";
      ha = "history 0";
      j = "jobs -l";
      lc = "grep -cv '^$'";
      ls = "ls --color=always";
      l = "ls -F";
      la = "ls -aF";
      ll = "ls -Fhl";
      lla = "ls -aFhl";
      m = "make";
      mc = "make clean";
      mi = "make install clean";
      mkdir = "mkdir -p";
      mv = "mv -i";
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
      sshaa = "eval $(ssh-agent) && ssh-add";
      t = "tmux attach";
      uc = "grep -Ev '^#|^\s+#|^\t+#|^$'";
      up = "uptime";
      update_nixos = "sudo nix-channel --update && sudo nixos-rebuild switch";
      zzz = "systemctl suspend";
      ZZZ = "systemctl hibernate";
    };
  };
}
