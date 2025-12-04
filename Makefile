.DEFAULT_GOAL := all
.PHONY: all
all:; sudo nixos-rebuild switch --flake . --upgrade
clean:;	sudo nix-collect-garbage -d
