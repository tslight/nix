#!/usr/bin/env bash

TMP_DEB_PKGS=(
    curl
    git
    rsync
    xclip
)

cleanup() {
    sudo apt purge "${TMP_DEB_PKGS[@]}" && \
	sudo apt autoremove && \
	sudo apt autoclean && \
	sudo apt clean
    rm -rf $HOME/{nix,ansible}
}

run_ansible_scripts() {
    git clone git@gitlab.com:tspub/devops/ansible $HOME/ansible && \
	ansible-playbook -i $HOME/ansible/hosts $HOME/ansible/agnostic.yml && \
	ansible-playbook -i $HOME/ansible/hosts $HOME/ansible/apt.yml && \
	source $HOME/{.profile,.bash_profile,.bashrc}
}

install_nixpkgs() {
    git clone git@gitlab.com:tspub/devops/nix $HOME/nix && \
	mkdir -p $HOME/.config/nixpkgs && \
	cp $HOME/nix/pkgs/* $HOME/.config/nixpkgs/ && \
	source /etc/profile && \
	nix-env -iA nixpkgs.myPackages && \
	mv $HOME/.bashrc{,.bak} && \
	mv $HOME/.profile{,.bak} && \
	home-manager switch
}

install_nix() {
    sh <(curl https://nixos.org/nix/install) --daemon && \
	source /etc/profile && \
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager && \
	nix-channel --update
}

generate_ssh_key() {
    ssh-keygen && \
	xclip -o -sel clip < $HOME/.ssh/id_rsa.pub && \
	cat $HOME/.ssh/id_rsa.pub && \
	printf "
	The key above has been copied to your clipboard.
	Paste it into the form at https://gitlab.com/profile/keys
	\n" && read -n1 -rs -p "Press any key to continue..." key && echo
}

setup() {
    sudo apt update && \
	sudo apt install "${TMP_DEB_PKGS[@]}"
}

main() {
    setup && \
	generate_ssh_key && \
	install_nix && \
	install_nixpkgs && \
	run_ansible_scripts && \
	cleanup
}

main "$@"
