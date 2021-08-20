usage() {
    echo "
$(basename "$0") [-e/-m] [DISK]

-u : Use UEFI partition layout
-m : Use MBR partition layout

Example: $(basename "$0") -e /dev/sda
"
}

make_efi_partitions() {
    echo "Partitioning $TYPE $DISK..." && \
	parted "$DISK" -- mklabel gpt && \
	parted "$DISK" -- mkpart primary 512MiB -8GiB && \
	parted "$DISK" -- mkpart primary linux-swap -8GiB 100% && \
	parted "$DISK" -- mkpart ESP fat32 1MiB 512MiB && \
	parted "$DISK" -- set 3 boot on && \
	echo "Succesfully partitioned $TYPE $DISK :-)"
}

make_mbr_partitions() {
    echo "Partitioning $TYPE $DISK..." && \
	parted "$DISK" -- mklabel msdos && \
	parted "$DISK" -- mkpart primary 1MiB -8GiB && \
	parted "$DISK" -- mkpart primary linux-swap -8GiB 100% && \
	echo "Succesfully partitioned $TYPE $DISK :-)"
}

format_efi_partitions() {
    echo "Formatting $TYPE partitions..." && \
	mkfs.ext4 -L nixos "${DISK}1" && \
	mkswap -L swap "${DISK}2" && \
	swapon "${DISK}2" && \
	mkfs.fat -F 32 -n boot "${DISK}3" && \
	echo "Successfully formatted $TYPE partitions :-)"
}

format_mbr_partitions() {
    echo "Formatting $TYPE partitions..." && \
	mkfs.ext4 -L nixos "${DISK}1" && \
	mkswap -L swap "${DISK}2" && \
	swapon "${DISK}2" && \
	echo "Successfully formatted $TYPE partitions :-)"
}

mount_efi_partitions() {
    echo "Mounting $TYPE partitions..." && \
	mount /dev/disk/by-label/nixos /mnt && \
	mkdir -p /mnt/boot && \
	mount /dev/disk/by-label/boot /mnt/boot && \
	echo "Successfully mounted $TYPE partitions :-)"
}

mount_mbr_partitions() {
    echo "Mounting $TYPE partitions..." && \
	mount /dev/disk/by-label/nixos /mnt && \
	echo "Successfully mounted $TYPE partitions :-)"
}

install_nix() {
    echo "Installing Nix OS..." && \
	nixos-generate-config --root /mnt && \
	cp -iv ./*.nix /mnt/etc/nixos/ && \
	nixos-install && \
	echo "Successfully installed Nix OS :-)"
}

main() {
    [ -z "$1" ] && { usage; exit 1; }

    while getopts "u:m:h" opt; do
	[ -n "$OPTARG" ] && DISK="$OPTARG" || { usage; exit 1; }
	case ${opt} in
	    h)
		usage
		exit 0
		;;
	    m)
		TYPE="MBR"
		make_mbr_partitions
		format_mbr_partitions
		mount_mbr_partitions
		;;
	    u)
		TYPE="UEFI"
		make_efi_partitions
		format_efi_partitions
		mount_efi_partitions
		;;
	    \?)
		echo "Invalid Option: -$OPTARG" 1>&2
		exit 1
		;;
	esac
    done

    shift $((OPTIND -1))

    # install_nix
}

main "$@"
