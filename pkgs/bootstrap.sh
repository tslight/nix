#!/usr/bin/env bash
# Pre-Requisites:
# Install curl, network-manager & sudo

# Then run:
# bash <(https://gitlab.com/tspub/devops/nix/raw/master/pkgs/bootstrap.sh)
NIX_BIN="/nix/var/nix/profiles/default/bin"
GITLAB_URL="git@gitlab.com:tspub"

usage() {
    echo "
USAGE: $(basename "$0") [OPTION]

  -A, --all
  -a  --ansible
  -c, --cleanup
  -d, --install-debs
  -I, --install-home-manager
  -h, --run-home-manager
  -l, --run-lazygit
  -n, --install-nix
  -p, --install-nixpkgs
  -s, --generate-ssh-keys
  -u, --uninstall-nix
"
}

chkcmd() {
    command -v "$1" &>/dev/null || source /etc/profile
}

uninstall_nix() {
    local -a paths
    paths=(
	/etc/nix
	/nix
	/root/.nix-profile
	/root/.nix-defexpr
	/root/.nix-channels
	"$HOME"/.nix-profile
	"$HOME"/.nix-defexpr
	"$HOME"/.nix-channels
    )

    sudo systemctl stop nix-daemon.socket
    sudo systemctl stop nix-daemon.service
    sudo systemctl disable nix-daemon.socket
    sudo systemctl disable nix-daemon.service
    sudo systemctl daemon-reload
    sudo mv -v /etc/profile.d/nix.sh.backup-before-nix /etc/profile.d/nix.sh
    for p in "${paths[@]}"; do sudo rm -rfv "$p"; done
}

lazygit() {
    cp /tmp/secrets/config.json "$HOME"/src/gitlab/tspub/js/lazygit/

    cd  "$HOME"/src/gitlab/tspub/js/lazygit/ && \
	npm install && npm link

    lazygitlab
}

run_ansible_scripts() {
    [ -d /tmp/ansible ] || git clone "$GITLAB_URL/devops/ansible" /tmp/ansible
    read -resp "Enter sudo password: " PASS
    chkcmd ansible-playbook
    ansible-playbook -i "/tmp/ansible/hosts" "/tmp/ansible/apt.yml" --extra-vars "ansible_become_pass=\"$PASS\""
    ansible-playbook -i "/tmp/ansible/hosts" "/tmp/ansible/agnostic.yml" --extra-vars "ansible_become_pass=\"$PASS\""
}

run_home_manager() {
    chkcmd home-manger
    home-manager switch
}

install_nixpkgs() {
    [ -d /tmp/nix ] || git clone "GITLAB_URL"/devops/nix /tmp/nix
    "$NIX_BIN"/nix-env -f /tmp/nix/pkgs/pkgs.nix -i --remove-all
}

install_home_manager() {
    local url="https://github.com/rycee/home-manager/archive/master.tar.gz"
    "$NIX_BIN"/nix-channel --add "$url" home-manager
    "$NIX_BIN"/nix-channel --update
}

install_nix() {
    if [ -d /nix ]; then
	echo "Existing Nix installation found at /nix. Aborting."
    else
	yes | sh <(curl https://nixos.org/nix/install) --daemon
    fi
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/bin/$PATH
    source /etc/profile && sudo -i "$NIX_BIN"/nix-channel --update nixpkgs
    "$NIX_BIN"/nix-channel --update nixpkgs && "$NIX_BIN"/nix-channel --update
    echo "If the rest of this script fails, try logging out & back in again..."
}

get_secrets() {
    git clone https://gitlab.com/tsprv/devops/secrets /tmp/secrets
    [ -d "$HOME"/.ssh ] || mkdir m 700  "$HOME"/.ssh
    cp /tmp/secrets/id_rsa* "$HOME"/.ssh/ && \
	chmod 600 "$HOME"/.ssh/id_rsa && \
	echo "Successfully copied ssh keys."
}

install_debs() {
    sudo apt update && sudo apt install curl git rsync
}

all() {
    install_debs && \
	get_secrets && \
	install_nix && \
	install_home_manager && \
	install_nixpkgs && \
	run_home_manager && \
	run_ansible_scripts && \
	lazygit && \
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
	    -l|--run-lazygit)
		lazygit
		;;
	    -n|--install-nix)
		install_nix
		;;
	    -p|--install-nixpkgs)
		install_nixpkgs
		;;
	    -s|--get-secrets)
		get_secrets
		;;
	    -t|--add-trusted-user)
		add_trusted_nix_user
		;;
	    -u|--uninstall_nix)
		uninstall_nix
		;;
	esac
    done
}

[[ "${#@}" -eq 0 ]] && usage || main "$@"
