.DEFAULT_GOAL := help
.PHONY: all nixos home clean help setup

# Show this help.
help:; @awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

# Rebuilt NixOS system
nixos:
	nix flake update
	sudo nixos-rebuild switch --upgrade --flake .
	sudo udevadm trigger

# Rebuilt Home Manager
home:
	cd ./home && nix flake update
	home-manager switch --flake ./home

# Rebuilt NixOS & Home Manager
all: nixos home

# Garbage Collect Nix
clean:
	sudo nix-channel --remove nixos
	sudo rm -rfv /etc/nixos
	sudo nix-collect-garbage -d

# Upload SSH keys to GitHub
setup:
	./bin/ghkey.sh
	git remote set-url origin git@github.com:tslight/nix
	git remote -v
