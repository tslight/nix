.DEFAULT_GOAL := help
.PHONY: all nixos home clean help setup

# Show this help.
help:; @awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

# Update Flakes
update:; nix flake update && cd ./home && nix flake update

# Rebuilt NixOS system
os:; sudo nixos-rebuild switch --upgrade --flake .

# Rebuilt Home Manager
home:; home-manager switch --flake ./home

# Rebuilt NixOS & Home Manager
all: os home

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
