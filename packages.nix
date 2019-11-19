{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    aqemu qemu qemu_kvm
    ansible
    aspell
    bash_5
    bash-completion nix-bash-completions
    bc
    chromium
    cmake
    cmatrix
    cmus
    cowsay
    curl
    docker docker-compose
    ed
    evtest
    firefox
    fortune
    gimp
    gitFull
    gparted
    gnupg
    hardinfo
    hplip
    htop
    hunspell
    hwinfo
    imagemagick
    inkscape
    inxi
    ispell
    jq
    jwm
    libreoffice
    lilyterm
    lshw
    maim
    mlocate
    mpv
    mupdf
    ncdu
    neofetch
    neovim
    nmap
    jdk12
    powertop
    python3
    qbittorrent
    ranger
    ratpoison
    rsync
    rtorrent
    rxvt_unicode-with-plugins
    sakura
    sbcl
    scrot
    sct
    shellcheck
    sl
    slock
    slop
    spaceFM
    st
    sxiv
    terraform
    tmux
    tree
    virtmanager virtmanager-qt
    vlc
    w3m
    wget
    wmctrl
    wireshark
    xautolock
    xclip
    xidlehook
    xorg.xev
    xorg.xinput
    xsel
    xterm
    zathura
    zsh
  ];
}
