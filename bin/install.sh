#!/usr/bin/env bash

sudo nixos-rebuild switch --flake .
home-manager switch --flake ./home
