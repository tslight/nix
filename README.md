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

1. Install NixOS using the official graphical installer.
2. Clone this repository.
3. Make a directory for the new machine to store the new hardware
   configuration, the name of the directory should be the same as your
   `$HOSTNAME`.
4. Ensure all hardware specific settings from `/etc/nixos/configuration.nix`
   are in `/etc/nixos/hardware-configuration.nix`. Specifically any
   `boot.initrd.luks.devices` lines...
5. Move `/etc/nixos/hardware-configuration.nix` to the new machine's directory
   we created at step 3.
6. Declare the new addition in `flake.nix` with the following block under
   `nixosConfigurations`:

``` nix
<HOSTNAME> = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    ./<HOSTNAME>/hardware-configuration.nix
  ];
};
```

7. Run `make` and reboot. Ensuring we can successfully build and boot from the
   flake's derivation.
8. Run `sudo nix-channel --remove nixos`. You do not need Nix channels on a
   flake-based system anymore.
9. Once we've verified we can successfully build and boot from the flake, we
   can go ahead and delete `/etc/nixos`.

# THE FLEET

| Hostname    | Make   | Model                  | RAM  | DISK          | OS    |
|-------------|--------|------------------------|------|---------------|-------|
| `cardiel`   | Lenovo | ThinkPad X131E         | 16GB | 256GB + 512GB | NixOS |
| `enigma`    | Lenovo | ThinkPad T13 AMD Gen 1 | 8G   | 4TB           | NixOS |
| `penny`     | Pine64 | Pinebook Pro           | 4G   | 128GB + 512GB | NixOS |
| `nightwolf` | Apple  | MacBook Air 7,2        | 8G   | 256GB         | NixOS |
| `genesis`   | Lenovo | ThinkPad 11e Yoga      | 8G   | 128GB         | NixOS |
| `terence`   | Lenovo | ThinkPad T14 AMD Gen 1 | 32GB | 4TB           | NixOS |
| `hexley`    | Apple  | MacBook Pro            | 16GB | 512GB         | MacOS |
