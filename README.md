# THIRD TIME'S THE CHARM...

This is my third attempt at maintaining a fleet of NixOS machines using flakes.

The last incarnation is currently in `.old` if you want to see some hideous
over-engineering...

I abandoned it after I attempted a version update and it broke all my systems
and I didn't have time to figure out what on earth had gone wrong.

Looking back at the code a couple of years down the line it all seems
unnecessarily complex to me!

This time, I'm going slowly and keeping it simple. So far I've used the
following articles for inspiration:

https://phip1611.de/blog/migrate-stock-nixos-configuration-to-flake/

# INSTALLATION

* Install NixOS using the official graphical installer.
* Make sure you have a custom `$HOSTNAME` and not just the default "nixos" one.
  Either via the installer or by editing the default
  `/etc/nixos/configuration.nix` and rebooting.
* Spawn an adhoc environment with `nix-shell -p git`.
* Run `git clone https://github.com/tslight/nix`.
* Run `mkdir $HOSTNAME && cp /etc/nixos/hardware-configuration.nix ./$HOSTNAME/`
* Ensure all device exclusive settings from `/etc/nixos/configuration.nix` are
  copied to `$HOSTNAME/hardware-configuration.nix`. Specifically
  `networking.hostName = "$HOSTNAME";` and any `boot.initrd.luks.devices`
  lines.
* Declare the new addition in `flake.nix` with a block under
  `nixosConfigurations`.
* Run `git add -A`, as when using Nix flakes, only files that are tracked by
  Git and not ignored by your ~.gitignore~ are included in the flake's source.
* Run `nix flake update --extra-experimental-features nix-command --extra-experimental-features flakes`
* Run `make` and reboot, ensuring we can successfully build and boot from the
  flake's derivation.
* Run `sudo nix-channel --remove nixos`. You do not need Nix channels on a
  flake-based system anymore.
* Once we've verified we can successfully build and boot from the flake, we can
  go ahead and delete `/etc/nixos`.
* Commit and push your changes. Profit!
