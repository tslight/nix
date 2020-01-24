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

  -a, --all
  -A  --ansible
  -c, --cleanup
  -d, --install_debs
  -n, --install_nix
  -p, --install_nixpkgs
  -s, --generate_ssh_keys
  -h, --help
"
}

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
	cp -r $HOME/nix/pkgs $HOME/.config/nixpkgs && \
	source /etc/profile && \
	nix-env -iA nixpkgs.myPackages && \
	mv $HOME/.bashrc{,.bak} && \
	mv $HOME/.profile{,.bak} && \
	home-manager switch
}

install_nix() {
    if [ -d /nix ]; then
	echo "Existing Nix installation found at /nix. Aborting."
    else
	sh <(curl https://nixos.org/nix/install) --daemon && \
	    source /etc/profile && \
	    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager && \
	    nix-channel --update
    fi
}

generate_ssh_keys() {
    # https://unix.stackexchange.com/a/135090
    # cat /dev/zero | ssh-keygen -q -N ""
    # https://unix.stackexchange.com/a/69318
    ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -q -N "" # 0>&- # don't overwrite without prompt

    cat $HOME/.ssh/id_rsa.pub | xclip
    echo; cat $HOME/.ssh/id_rsa.pub

    printf "
    The key above has been copied to your clipboard.
    Paste it into the form at https://gitlab.com/profile/keys
    \n" && read -n1 -rs -p "Press any key to continue..." key && echo
}

install_debs() {
    sudo apt update
    for p in "${TMP_DEB_PKGS[@]}"; do
	command -v "$p" || sudo apt install "$p"
    done
}

all() {
    install_debs
    generate_ssh_key
    install_nix
    install_nixpkgs
    run_ansible_scripts
    cleanup
}

main() {
    local -a args=("$@")

    for arg in "${args[@]}"; do
	case "$arg" in
	    -a|--all)
		all
		;;
	    -A|--ansible)
		run_ansible_scripts
		;;
	    -c|--cleanup)
		cleanup
		;;
	    -d|--install_debs)
		install_debs
		;;
	    -n|--install-nix)
		install_nix
		;;
	    -p|--install-nixpkgs)
		install_nixpkgs
		;;
	    -s|--generate_ssh_keys)
		generate_ssh_keys
		;;
	    *)
		usage
		;;
	esac
    done
}

main "$@"
