{ packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        ansible
        azure-cli
        chez
        chromium
        clojure
        docker
        docker-compose
        emacs
        exa
        fast-cli
        firefox
        gitFull
        go
        htop
        jq
        lispPackages.stumpwm
        mpv
        ncdu
        neovim
        neofetch
        nix-bash-completions
        nix-zsh-completions
        peek
        powershell
        ranger
        terraform
        tmux
        youtube-dl
      ];
    };
  };
}
