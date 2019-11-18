parted "$1" -- mklabel msdos
parted "$1" -- mkpart primary 1MiB -8GiB
parted "$1" -- mkpart primary linux-swap -8GiB 100%

mkfs.ext4 -L nixos "${1}1"
mkswap -L swap "${1}2"
swapon "${1}2"

mount /dev/disk/by-label/nixos /mnt
nixos-generate-config --root /mnt
