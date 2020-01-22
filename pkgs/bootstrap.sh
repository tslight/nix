#!/usr/bin/env bash

run_ansible_scripts() {
    git clone git@gitlab.com:tspub/devops/ansible $HOME/ansible && \
        ansible-playbook -i $HOME/ansible/hosts $HOME/ansible/agnostic.yml && \
        ansible-playbook -i $HOME/ansible/hosts $HOME/ansible/apt.yml && \
        ansible-playbook -i $HOME/ansible/hosts $HOME/ansible/git.yml && \
        source $HOME/.profile && \
        source $HOME/.bash_profile && \
        source $HOME/.bashrc
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
    sudo apt install curl rsync git && \
        sh <(curl https://nixos.org/nix/install) --daemon && \
        source /etc/profile && \
        nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager && \
        nix-channel --update && \
        ssh-keygen && \
        cat $HOME/.ssh/id_rsa.pub
        printf "\nCopy the key above to https://gitlab.com/profile/keys\n\n" && \
        read -n1 -rs -p "Press any key to continue..." key && \
        printf "\n\n" && \
        install_nixpkgs && \
        run_ansible_scripts && \
        cleanup
}

cleanup() {
    sudo apt purge curl rsync git
}