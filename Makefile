.DEFAULT_GOAL := help
.PHONY: all darwin nixos hm clean help setup

# Show this help.
help:; @awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

# Rebuilt NixOS system
nixos:; sudo nixos-rebuild switch --flake ./nixos

# Rebuild Nix Darwin
darwin:; sudo darwin-rebuild switch --flake ./darwin

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
