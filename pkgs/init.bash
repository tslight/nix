complete -cf sudo     # completion after sudo
complete -cf man      # same, but for man

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

red="\\[\\e[1;31m\\]"
grn="\\[\\e[1;32m\\]"
yel="\\[\\e[1;33m\\]"
mag="\\[\\e[1;35m\\]"
cyn="\\[\\e[1;36m\\]"
res="\\[\\e[0m\\]"

if [ "$(id -u)" -eq 0 ]; then
    export PS1="''${red}\\u''${yel}@''${red}\\h''${yel}:''${mag}\\W ''${cyn}\''$(__git_ps1 '(%s)')\\n''${yel}\''$? \''$ ''${res}"
else
    export PS1="''${grn}\\u''${yel}@''${grn}\\h''${yel}:''${mag}\\W ''${cyn}\''$(__git_ps1 '(%s)')\\n''${yel}\''$? \''$ ''${res}"
fi

stty -ixon # disable ctrl-s/q flow control

[ -f /usr/share/bash-completion/bash_completion ] && \
    source /usr/share/bash-completion/bash_completion
[ -f "$HOME"/.functions ] && source "$HOME"/.functions

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/toby/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/toby/conda/etc/profile.d/conda.sh" ]; then
	. "/home/toby/conda/etc/profile.d/conda.sh"
    else
	export PATH="/home/toby/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[ -f "$HOME/.z.sh" ] && source "$HOME/.z.sh"

case "$(lsb_release -is)" in
    Debian)
	alias update="sudo apt -t $(lsb_release -cs)-backports update -y && sudo apt -t $(lsb_release -cs)-backports dist-upgrade -y"
	alias install="sudo apt -t $(lsb_release -cs)-backports -y"
	;;
    Ubuntu)
	alias update="sudo apt update -y && sudo apt dist-upgrade -y"
	alias install="sudo apt install -y"
	;;
    Debian|Ubuntu)
	alias clean="sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y"
	alias purge="sudo apt purge -y"
	;;
esac

# https://github.com/areina/stumpwm.d/blob/master/applications.lisp
tmux_create_or_attach () {
    [ -z "$TMUX" ] && \
	{ tmux -q has-session && tmux attach -d || tmux -u; } || \
	    { tmux new-session -d \; choose-tree -Zs; }
}
