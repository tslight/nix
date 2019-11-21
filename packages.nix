{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Virtual Machines
    aqemu
    qemu
    qemu_kvm
    virtmanager-qt

    # Office
    aspell
    hunspell
    ispell
    libreoffice
    # texlive.combined.scheme-full
    # texlive.combined.scheme-tetex
    # texlive.combined.scheme-medium
    # texlive.combined.scheme-small
    texlive.combined.scheme-minimal

    # Shells
    nix-bash-completions
    shellcheck

    # Terminal Emulators
    lilyterm
    rxvt_unicode-with-plugins
    st
    xterm

    # DevOps Utilities
    ansible
    docker
    docker-compose
    terraform

    # Web Browsers
    firefox
    w3m

    # Text Editors
    ed
    neovim
    (import ./emacs.nix { inherit pkgs; })

    # PDF Readers
    mupdf
    zathura

    # Miscellaneous
    bc
    evtest
    gparted
    gnupg
    hplip
    mlocate
    tree
    ranger
    rsync
    zip unzip

    # Monitoring
    htop
    lm_sensors
    ncdu
    powertop
    tlp

    # Hardware
    hardinfo
    hwinfo
    inxi
    lshw
    neofetch

    # Fun
    cmatrix
    cowsay
    fortune
    sl

    # Programming
    chez # scheme
    clang
    clojure
    cmake
    gcc
    gitFull
    go
    jdk12
    jq
    llvm
    mitscheme
    nodejs-12_x
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
    rustc
    sbcl

    # BitTorrent Clients
    qbittorrent
    rtorrent

    # Networking
    curl
    nmap
    wget
    wireshark

    # Media
    cmus
    vlc
    mpv

    # Graphics
    gimp
    imagemagick
    inkscape
    maim
    sxiv

    # Xorg Utilities
    alttab
    dmenu
    gksu
    rofi
    sct
    slock
    wmctrl
    xautolock
    xclip
    xidlehook
    xorg.xev
    xorg.xinput
    xsel
  ];
}
