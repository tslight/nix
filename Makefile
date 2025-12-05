.DEFAULT_GOAL := all
.PHONY: all

HOST := $(shell hostname -s)

all:; sudo nixos-rebuild switch --flake .#$(HOST) --upgrade

clean:;	sudo nix-collect-garbage -d
