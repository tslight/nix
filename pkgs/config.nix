{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    # https://github.com/nix-community/NUR/#installation
    # https://gitlab.com/rycee/nur-expressions
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };

    # file = builtins.readFile(./use-melpa.el);
    # myEmacsConfig = writeText "default.el" file;
    myEmacs = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
      # (runCommand "default.el" {} ''
      #             mkdir -p $out/share/emacs/site-lisp
      #             cp ${myEmacsConfig} $out/share/emacs/site-lisp/default.el
      #             '')
      ace-window
      ansible
      ansible-doc
      async
      avy
      change-inner
      cider
      clojure-mode
      clojure-snippets
      company
      company-go
      company-terraform
      counsel
      counsel-projectile
      diminish
      docker
      dockerfile-mode
      dot-mode
      emmet-mode
      exec-path-from-shell
      expand-region
      flx
      flycheck
      git-timemachine
      gitlab-ci-mode
      go-mode
      hungry-delete
      ibuffer-vc
      iedit
      ivy
      jedi
      js2-mode
      js2-refactor
      json-mode
      json-navigator
      magit
      markdown-mode
      nix-mode
      nodejs-repl
      org-journal
      paredit
      powershell
      projectile
      py-autopep8
      python-mode
      restclient
      slime
      slime-company
      smex
      ssh-agency
      systemd
      terraform-mode
      # undo-tree
      undo-fu
      # undo-fu-session
      undohist
      use-package
      web-mode
      wgrep
      which-key
      yaml-mode
      yasnippet
      yasnippet-snippets
    ]));

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
        dpkg
        ed
        exa
        evtest
        fast-cli
        fontconfig
        gimp
        # gcc # can't have both this and clang
        ghc
        gnupg
        # go
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
        # lispPackages.clx-truetype
        # lispPackages.quicklisp
        # lispPackages.quicklisp
        # lispPackages.quicklisp-to-nix
        # lispPackages.quicklisp-to-nix-system-info
        lispPackages.stumpwm
        # lispPackages.swank
        # lispPackages.xembed
        maim
        mitscheme # choose between this and chez
        mlocate
        mpv
        mupdf
        myEmacs
        ncdu
        neofetch
        neovim
        next
        nix
        nix-bash-completions
        nix-zsh-completions
        nix-prefetch-scripts
        nixpkgs-lint
        nixops
        nmap
        peek
        physlock
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
        unixODBCDrivers.msodbcsql17
        vlock
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
