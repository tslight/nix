{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anon";
  home.homeDirectory = "/home/anon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
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
    pkgs.yazi # ranger
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/niri/config.kdl".source = dotfiles/niri.kdl;
    ".config/fuzzel/fuzzel.ini".source = dotfiles/fuzzel.ini;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
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
      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };
      # package.disabled = true;
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
  set -g message-style bg=default,fg=brightgreen
  set -g mode-style bg=default,fg=brightgreen
  set -g status-style bg=default,fg=brightgreen
  set -g window-status-style bold
  set -g window-status-current-style underscore,fg=brightyellow
  bind e neww -n fm yazi
  bind t neww -n top btm
'';
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
