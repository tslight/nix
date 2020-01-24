#!/usr/bin/env bash
# Pre-Requisites:
# Install curl, network-manager & sudo

# Then run:
# bash <(https://gitlab.com/tspub/devops/nix/raw/master/pkgs/bootstrap.sh)

usage() {
    echo "
USAGE: $(basename "$0") [OPTION]

  -A, --all
  -a  --ansible
  -c, --cleanup
  -d, --install-debs
  -I, --install-home-manager
  -h, --run-home-manager
  -n, --install-nix
  -p, --install-nixpkgs
  -s, --generate-ssh-keys
  -u, --uninstall-nix
"
}

chkcmd() {
    local cmd="$1"

    command -v "$cmd" &>/dev/null || source /etc/profile
}

cleanup() {
    rm -rf "$HOME"/{ansible,nix,secrets}
}

uninstall_nix() {
    sudo systemctl stop nix-daemon.socket
    sudo systemctl stop nix-daemon.service
    sudo systemctl disable nix-daemon.socket
    sudo systemctl disable nix-daemon.service
    sudo systemctl daemon-reload
    sudo mv /etc/profile.d/nix.sh.backup-before-nix /etc/profile.d/nix.sh
    sudo rm -rf /etc/nix /nix /root/.nix-profile /root/.nix-defexpr /root/.nix-channels /home/toby/.nix-profile /home/toby/.nix-defexpr /home/toby/.nix-channels
}

lazygit() {
    cp $HOME/secrets/config.json $HOME/src/tspub/js/lazygit/

    cd  $HOME/src/tspub/js/lazygit/ && \
	npm install && \
	npm link

    lazygitlab
}

run_ansible_scripts() {
    local -a playbooks url="git@gitlab.com:tspub/devops/ansible"
    playbooks=(
	agnostic
	apt
    )

    [ -d "$HOME"/ansible ] || git clone "$url" "$HOME"/ansible

    read -resp "Enter sudo password: " PASS

    chkcmd ansible-playbook

    for p in "${playbooks[@]}"; do
	ansible-playbook -i "$HOME/ansible/hosts" "$HOME/ansible/$p.yml" \
			 --extra-vars "ansible_become_pass=\"$PASS\""
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
	yes | sh <(curl https://nixos.org/nix/install) --daemon
    fi

    source /etc/profile
    sudo -i nix-channel --update nixpkgs

    chkcmd nix-channel && \
	nix-channel --update nixpkgs && \
	nix-channel --update

    echo "If the rest of this script fails, try logging out & back in again..."
}

generate_ssh_keys() {
    # https://unix.stackexchange.com/a/135090
    # cat /dev/zero | ssh-keygen -q -N ""
    # https://unix.stackexchange.com/a/69318
    ssh-keygen -t rsa -f "$HOME"/.ssh/id_rsa -q -N "" # 0>&- # don't overwrite without prompt

    command -v xclip &>/dev/null || sudo apt install xclip
    xclip < "$HOME"/.ssh/id_rsa.pub
    echo; cat "$HOME"/.ssh/id_rsa.pub

    printf "
    The key above has been copied to your clipboard.
    Paste it into the form at https://gitlab.com/profile/keys
    \n" && read -n1 -rs -p "Press any key to continue..." key && echo
}

get_secrets() {
    git clone https://gitlab.com/tsprv/devops/secrets $HOME/secrets
    [ -d $HOME/.ssh ] || mkdir m 700  $HOME/.ssh
    cp $HOME/secrets/id_rsa* $HOME/.ssh/ && \
	chmod 600 $HOME/.ssh/id_rsa && \
	echo "Successfully copied ssh keys."
}

install_debs() {
    local -a debs
    debs=(curl git rsync)
    sudo apt update
    for d in "${debs[@]}"; do
	command -v "$d" &>/dev/null || sudo apt install "$d"
    done
}

all() {
    install_debs && \
	# generate_ssh_key && \
	get_secrets && \
	    install_nix && \
	    install_nixpkgs && \
	    install_home_manager && \
	    run_home_manager && \
	    run_ansible_scripts && \
	    lazygit
    # cleanup
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
	    -s|--get-secrets)
		# generate_ssh_keys
		get_secrets
		;;
	esac
    done
}

[[ "${#@}" -eq 0 ]] && usage || main "$@"
