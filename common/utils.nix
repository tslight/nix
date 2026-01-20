# Collection of NixOS/Darwin Agnostic CLI utilities
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat # cat
    bottom # top
    dua # ncdu with dua i
    dust # du
    dysk # df
    ed
    fastfetch
    fd # find
    fzf
    gcc
    git
    gnumake
    jless # json less
    jq
    lsd # ls
    mg
    neovim
    ripgrep # grep
    rsync
    tmux
    tokei # linecount
    wget
    yazi # ranger
  ];
}
