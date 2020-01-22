# https://rycee.gitlab.io/home-manager/options.html
{ pkgs, ... }:

{
  # https://github.com/rycee/home-manager/issues/432
  home.extraOutputsToInstall = [ "man" ];
  programs.man.enable = false;

  gtk.gtk2.extraConfig = ''
      gtk-key-theme-name = "Emacs"
    '';

  gtk.gtk3.extraConfig = ''
      [Settings]
      gtk-key-theme-name = Emacs
    '';

  programs = {
    bash = {
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

      initExtra = builtins.readFile(./init.bash);
      profileExtra = builtins.readFile(./profile.bash);

      sessionVariables = {
        BLOCK_SIZE = "human-readable";
        EDITOR = "emacsclient -c -nw";
        ALTERNATE_EDITOR = "";
        GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
        PAGER = "less";
        GTK_THEME = "Emacs";
        GOPATH = "$HOME/go";
        ANSIBLE = "$HOME/src/tspub/devops/ansible";
        DEVPATH = "$HOME/src/oe-developers";
        DEVOPS = "$HOME/src/oe-developers/be/devops";
        PATH = "$HOME/conda/bin:$HOME/.local/bin:$DEVOPS/bin:$HOME/bin:$PATH";
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
      };

      shellAliases = {
        bye = "systemctl poweroff";
        cp = "cp -i";
        d = "docker";
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

    emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.ace-window
        epkgs.ansible
        epkgs.ansible-doc
        epkgs.async
        epkgs.avy
        epkgs.change-inner
        epkgs.cider
        epkgs.clojure-mode
        epkgs.clojure-snippets
        epkgs.company
        epkgs.company-go
        epkgs.company-terraform
        epkgs.counsel
        epkgs.counsel-projectile
        epkgs.diminish
        epkgs.docker
        epkgs.dockerfile-mode
        epkgs.dot-mode
        epkgs.emmet-mode
        epkgs.exec-path-from-shell
        epkgs.expand-region
        epkgs.flx
        epkgs.flycheck
        epkgs.git-timemachine
        epkgs.gitlab-ci-mode
        epkgs.go-mode
        epkgs.hungry-delete
        epkgs.ibuffer-vc
        epkgs.iedit
        epkgs.ivy
        epkgs.jedi
        epkgs.js2-mode
        epkgs.js2-refactor
        epkgs.json-mode
        epkgs.json-navigator
        epkgs.magit
        epkgs.markdown-mode
        epkgs.nix-mode
        epkgs.nodejs-repl
        epkgs.org-journal
        epkgs.paredit
        epkgs.powershell
        epkgs.projectile
        epkgs.py-autopep8
        epkgs.python-mode
        epkgs.restclient
        epkgs.slime
        epkgs.slime-company
        epkgs.smex
        epkgs.ssh-agency
        epkgs.systemd
        epkgs.terraform-mode
        epkgs.undo-tree
        epkgs.use-package
        epkgs.web-mode
        epkgs.wgrep
        epkgs.which-key
        epkgs.yaml-mode
        epkgs.yasnippet
        epkgs.yasnippet-snippets
      ];
    };

    # https://gitlab.com/rycee/nur-expressions
    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        https-everywhere
        privacy-badger
        ublock-origin
        vim-vixen
      ];
    };

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
      extraConfig = builtins.readFile(./tmux.conf);
    };
  };
}
