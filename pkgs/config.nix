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
        bc
        brave # https://github.com/brave/brave-browser/issues/1986
        # chez # choose between this and mitscheme
        clang # choose between this and gcc
        clojure
        cmake
        cmatrix
        cowsay
        curl
        dmenu
        docker
        docker-compose
        ed
        exa
        evtest
        fast-cli
        fontconfig
        gimp
        # gcc # can't have both this and clang
        ghc
        gnupg
        go
        gparted
        hack-font
        hardinfo
        home-manager
        htop
        hunspell
        hwinfo
        glibcLocales
        imagemagick
        inxi
        ispell
        jdk12
        jq
        leiningen # clojure manager
        libreoffice
        lilyterm
        llvm
        lispPackages.stumpwm
        maim
        mitscheme # choose between this and chez
        mlocate
        mpv
        mupdf
        ncdu
        neofetch
        neovim
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
        ruby
        rustc
        rxvt_unicode-with-plugins
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
