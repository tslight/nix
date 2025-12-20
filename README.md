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

This time, I'm going slowly and aiming to *K.I.S.S*....

# INSTALLATION

* Install NixOS using the official graphical installer.
* Spawn an adhoc environment with `nix-shell -p git gnumake neovim`.
* Run:

```bash
git clone https://github.com/tslight/nix && cd nix
export $NEW_HOSTNAME="your-fancy-new-hostname"
mkdir ./os/hosts/$NEW_HOSTNAME
cp /etc/nixos/hardware-configuration.nix ./os/hosts/$NEW_HOSTNAME.nix
```

* Add/Edit the following at the top of `./os/hosts/$NEW_HOSTNAME.nix`:

```nix
{ lib, modulesPath, host, system, ... }: {
  imports = [
	(modulesPath + "/installer/scan/not-detected.nix")
	# Add modules from ../modules/*.nix here
  ];

  # The system & host vars are getting passed in from the flake
  nixpkgs.hostPlatform = lib.mkDefault system;
  networking.hostName = host;

  # Rest of hardware config goes here...
}
```

* Run `git add -A`, as when using Nix flakes, only files that are
tracked by Git and not ignored by your `.gitignore` are included in
the flake's source.
* Run `sudo nixos-rebuild switch --flake .#"$NEW_HOSTNAME"`.
* Run `make home`.
* Reboot, to ensure we can successfully boot from the flake's
derivation.
* Run `make clean` to delete all the old channel cruft.
* Run `make setup` to upload newly created SSH keys to GitHub and then
change our git remote.
* Commit and push the new host. Profit!

# THE FLEET

| **Host**    | **Device**                      | **Size** | **OS** |
|-------------|---------------------------------|----------|--------|
| `amfv`      | Apple   MacBook Pro 2011        | 17"      | NixOS  |
| `tsot`      | Apple   MacBook Air 6,1         | 13"      | NixOS  |
| `genesis`   | Apple   MacBook Air 7,2         | 11"      | NixOS  |
| `hexley`    | Apple   MacBook Pro M1          | 14"      | macOS  |
| `porridge`  | Pine64  Pinebook Pro            | 14"      | NixOS  |
| `nightwolf` | Lenovo  ThinkPad X131e          | 11"      | NixOS  |
| `sahaja`    | Lenovo  ThinkPad 11e Yoga Gen 6 | 11"      | NixOS  |
| `cardiel`   | Lenovo  ThinkPad P1 Gen 1       | 15"      | NixOS  |
| `enigma`    | Lenovo  ThinkPad X13 Gen 1      | 13"      | NixOS  |

# RESOURCES

https://phip1611.de/blog/migrate-stock-nixos-configuration-to-flake/

https://www.youtube.com/playlist?list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG

https://nix.dev/tutorials/nix-language

https://zero-to-nix.com/
