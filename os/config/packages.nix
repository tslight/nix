# https://nixos.org/nixos/packages.html?channel=nixos-19.09
{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    alttab
    ansible
    aqemu
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    azure-cli
    bc
    chez # scheme
    chromium
    clang
    clojure
    cmake
    cmatrix
    cmus
    cowsay
    curl
    dmenu
    docker
    docker-compose
    ed
    evtest
    exa
    firefox
    fortune
    gcc
    ghc
    gimp
    gitFull
    gksu
    gnupg
    go
    gparted
    hardinfo
    hplip
    htop
    hunspell
    hwinfo
    imagemagick
    inkscape
    inxi
    ispell
    jdk12
    jq
    leiningen # clojure manager
    libreoffice
    lilyterm
    llvm
    lm_sensors
    lshw
    maim
    mitscheme
    mlocate
    mpv
    mupdf
    ncdu
    neofetch
    neovim
    nix-bash-completions
    nmap
    nodejs-12_x
    powertop
    (python3.withPackages(ps: with ps; [
      conda
      pip
      ipython
      autopep8
      black
      flake8
      flask
      importmagic
      jedi
      jupyter
      requests
      rope
      setuptools
      twine
      virtualenv
      wheel
      yapf
      pylint
      xonsh
    ]))
    qbittorrent
    qemu
    qemu_kvm
    ranger
    redshift-plasma-applet
    rofi
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
    tlp
    tree
    virtmanager-qt
    vlc
    w3m
    wget
    wmctrl
    xautolock
    xclip
    xidlehook
    xorg.xev
    xorg.xinput
    xsel
    xterm
    zathura
    zip unzip
  ];
}
