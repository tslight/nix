if [ -d "$HOME/.nix-profile" ]; then
    export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
fi

umask 022

# startx on tty1 and logout when it xsession exits
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && { exec startx; logout; }
