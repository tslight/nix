{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Virtual Machines
    aqemu
    qemu
    qemu_kvm
    virtmanager
    virtmanager-qt

    # Office
    aspell
    hunspell
    ispell
    libreoffice

    # Shells
    bash_5
    bash-completion
    nix-bash-completions
    shellcheck
    zsh

    # Terminal Emulators
    lilyterm
    rxvt_unicode-with-plugins
    sakura
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

    # Text Editors
    ed
    neovim
    (import ./emacs.nix { inherit pkgs; })

    # PDF Readers
    mupdf
    zathura

    bc
    cmake
    cmatrix
    cmus
    cowsay
    curl
    evtest
    fortune
    gimp
    gitFull
    gparted
    gnupg
    hardinfo
    hplip
    htop
    hwinfo
    imagemagick
    inkscape
    inxi
    jq
    lshw
    maim
    mlocate
    mpv
    ncdu
    neofetch
    nmap
    jdk12
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
    ranger
    ratpoison
    rsync
    rtorrent
    sbcl
    scrot
    sct
    sl
    slock
    slop
    spaceFM
    sxiv
    tmux
    tree
    vlc
    w3m
    wget
    wmctrl
    wireshark

    # Xorg Utilities
    xautolock
    xclip
    xidlehook
    xorg.xev
    xorg.xinput
    xsel
  ];
}
