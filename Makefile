.DEFAULT_GOAL := all
.PHONY: all nixos home clean

nix:
	sudo nixos-rebuild switch --flake .
	sudo udevadm trigger

home:; home-manager switch --flake ./home

all: nix home

clean:; sudo nix-collect-garbage -d
