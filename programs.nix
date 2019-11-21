{ pkgs, ... }: {
  programs = {

    bash = {
      enableCompletion = true;
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

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

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

    thefuck.enable = true;

    tmux = {
      enable = true;
      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 42000;
      newSession = true;
      terminal = "screen-256color";
      extraTmuxConf = ''
        set -g display-panes-time 4000
        set -g mouse on
        bind -n MouseDown2Status copy-mode
        # copy to system clipboard using xsel
        bind -T copy-mode C-w send -X copy-pipe-and-cancel "xsel -i -b"
        bind -T copy-mode w send -X copy-pipe "xsel -i -b"
        bind -T copy-mode MouseDragEnd1Pane send -X copy-pipe-and-cancel "xsel -i -b"
        bind -T copy-mode Space send -X begin-selection
        bind -T copy-mode k send -X copy-end-of-line "xsel -i -b"
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableGlobalCompInit = true;
      autosuggestions.enable = true;
      histSize = 42000;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = "agnoster";
        customPkgs = with pkgs; [
          pkgs.nix-zsh-completions
        ];
      };
      syntaxHighlighting.enable = true;
    };
  };
}
