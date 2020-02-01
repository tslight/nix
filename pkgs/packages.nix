pkgs: with pkgs; [
  alsaTools
  alsaUtils
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
  broot
  # chez # choose between this and mitscheme
  # chromium
  clang # choose between this and gcc
  clojure
  cmake
  cmatrix
  cmus
  cowsay
  curl
  dmenu
  docker
  docker-compose
  dpkg
  ed
  emacs
  evtest
  exa
  fast-cli
  # firefox
  fontconfig
  fortune
  # gcc # can't have both this and clang
  ghc
  gimp
  gitFull
  gksu
  glibcLocales
  gnupg
  # go
  gparted
  hack-font
  hardinfo
  home-manager
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
  # lispPackages.clx-truetype
  # lispPackages.quicklisp
  # lispPackages.quicklisp-to-nix
  # lispPackages.quicklisp-to-nix-system-info
  # lispPackages.stumpwm
  # lispPackages.swank
  # lispPackages.xembed
  llvm
  lm_sensors
  lshw
  lxmenu-data
  maim
  mitscheme
  mitscheme # choose between this and chez
  mlocate
  mpv
  mupdf
  ncdu
  neofetch
  neovim
  next
  nix
  nix-bash-completions
  nix-prefetch-scripts
  nix-zsh-completions
  nixops
  nixpkgs-lint
  nmap
  # nodejs-13_x # using nvm for this still...
  peek
  physlock
  powershell
  powertop
  qbittorrent
  qemu
  qemu_kvm
  ranger
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
  # slock # doesn't work when not on NixOS
  st
  sxiv
  terminus_font
  terminus_font_ttf
  terraform
  # texlive.combined.scheme-full
  # texlive.combined.scheme-medium
  # texlive.combined.scheme-minimal
  # texlive.combined.scheme-small
  # texlive.combined.scheme-tetex
  tlp
  tmux
  tree
  # unixODBCDrivers.msodbcsql17
  unzip
  virtmanager-qt
  vlc
  vlock
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
  youtube-dl
  zathura
  zip
]
