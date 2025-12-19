.DEFAULT_GOAL := help
.PHONY: all nixos home clean help setup

# Show this help.
help:; @awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

# Rebuilt NixOS system
nixos:; sudo nixos-rebuild switch --flake .; sudo udevadm trigger

# Rebuilt Home Manager
home:; home-manager switch --flake ./home

# Rebuilt NixOS & Home Manager
all: nixos home

# Garbage Collect Nix
clean:; sudo nix-collect-garbage -d

# Upload SSH keys to GitHub
setup:; ./bin/ghkey.sh;	./bin/ghurl.sh
