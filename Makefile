HOST := $(shell hostname -s)
USER := $(shell whoami)
NIX_CONFIG := "experimental-features = nix-command flakes"

.PHONY: all
all: host home

host:
	export NIX_CONFIG="experimental-features = nix-command flakes"
	NIX_CONFIG="experimental-features = nix-command flakes" \
		sudo nixos-rebuild --impure switch --flake .#$(HOST)

home:
	export NIX_CONFIG="experimental-features = nix-command flakes"
	NIX_CONFIG="experimental-features = nix-command flakes" \
		home-manager switch --flake .#$(USER)@$(HOST)
