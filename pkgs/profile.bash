if [ -d "$HOME/.nix-profile" ]; then
    export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
    #     if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    #         source "$HOME/.nix-profile/etc/profile.d/nix.sh"
    #     fi
fi

umask 022

[ -f "$HOME"/.bashrc ] && source "$HOME"/.bashrc

# startx on tty1 and logout when it xsession exits
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && { exec startx; logout; }
