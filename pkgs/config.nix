{ packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        ansible
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        azure-cli
        # chez # choose between this and mitscheme
        chromium
        clojure
        curl
        docker
        docker-compose
        emacs
        exa
        fast-cli
        firefox
        gimp
        gitFull
        go
        hardinfo
        htop
        hunspell
        ispell
        jq
        lilyterm
        lispPackages.stumpwm
        maim
        mitscheme # choose between this and chez
        mpv
        mupdf
        ncdu
        neovim
        neofetch
        nix-bash-completions
        nix-zsh-completions
        nmap
        peek
        powershell
        qbittorrent
        ranger
        rsync
        rtorrent
        shellcheck
        sxiv
        terraform
        # texlive.combined.scheme-full
        # texlive.combined.scheme-medium
        # texlive.combined.scheme-small
        # texlive.combined.scheme-tetex
        texlive.combined.scheme-minimal
        tmux
        tree
        w3m
        youtube-dl
        zathura
      ];
    };
  };
}
