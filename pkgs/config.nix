{
  packageOverrides = pkgs: with pkgs; {
    # https://github.com/nix-community/NUR/#installation
    # https://gitlab.com/rycee/nur-expressions
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        ansible
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        azure-cli
        brave # https://github.com/brave/brave-browser/issues/1986
        # chez # choose between this and mitscheme
        chromium
        clojure
        curl
        docker
        docker-compose
        # emacs # should be handled by home-manager
        exa
        fast-cli
        # firefox # should be handled by home-manager
        gimp
        # gitFull # should be handled by home-manager
        go
        hardinfo
        home-manager
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
        next
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
        # tmux # should be handled by home-manager
        tree
        w3m
        youtube-dl
        zathura
      ];
    };
  };
}
