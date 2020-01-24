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
        alttab
        ansible
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        azure-cli
        bat
        brave # https://github.com/brave/brave-browser/issues/1986
        # chez # choose between this and mitscheme
        clojure
        curl
        dmenu
        docker
        docker-compose
        exa
        evtest
        fast-cli
        fontconfig
        gimp
        go
        hack-font
        hardinfo
        home-manager
        htop
        hunspell
        glibcLocales
        inxi
        ispell
        jq
        lilyterm
        lispPackages.stumpwm
        maim
        mitscheme # choose between this and chez
        mlocate
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
        profont
        proggyfonts
        qbittorrent
        ranger
        rsync
        rtorrent
        sbcl
        sct
        shellcheck
        sl
        slock
        st
        sxiv
        terminus_font
        terminus_font_ttf
        terraform
        # texlive.combined.scheme-full
        # texlive.combined.scheme-medium
        # texlive.combined.scheme-small
        # texlive.combined.scheme-tetex
        texlive.combined.scheme-minimal
        tree
        w3m
        xautolock
        xclip
        xidlehook
        xorg.xev
        xorg.xinput
        xsel
        xterm
        youtube-dl
        zathura
        zip unzip
      ];
    };
  };
}
