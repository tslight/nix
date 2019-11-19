{ pkgs, ... }:
{
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

    # Shells
    bash_5
    bashInteractive_5
    bash-completion
    nix-bash-completions
    shellcheck
    zsh

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
    chromium
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
    gitFull
    gparted
    gnupg
    hplip
    mlocate
    tmux
    tree
    rsync

    # Monitoring
    htop
    ncdu
    powertop

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
    clang
    clojure
    cmake
    gcc
    go
    jdk12
    jq
    llvm
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
    sbcl

    # File Managers
    ranger
    spaceFM

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
