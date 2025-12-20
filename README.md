# THIRD TIME'S THE CHARM...

This is my third attempt at maintaining a fleet of NixOS machines.

My first attempt was back in 2019 and I can't remember exactly why I ended up
giving up on it that time.

The last incarnation from 2023, is currently in `.old/`, and is likely
over-engineered.

I ended up declaring nix bankruptcy and going back to more traditional OSes,
after I attempted my first version update and all hell broke loose.

I didn't have the time or inclination to spend hours figuring it out...

Looking back at the code a couple of years down the line - it seems overly
complicated and hard to maintain/debug (for a nix noob like me at least)...

This time, I'm going slowly and keeping it simple. So far I've used the
following resources for guidance:

https://phip1611.de/blog/migrate-stock-nixos-configuration-to-flake/

https://www.youtube.com/playlist?list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG

https://nix.dev/tutorials/nix-language

https://zero-to-nix.com/

# INSTALLATION

* Install NixOS using the official graphical installer.
* Optional, but recommended: set a distinct `$HOSTNAME`.
* Spawn an adhoc environment with `nix-shell -p git gnumake neovim`.
* Run `git clone https://github.com/tslight/nix`.
* Run `mkdir $HOSTNAME && cp /etc/nixos/hardware-configuration.nix
  ./$HOSTNAME/`
* Ensure all device exclusive settings from
  `/etc/nixos/configuration.nix` are copied to
  `$HOSTNAME/hardware-configuration.nix`. Specifically
  `networking.hostName = "$HOSTNAME";` and any
  `boot.initrd.luks.devices` lines.
* Declare the new `$HOSTNAME` in the `hosts` array in `flake.nix`.
* Run `git add -A`, as when using Nix flakes, only files that are
  tracked by Git and not ignored by your ~.gitignore~ are included in
  the flake's source.
* Run `sudo nixos-rebuild switch --flake .`, or if your `$HOSTNAME`
  doesn't match: `sudo nixos-rebuild switch --flake
  .#name-of-nixosSystem`
* Reboot, to ensure we can successfully boot from the flake's
  derivation.
* Run `sudo nix-channel --remove nixos`. You do not need Nix channels
  on a flake-based system anymore.
* Once we've verified we can successfully build and boot from the
  flake, we can go ahead and delete `/etc/nixos`.
* Run `make setup` to upload newly created SSH keys to GitHub and then
  change our git remote.
* Commit and push your changes. Profit!

# THE FLEET

| Name      | Manufacturer | Model             | Size |       |
|-----------|--------------|-------------------|------|-------|
| AMFV      | Apple        | MacBook Pro 2011  | 17"  | NixOS |
| TSOT      | Apple        | MacBook Air 2014  | 13"  | NixOS |
| Genesis   | Apple        | MacBook Air 2014  | 11"  | NixOS |
| Hexley    | Apple        | MacBook Pro M1    | 14"  | macOS |
| Porridge  | Pine64       | Pinebook Pro      | 14"  | nixOS |
| Nightwolf | Lenovo       | ThinkPad X131e    | 11"  | NixOS |
| Sahaja    | Lenovo       | ThinkPad Yoga 11e | 11"  | NixOS |
| Cardiel   | Lenovo       | P1 Gen 1          | 15"  | NixOS |
| Enigma    | Lenovo       | X13               | 13"  | NixOS |
