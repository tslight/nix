{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "anon";
  home.homeDirectory = "/home/anon";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.bat # cat
    pkgs.bottom # top
    pkgs.curl
    pkgs.dua # ncdu with dua i
    pkgs.dust # du
    pkgs.fd # find
    pkgs.jq
    pkgs.lsd # ls
    pkgs.lazygit
    pkgs.ripgrep # grep
    pkgs.tokei # linecount
    pkgs.wget
  ];

  home.sessionPath = [ "$HOME/bin" "$HOME/.local/bin" ];
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    EDITOR = "nvim";
    PAGER = "less";
    BLOCK_SIZE = "human-readable";
  };
  home.shellAliases = {
    cp = "cp -i";
    d = "docker";
    df = "df -h";
    du = "du -h";
    e = "emacs -nw";
    ec = "emacsclient -c -a '' -nw";
    g = "git";
    grep = "grep --color=always";
    h = "history";
    j = "jobs -l";
    k = "kubectl";
    lc = "tokei";
    l = "lsd";
    la = "lsd -a";
    ll = "lsd -l";
    lla = "lsd -la";
    lt = "lsd --tree";
    lg = "lazygit";
    m = "make";
    mkdir = "mkdir -p";
    mv = "mv -i";
    p = "pwd";
    pg = "pgrep -ail";
    ping4 = "ping -c 4";
    pingg = "ping -c 4 google.com";
    rm = "rm -i";
    se = "sudoedit";
    t = "tmux attach";
    tree = "lsd --tree";
    up = "uptime";
    vi = "nvim";
  };

  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyFileSize = 100000;
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

  programs.git = {
    enable = true;
    settings = {
      user.name  = "Toby Slight";
      user.email = "tslight@pm.me";
      alias = {
        a = "add";
        c = "commit -m";
        d = "diff";
        l = "log --graph --decorate --pretty=oneline --abbrev-commit";
        s = "status";
        f = "pull";
        p = "push";
      };
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
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = builtins.readFile ./dotfiles/init.lua;
  };

  programs.readline.enable = true;
  programs.readline.bindings = {
    "\\en" = "history-search-forward";
    "\\ep" =  "history-search-backward";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 100000;
    mouse = true;
    newSession = true;
    extraConfig = ''
  # For images in Yazi
  set -g allow-passthrough on
  set -ga update-environment TERM
  set -ga update-environment TERM_PROGRAM
  set -g message-style bg=default,fg=brightgreen
  set -g mode-style bg=default,fg=brightgreen
  set -g status-style bg=default,fg=brightgreen
  set -g window-status-style bold
  set -g window-status-current-style underscore,fg=brightyellow
  bind e neww -n fm yazi
  bind t neww -n top btm
'';
  };

  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) git;
      inherit (pkgs.yaziPlugins) lazygit;
    };
    initLua = ''require("git"):setup()'';
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "g" "i" ];
          run = "plugin lazygit";
          desc = "Run you Lazy Git!";
        }
      ];
    };
    settings = {
      mgr = {
        show_hidden = true;
        ratio = [ 1 2 5 ];
      };
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    cdpath = [
      "$HOME"
      "$HOME/src"
      "$cdpath"
    ];
    completionInit = ''
      autoload -Uz compinit && compinit -u
      autoload -Uz bashcompinit && bashcompinit
      autoload -Uz colors && colors
      autoload -Uz history-search-end
      '';
    defaultKeymap = "emacs";
    dirHashes = {
      src = "$HOME/src";
    };
    dotDir = config.xdg.configHome + "/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    history.expireDuplicatesFirst = true;
    history.extended = true;
    history.ignoreDups = true;
    history.ignorePatterns = [ "ls *" "rm *" ];
    history.ignoreSpace = true;
    history.path = "$ZDOTDIR/history";
    history.save = 100000;
    history.share = true;
    history.size = 100000;
    historySubstringSearch.enable = true;
    historySubstringSearch.searchDownKey = ["^[[B"];
    historySubstringSearch.searchUpKey = ["^[[A"];
  };
}
