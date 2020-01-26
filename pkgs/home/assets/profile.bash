umask 022

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

# startx on tty1 and logout when it xsession exits
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && { exec startx; logout; }
