# https://nixos.org/nixos/manual/options.html
{ pkgs, ... }: {
  programs = {
    # autojump.enable = true;

    bash = {
      enableCompletion = true;
      loginShellInit = ''
        export HISTCONTROL=ignoreboth:erasedups
        export HISTFILESIZE=999999
        export HISTSIZE=999999
        export HISTIGNORE="h:history:[bf]g:exit:^ll$:^lla$:^ls$"
        export HISTTIMEFORMAT="%h %d %H:%M:%S "
      '';
      interactiveShellInit = ''
        complete -cf sudo     # completion after sudo
        complete -cf man      # same, but for man

        shopt -s autocd       # cd without cd. who knew?
        shopt -s checkjobs    # don't exit if we still have jobs running
        shopt -s cdspell      # correct minor cd spelling errors
        shopt -s checkwinsize # update lines and columns when resizing
        shopt -s cmdhist      # save multi line cmds as one entry
        shopt -s dirspell     # correct directory spelling
        shopt -s dotglob      # show dotfiles when expanding
        shopt -s extglob      # enable extended pattern matching
        shopt -s histappend   # don't overwrite history file on exit
        shopt -s globstar     # pattern match ** in filename context
        shopt -s nocaseglob   # match filename case insensitively

        [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        stty -ixon # disable ctrl-s/q flow control
      '';
      promptInit = ''
        red="\\[\\e[1;31m\\]"
        grn="\\[\\e[1;32m\\]"
        yel="\\[\\e[1;33m\\]"
        mag="\\[\\e[1;35m\\]"
        cyn="\\[\\e[1;36m\\]"
        res="\\[\\e[0m\\]"

        if [ "$(id -u)" -eq 0 ]; then
            export PS1="$red\\u$yel@$red\\h$yel:$mag\\W $cyn\$(__git_ps1 '(%s)')\\n$yel\$? \$ $res"
        else
            export PS1="$grn\\u$yel@$grn\\h$yel:$mag\\W $cyn\$(__git_ps1 '(%s)')\\n$yel\$? \$ $res"
        fi
      '';
    };

    chromium = {
      enable = true;
      extensions = [
        "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
      # https://cloud.google.com/docs/chrome-enterprise/policies/
      # extraOpts = { }
    };

    command-not-found.enable = true;
    mtr.enable = true;

    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    iftop.enable = true;
    iotop.enable = true;
    less.enable = true;

    screen.screenrc = ''
      startup_message off
      hardstatus alwayslastline
      hardstatus string '%{= kG}[%{G}%H%? %1`%?%{g}][%= %{= kw}%-w%{+b yk} %n*%t%?(%u)%? %{-}%+w %=%{g}][%{B}%m/%d %{W}%C%A%{g}]'
      defscrollback 5000
      term screen-256color
      mousetrack on
      # set first screen window to #1, instead of #0
      bind c screen 1
      bind ^c screen 1
      bind 0 select 10
      screen 1
    '';

    slock.enable = true;

    spacefm = {
      enable = true;
      settings = {
        tmp_dir = "/tmp";
        terminal_su = "${pkgs.sudo}/bin/sudo";
        graphical_su = "${pkgs.gksu}/bin/gksu";
      };
    };

    sway = {
      enable = true;
      extraPackages = with pkgs; [
        xwayland
      ];
    };

    system-config-printer.enable = true;
    thefuck.enable = true;

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
      extraTmuxConf = ''
        set -g display-panes-time 4000
        set -g status-interval 60
        set -g status-left "[#S] "
        set -g status-left-length 50
        set -g status-right "%H:%M %a %d/%m/%y"
        set -g status-right-length 50
        set -g window-status-current-format "#I: #W.#P*"
        set -g mouse on
        bind -n MouseDown2Status copy-mode
        bind C-l switch-client -l
        bind C-c new-session
        bind C-x kill-session
        bind v split-window -h
        bind h split-window -v
        bind C-r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
        bind C neww -n cmus cmus
        bind e neww -n emacs 'emacsclient -nw -c -a ""'
        bind E neww -n emacs 'emacs -nw'
        bind H neww -n htop htop
        bind r neww -n fm ranger
        bind R neww -n sfm 'sudo ranger'
        bind M-r neww -n dl rtorrent
        bind S neww -n su 'sudo -s'
        bind t splitw -h -p 42 top
        # bind u copy-mode
        bind -n C-Space copy-mode
        bind -n M-Space display-panes
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n C-Up resize-pane -U 5
        bind -n C-Down resize-pane -D 5
        bind -n C-Left resize-pane -L 5
        bind -n C-Right resize-pane -R 5
        # copy to system clipboard using xsel
        bind -T copy-mode C-w send -X copy-pipe-and-cancel "xsel -i -b"
        bind -T copy-mode w send -X copy-pipe "xsel -i -b"
        bind -T copy-mode MouseDragEnd1Pane send -X copy-pipe-and-cancel "xsel -i -b"
        bind -T copy-mode Space send -X begin-selection
        bind -T copy-mode k send -X copy-end-of-line "xsel -i -b"
        # copy mode motion
        bind -T copy-mode b send -X cursor-left
        bind -T copy-mode f send -X cursor-right
        bind -T copy-mode n send -X cursor-down
        bind -T copy-mode p send -X cursor-up
        bind -T copy-mode a send -X start-of-line
        bind -T copy-mode e send -X end-of-line
        bind -T copy-mode [ send -X previous-paragraph
        bind -T copy-mode ] send -X next-paragraph
        bind -T copy-mode C-< send -X top-line
        bind -T copy-mode C-> send -X bottom-line
        bind -T copy-mode < send -X history-top
        bind -T copy-mode > send -X history-bottom
        # search pane
        bind -T copy-mode r command-prompt -i -I "#{pane_search_string}" -p "(search up)" "send -X search-backward-incremental \"%%%\""
        bind -T copy-mode s command-prompt -i -I "#{pane_search_string}" -p "(search down)" "send -X search-forward-incremental \"%%%\""
      '';
    };

    wireshark.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableGlobalCompInit = true;
      autosuggestions.enable = true;
      histSize = 42000;
      # interactiveShellInit = ''
      #   zstyle ':completion:*' menu select # arrow select
      #   zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # case insensitivity
      #   zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      #   zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,user,%cpu,tty,cputime,cmd'
      #   zstyle ':vcs_info:*' enable git svn

      #   autoload -U compinit && compinit -u  # completion library
      #   autoload -U colors && colors         # colour library
      #   autoload -U promptinit && promptinit # prompt library
      #   autoload -U vcs_info                 # version control library
      #   autoload -U zmv                      # batch rename library

      #   setopt auto_name_dirs         # absolute name becomes dir
      #   setopt autocd                 # cd without typing cd. omg.
      #   setopt chaselinks             # follow links in cd.
      #   setopt complete_in_word       # complete unique matches
      #   setopt completealiases        # allow aliases to be completed
      #   setopt correct                # allow me to be slack
      #   setopt extended_glob          # set awesome to max
      #   setopt hist_expire_dups_first # trim duplicates from file first
      #   setopt hist_find_no_dups      # when searching don't find duplicates
      #   setopt hist_ignore_all_dups   # don't store duplicates
      #   setopt hist_ignore_space      # don't store cmds that start with a space
      #   setopt hist_no_store          # don't store history cmds
      #   setopt inc_append_history     # immediately write cmd after enter
      #   setopt longlistjobs           # display PID when suspending processes as well
      #   setopt list_ambiguous         # complete until it gets ambiguous
      #   setopt magic_equal_subst      # expand inside equals
      #   setopt nobeep                 # stop harassing me
      #   setopt nonomatch              # try to avoid the 'zsh: no matches found...'
      #   setopt prompt_subst           # param expansion, cmd substitution, &  math
      #   unsetopt flow_control         # stty ixon doesn't work, but this does.
      #   ttyctl -f                     # avoid having to manually reset the terminal

      #   bindkey '^[[Z' reverse-menu-complete # shift-tab cycles backwards
      #   bindkey \^U backward-kill-line # ctrl-u (whole-line by default)

      #   [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' # emacs tramp workaround
      # '';
      # loginShellInit = ''
      #   export FPATH=$FPATH:$HOME/.zsh_functions
      #   export HISTFILE=$HOME/.zsh_history
      #   export HISTSIZE=4242
      #   export SAVEHIST=$HISTSIZE
      #   export DIRSTACKSIZE=12
      #   export KEYTIMEOUT=1
      #   export WORDCHARS=$\{WORDCHARS/\-\} # adds - to word delimiter
      #   export WORDCHARS=$\{WORDCHARS/\.\} # adds . to word delimiter
      #   export WORDCHARS=$\{WORDCHARS/\/\} # adds / to word delimiter
      # '';
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = "agnoster";
        customPkgs = with pkgs; [
          pkgs.nix-zsh-completions
        ];
      };
      vteIntegration = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
