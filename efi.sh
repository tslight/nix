parted "$1" -- mklabel gpt
parted "$1" -- mkpart primary 512MiB -8GiB
parted "$1" -- mkpart primary linux-swap -8GiB 100%
parted "$1" -- mkpart ESP fat32 1MiB 512MiB
parted "$1" -- set 3 boot on

mkfs.ext4 -L nixos "${1}1"
mkswap -L swap "${1}2"
swapon "${1}2"
mkfs.fat -F 32 -n boot "${1}3"

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt
