#!/usr/bin/env bash

sudo apt install curl rsync && \
    sh <(curl https://nixos.org/nix/install) --daemon && \
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager && \
    nix-channel --update
