#!/usr/bin/env bash
readonly SELFNAME=$(basename "$0")
readonly TMP_DEB_PKGS=(
    curl
    git
    rsync
    xclip
)

usage() {
    echo "
USAGE: $SELFNAME [OPTION]

  -A, --all
  -a  --ansible
  -c, --cleanup
  -d, --install-debs
  -n, --install-nix
  -p, --install-nixpkgs
  -s, --generate-ssh-keys
  -h, --help
"
}

chkcmd() {
    local cmd="$1"

    command -v "$cmd" &>/dev/null || source /etc/profile
}

cleanup() {
    sudo apt purge "${TMP_DEB_PKGS[@]}" && \
	sudo apt autoremove && \
	sudo apt autoclean && \
	sudo apt clean
    rm -rf "$HOME"/{nix,ansible}
}

run_ansible_scripts() {
    local -a playbooks url="git@gitlab.com:tspub/devops/ansible"
    playbooks=(
	agnostic
	apt
    )

    [ -d "$HOME"/ansible ] || git clone "$url" "$HOME"/ansible

    chkcmd ansible-playbook

    for p in "${playbooks[@]}"; do
	ansible-playbook -i "$HOME/ansible/hosts" --ask-become-pass "$HOME/ansible/$p.yml"
    done

    source "$HOME"/{.profile,.bash_profile,.bashrc}
}

run_home_manager() {
    local -a dotfiles

    dotfiles=(
	bashrc
	bash_profile
	inputrc
	profile
    )

    for f in "${dotfiles[@]}"; do
	if [ -L "$HOME/.$f" ]; then
	    echo "$HOME/.$f is already a symlink. Not moving."
	else
	    [ -f "$HOME/.$f" ] && mv "$HOME/.$f"{,.bak}
	fi
    done

    chkcmd home-manger
    home-manager switch
}

install_nixpkgs() {
    [ -d "$HOME"/nix ] || git clone git@gitlab.com:tspub/devops/nix "$HOME"/nix

    if [ -d "$HOME"/.config/nixpkgs ]; then
	echo "$HOME/.config/nixpkgs already exists..."
    else
	[ -d "$HOME"/.config ] || mkdir -p "$HOME"/.config
	cp -r "$HOME"/nix/pkgs "$HOME"/.config/nixpkgs
    fi

    chkcmd nix-env
    nix-env -iA nixpkgs.myPackages
}

install_home_manager() {
    chkcmd nix-channel
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
}

install_nix() {
    if [ -d /nix ]; then
	echo "Existing Nix installation found at /nix. Aborting."
    else
	sh <(curl https://nixos.org/nix/install) --daemon
    fi

    source /etc/profile
}

generate_ssh_keys() {
    # https://unix.stackexchange.com/a/135090
    # cat /dev/zero | ssh-keygen -q -N ""
    # https://unix.stackexchange.com/a/69318
    ssh-keygen -t rsa -f "$HOME"/.ssh/id_rsa -q -N "" # 0>&- # don't overwrite without prompt

    xclip < "$HOME"/.ssh/id_rsa.pub
    echo; cat "$HOME"/.ssh/id_rsa.pub

    printf "
    The key above has been copied to your clipboard.
    Paste it into the form at https://gitlab.com/profile/keys
    \n" && read -n1 -rs -p "Press any key to continue..." key && echo
}

install_debs() {
    sudo apt update
    for p in "${TMP_DEB_PKGS[@]}"; do
	command -v "$p" &>/dev/null || sudo apt install "$p"
    done
}

all() {
    install_debs
    generate_ssh_key
    install_nix
    install_nixpkgs
    install_home_manager
    run_home_manager
    run_ansible_scripts
    cleanup
}

main() {
    for arg in "$@"; do
	case "$arg" in
	    -A|--all)
		all
		;;
	    -a|--run-ansible-scripts)
		run_ansible_scripts
		;;
	    -c|--cleanup)
		cleanup
		;;
	    -d|--install-debs)
		install_debs
		;;
	    -H|--install-home-manager)
		install_home_manager
		;;
	    -h|--run-home-manager)
		run_home_manager
		;;
	    -n|--install-nix)
		install_nix
		;;
	    -p|--install-nixpkgs)
		install_nixpkgs
		;;
	    -s|--generate-ssh-keys)
		generate_ssh_keys
		;;
	esac
    done
}

[[ "${#@}" -eq 0 ]] && usage || main "$@"
