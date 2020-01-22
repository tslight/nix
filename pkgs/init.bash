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
    export PS1="${red}\\u${yel}@${red}\\h${yel}:${mag}\\W ${cyn}\$(__git_ps1 '(%s)')\\n${yel}\$? \$ ${res}"
else
    export PS1="${grn}\\u${yel}@${grn}\\h${yel}:${mag}\\W ${cyn}\$(__git_ps1 '(%s)')\\n${yel}\$? \$ ${res}"
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

if echo "$0" | grep -q bash; then
    if [ -d "$HOME"/bin/lib/bash ]; then
	for f in "$HOME"/bin/lib/bash/*; do
	    source "$f"
	done
    fi
fi

# https://github.com/areina/stumpwm.d/blob/master/applications.lisp
tmux_create_or_attach () {
    [ -z "$TMUX" ] && \
	{ tmux -q has-session && tmux attach -d || tmux -u; } || \
	    { tmux new-session -d \; choose-tree -Zs; }
}

bzipr () {
    for dir in "$1"; do
	base=$(basename "$dir")
	tar cvjf "${base}.tar.bz2" "$dir"
    done
}

cdot () {
    for x in $(seq "$1"); do
	cd ..
    done
}

calc () {
    echo "scale=3;$@" | bc -l
}

cheat () {
    curl cheat.sh/${1:-cheat};
}

dos2unix_recursive () {
    find "$1" -type f\
	    -exec grep -Ilq "" {} \; \
	    -exec dos2unix {} \;
}

dusort () {
    # d1 = depth 1, sort -hr = human-readable & reverse
    du -hd1 "$1" | sort -hr
}

fixperms () {
    local path=$(eval echo "${3//>}") # santize input so find doesn't break on spaces or ~
    local -i fileperms="$2" dirperms="$1"
    find "$path" -type d -exec chmod "$dirperms" {} \;
    find "$path" -type f -exec chmod "$fileperms" {} \;
}

mkcd () {
    mkdir -p "$1" && cd "$1"
}

mtail () {
    trap 'kill $(jobs -p)' EXIT
    for file in "$@"; do
	tail -f "$file" &
    done
    wait
}

tmux_peek () {
    tmux split-window -h -p 48 "$PAGER" "$@" || exit
}

pgrepkill () {
    if pid=($(pgrep -i "$1")); then
	for p in "${pid[@]}"; do
	    if ps -p "$p" &> /dev/null; then
		echo "Killing $1 process: $p"
		sudo kill -9 "$p"
	    fi
	done
    else
	echo "No $1 processes found."
    fi
}

psee () {
    tput setaf 3
    printf "\nYou should probably be using $(tput setaf 6)pgrep -ail$(tput setaf 3)...\n\n"
    tput sgr0
    local char="${1:0:1}" rest="${1:1}"
    ps aux | grep -i "[$char]$rest" | awk '{printf ("%s %i %s %s\n", $1, $2, $9, $11)}'
    echo
}

rssget () {
    curl "$1" | grep -E "http.*\.$2" | sed "s/.*\(http.*\.$2\).*/\1/" | xargs wget -nc
}

tv() {
    tmux new-session \; \
	    split-window -v ranger\; \
	    split-window -v htop\; \
	    select-pane -t 1 \; \
	    split-window -v pwsh\; \
	    split-window -h ipython\; \
	    select-pane -t 1 \; \
	    split-window -h\;
}

th() {
    tmux new-session \; \
	    split-window -h ipython3\; \
	    split-window -v\; \
	    select-pane -t 1 \; \
	    split-window -v node\; \
	    new-window -n fm ranger\; \
	    select-window -t 1\; \
	    select-pane -t 1
}
