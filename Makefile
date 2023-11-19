HOST := $(shell hostname -s)
USER := $(shell whoami)
NIX_CONFIG := "experimental-features = nix-command flakes"
UNAME_S := $(shell uname -s)

.PHONY: all darwin nixos home clean brew
all:
ifeq ($(UNAME_S),Linux)
	@make -s nixos
endif
ifeq ($(UNAME_S),Darwin)
	@make -s darwin
endif
	@make -s home

brew:; bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# https://xyno.space/post/nix-darwin-introduction
darwin:
	nix build .#darwinConfigurations.$(HOST).system --extra-experimental-features "nix-command flakes"
	./result/sw/bin/darwin-rebuild switch --flake .

nixos:
	export NIX_CONFIG="experimental-features = nix-command flakes"
	NIX_CONFIG="experimental-features = nix-command flakes" \
		sudo nixos-rebuild --impure switch --flake .#$(HOST)

home:
	export NIX_CONFIG="experimental-features = nix-command flakes"
	NIX_CONFIG="experimental-features = nix-command flakes" \
		home-manager switch --flake .#$(USER)@$(HOST)

iso: # https://www.reddit.com/r/NixOS/comments/y1xo2u/how_to_create_an_iso_with_my_config_files/
	nix build --impure .#nixosConfigurations.$(HOST).config.system.build.isoImage

clean:;	sudo nix-collect-garbage -d
