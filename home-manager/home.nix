# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ...}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "toby";
    homeDirectory = "/home/toby";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.aspell
    pkgs.cowsay
    pkgs.curl
    pkgs.emacs29-pgtk
    pkgs.gnumake
    pkgs.godef
    pkgs.golangci-lint
    pkgs.gopls
    pkgs.gptfdisk
    pkgs.hunspell
    pkgs.ispell
    pkgs.lf
    pkgs.python3Full
    pkgs.ncdu
    pkgs.rclone
    pkgs.rsync
    pkgs.terraform
    pkgs.wget
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

  programs.go = {
    enable = true;
    goBin = ".local/bin.go";
    goPath = "go";
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/toby/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    NIX_CONFIG = "experimental-features = nix-command flakes";
    EDITOR = "emacsclient -nw -c";
    ALTERNATE_EDITOR = "";
    PAGER = "less";
    GTK_THEME = "Emacs";
    BLOCK_SIZE = "human-readable";
    DIRSTACKSIZE = 12;
    KEYTIMEOUT = 1;
    EMPLOYER = "oe-developers";
    DEVPATH = "$HOME/$EMPLOYER";
    PATH = "$PATH:$GOPATH/bin";
  };

  home.shellAliases = {
    cp = "cp -i";
    df = "df -h";
    dh = "dirs -v";
    du = "du -h";
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

  gtk.enable = true;
  gtk.gtk2.extraConfig = ''gtk-key-theme-name = "Emacs"'';
  gtk.gtk3.extraConfig = {
    gtk-key-theme-name = "Emacs";
    gtk-application-prefer-dark-theme = 1;
  };
  gtk.gtk4.extraConfig = {
    gtk-key-theme-name = "Emacs";
    gtk-application-prefer-dark-theme = 1;
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    bashrcExtra = ''
complete -cf sudo     # completion after sudo
complete -cf man      # same, but for man
stty -ixon # disable ctrl-s/q flow control
command -v kubectl &>/dev/null && source <(kubectl completion bash)
RED="\\[\\e[1;31m\\]"
GRN="\\[\\e[1;32m\\]"
YEL="\\[\\e[1;33m\\]"
MAG="\\[\\e[1;35m\\]"
CYN="\\[\\e[1;36m\\]"
OFF="\\[\\e[0m\\]"
if [ "$(id -u)" -eq 0 ]; then
    export PS1="''${RED}\\u''${YEL}@''${RED}\\h''${YEL}:''${MAG}\\W \\n''${YEL}\$? \$ ''${OFF}"
else
    export PS1="''${GRN}\\u''${YEL}@''${GRN}\\h''${YEL}:''${MAG}\\W \\n''${YEL}\$? \$ ''${OFF}"
fi
    '';
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

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    userName  = "Toby Slight";
    userEmail = "tslight@pm.me";
    aliases = {
      l = "log --graph --decorate --pretty=oneline --abbrev-commit";
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
    extraConfig = ''
set autochdir                             "silently change directory for each file
set autoindent                            "retain indentation on next lines
set autoread                              "reload when ext changes detected
set autowriteall                          "auto save when switching buffers
set backspace=indent,eol,start            "allow backspace past indent & eol
set backup                                "turn backups on
set backupdir=~/.cache                    "set backup directory
set clipboard=unnamedplus                 "allow copy/pasting to clipboard
set directory=~/.cache                    "set swap file directory
set expandtab                             "make tabs spaces
set history=4242                          "increase history
set hlsearch                              "highlight all matches
set ignorecase                            "ignore case in all searches...
set incsearch                             "lookahead as search is specified
set nohlsearch                            "turn off search highlight
set nomousehide                           "stop cursor from disappearing
set nowrap                                "turn line wrap off
set relativenumber                        "relative line numbers are awesome
set ruler                                 "turn on line & column numbers
set scrolloff=5                           "scroll when 5 lines from bottom
set shiftround                            "always indent to nearest tabstop
set shiftwidth=4                          "backtab size
set showcmd                               "display incomplete commands
set smartcase                             "unless uppercase letters used
set smartindent                           "turn on autoindenting of blocks
set smarttab                              "use shiftwidths only at left margin
set softtabstop=4                         "soft space size of tabs
set spelllang=en_gb                       "spellcheck language
set tabstop=4                             "space size of tabs
set undodir=~/.cache                      "set undo file directory
set undofile                              "turn undos on
set undolevels=4242                       "how far back to go
set wildchar=<tab> wildmenu wildmode=full "more verbose command tabbing
set wildcharm=<c-z>                       "plus awesome wildcard matching

let mapleader = " "

cmap w!! w !sudo tee %<cr>
map <leader>sv :source $MYVIMRC<CR>
map <leader><space> :b#<cr>
map <leader>b :b<space>
map <leader>d :bd<cr>
map <leader>i ggVG=<c-o><c-o>
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>e :e<space>
map <leader>w :wall<cr>
map <leader>q :q!<cr>
map <leader>tc :tabnew<cr>
map <leader>td :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>
map <leader>tt :tablast<cr>
'';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

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
    historySubstringSearch.searchDownKey = [
      "^[[B"
    ];
    historySubstringSearch.searchUpKey = [
      "^[[A"
    ];
    initExtra = ''
unsetopt flow_control         # stty ixon doesn't work, but this does.
unsetopt completealiases      # supposedly allows aliases to be completed, but
                              # I turn it off because it breaks mine..
ttyctl -f                     # avoid having to manually reset the terminal

bindkey '^[[Z' reverse-menu-complete # shift-tab cycles backwards
bindkey \^U backward-kill-line # ctrl-u (whole-line by default)

# Alt-n & Alt-p to search history using current input
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\ep' history-beginning-search-backward-end
bindkey '\en' history-beginning-search-forward-end

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' # emacs tramp workaround

if [ -n "$INSIDE_EMACS" ]; then
    chpwd() { print -P "\033AnSiTc %d" }
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
fi

command -v kubectl &>/dev/null && source <(kubectl completion zsh)

prompt_vcs_setup () {
    zstyle ':vcs_info:*' enable git svn
    zstyle ':vcs_info:git:*' formats '%B%F{cyan}(%b)%f'

    autoload -Uz vcs_info

    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )

    setopt prompt_subst

    local user_at_host="%B%F{green}%n%B%F{yellow}@%B%F{green}%m%b%f"
    local cwd="%B%F{yellow}:%F{magenta}%1~%b%f"
    local git_branch=\$vcs_info_msg_0_
    local exit_status="%B%(?.%F{yellow}√.%F{red}%?)"
    local priv="%B%F{yellow}%#%b%f"

    PS1="''${user_at_host}''${cwd} ''${git_branch}"$'\n'"''${exit_status} ''${priv} "
    PS2="> "

    prompt_opts=( cr percent )
}

prompt_vcs_setup "$@"
    '';
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    package = pkgs.emacs29-pgtk;
  };

  programs.kitty.enable = true;
  programs.kitty.extraConfig = ''
font_size 12.0
scrollback_lines 10000
copy_on_select yes
strip_trailing_spaces smart
terminal_select_modifiers ctrl
hide_window_decorations yes
clipboard_control write-clipboard write-primary no-append
term xterm-256color
map ctrl+Tab        next_tab
map kitty_mod+Tab   previous_tab
map ctrl+Escape goto_tab -1
map ctrl+equal      change_font_size all +2.0
map ctrl+minus      change_font_size all -2.0
map kitty_mod+equal change_font_size all 0
'';

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


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
