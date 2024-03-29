{ inputs, lib, config, pkgs, stateVersion, ...}: {
  imports = [];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = [
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-computers
    pkgs.aspellDicts.en-science
    pkgs.bat
    pkgs.cowsay
    pkgs.curl
    pkgs.exiftool
    pkgs.gnumake
    pkgs.gptfdisk
    pkgs.jq
    pkgs.killall
    pkgs.mg
    pkgs.ncdu
    pkgs.nixpkgs-fmt
    pkgs.nmap
    pkgs.ranger
    pkgs.rclone
    pkgs.rsync
    pkgs.tree
    pkgs.w3m
    pkgs.wget
    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionPath = [ "$HOME/bin" "$HOME/.local/bin" "$GOPATH/bin" ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1; # for nix-shell -p zoom-us, etc
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    NIX_CONFIG = "experimental-features = nix-command flakes";
    EDITOR = "emacsclient -nw -c";
    ALTERNATE_EDITOR = "";
    PAGER = "less";
    BLOCK_SIZE = "human-readable";
    DIRSTACKSIZE = 12;
    KEYTIMEOUT = 1;
  };

  home.shellAliases = {
    cp = "cp -i";
    df = "df -h";
    dh = "dirs -v";
    du = "du -h";
    dropbox-c2d = "rclone sync dropbox: ~/Dropbox -P -v --exclude Vault/";
    dropbox-d2c = "rclone sync ~/Dropbox dropbox: -P -v --exclude Vault/";
    dropbox-mount = "rclone mount dropbox: ~/Dropbox --daemon --cache-dir ~/.cache/rclone --vfs-cache-mode full";
    g = "git";
    h = "history";
    ha = "history 0";
    j = "jobs -l";
    lc = "grep -cv '^$'";
    ls = "ls --color=always";
    l = "ls -F";
    la = "ls -aF";
    ll = "ls -Fhl";
    lla = "ls -aFhl";
    mkdir = "mkdir -p";
    mv = "mv -i";
    p = "pwd";
    pg = "pgrep -ail";
    ping4 = "ping -c 4";
    pingg = "ping -c 4 8.8.8.8";
    pip = "pip3";
    rm = "rm -i";
    srch = "sudo updatedb && locate -i";
    t = "tmux attach";
    uc = "grep -Ev '^#|^\s+#|^\t+#|^$'";
    up = "uptime";
  };

  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    bashrcExtra = builtins.readFile ./assets/bashrc;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyFileSize = 100000;
    historyIgnore = [
      "ls"
      "cd"
      "exit"
      "rm"
      "history"
    ];
    historySize = 100000;
    shellOptions = [
      "autocd"
      "cdspell"
      "checkjobs"
      "checkwinsize"
      "cmdhist"
      "dirspell"
      "dotglob"
      "extglob"
      "globstar"
      "histappend"
      "nocaseglob"
    ];
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.home-manager.enable = true;

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.go = { enable = true; goBin = ".local/bin.go"; goPath = "go"; };

  programs.git = {
    enable = true;
    userName  = "Toby Slight";
    userEmail = "tslight@pm.me";
    aliases = {
      a = "add";
      c = "commit -m";
      d = "diff";
      l = "log --graph --decorate --pretty=oneline --abbrev-commit";
      s = "status";
      p = "pull";
      P = "push";
    };
    ignores = [
      ".DS_Store"
      ".localized"
      "desktop.ini"
      "*.swp"
      "*~"
      "#*#"
      "#*"
      "TAGS"
      "tags"
    ];
    extraConfig = {
      core = {
        autocrlf = false;
        whitespace = "trailing-space,space-before-tab";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./assets/init.vim;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.readline.enable = true;
  programs.readline.bindings = {
    "\\en" = "history-search-forward";
    "\\ep" =  "history-search-backward";
    "\\em" = "\\C-a\\eb\\ed\\C-y\\e#man \\C-y\\C-m\\C-p\\C-p\\C-a\\C-d\\C-e";
    "\\eh" = "\\C-a\\eb\\ed\\C-y\\e#man \\C-y\\C-m\\C-p\\C-p\\C-a\\C-d\\C-e";
  };
  programs.readline.extraConfig = ''
    set bell-style none
    set show-all-if-ambiguous on
    set show-all-if-unmodified on
    set completion-ignore-case on
    set keyseq-timeout 1200
    set colored-stats on
    set colored-completion-prefix on
  '';

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    extraConfig = ''
      set -g message-style bg=default,fg=brightgreen
      set -g mode-style bg=default,fg=brightgreen
      set -g status-style bg=default,fg=brightgreen
      set -g window-status-style bold
      set -g window-status-current-style underscore,fg=brightyellow
      set -g window-status-format "#I:#{pane_current_path}"
    '';
    historyLimit = 100000;
    keyMode = "emacs";
    mouse = true;
    newSession = true;
    terminal = "screen-256color";
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    cdpath = [
      "$HOME"
      "$HOME/src"
      "$HOME/$EMPLOYER"
      "$cdpath"
    ];
    completionInit = ''
      autoload -Uz compinit && compinit -u
      autoload -Uz bashcompinit && bashcompinit
      autoload -Uz colors && colors             # colour library
      autoload -Uz zmv                          # batch rename library
      # autoload -Uz promptinit && promptinit && prompt vcs
      autoload -Uz history-search-end
    '';
    defaultKeymap = "emacs";
    dirHashes = {
      src = "$HOME/src";
      wrk = "$HOME/$EMPLOYER";
    };
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    history.expireDuplicatesFirst = true;
    history.extended = true;
    history.ignoreDups = true;
    history.ignorePatterns = [
      "ls *"
      "rm *"
      "pkill *"
    ];
    history.ignoreSpace = true;
    history.path = "$ZDOTDIR/.zsh_history";
    history.save = 100000;
    history.share = true;
    history.size = 100000;
    historySubstringSearch.enable = true;
    historySubstringSearch.searchDownKey = ["^[[B"];
    historySubstringSearch.searchUpKey = ["^[[A"];
    initExtra = builtins.readFile ./assets/zshrc;
  };

  home.stateVersion = stateVersion;
}
