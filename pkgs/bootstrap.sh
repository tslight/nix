#!/usr/bin/env bash

sh <(curl https://nixos.org/nix/install) --daemon

nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
