#!/usr/bin/env bash

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer Y or N.";;
        esac
    done
}

#Choose the drive for installation
lsblk
read -p "Which device will you be partitioning? Please specify the full device path." dev_block
confirm "Is $dev_block correct?"

read -p "What will be the name of your first (boot) partition?" bootpart
confirm "Is $bootpart correct?

read -p "What will be the name of your second (swap) partition?" swappy
confirm "Is $swappy correct?"

read -p "What will be the name of your third (root) partition?" rootpart
confirm "Is $rootpart correct?"

#Partition the drive 
mkfs.fat -F 32 -n EFI $bootpart"
mkswap -L swap -f "$swappy"
mkfs.btrfs "$rootpart" --label=system -f
o=defaults,x-mount.mkdir
o_btrfs=$o,defaults,noatime,compress=zstd,commit=120
mount -t btrfs LABEL=system /mnt 

#create subvolumes
mkdir /mnt/var
mkdir /mnt/var/log
mkdir /mnt/var/tmp
mkdir /mnt/var/cache
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@cache
rm -rf /mnt/log
rm -rf /mnt/tmp
rm -rf /mnt/cache
umount -R /mnt

#Mount the partitions
o=defaults,x-mount.mkdir
o_btrfs=$o,defaults,noatime,compress=zstd,commit=120
mount -t btrfs -o subvol=@,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=@home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=@root,$o_btrfs LABEL=system /mnt/root
mount -t btrfs -o subvol=@srv,$o_btrfs LABEL=system /mnt/srv
mount -t btrfs -o subvol=@log,$o_btrfs LABEL=system /mnt/var/log
mount -t btrfs -o subvol=@tmp,$o_btrfs LABEL=system /mnt/var/tmp
mount -t btrfs -o subvol=@cache,$o_btrfs LABEL=system /mnt/var/cache
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount "$bootpart" /mnt/boot
swapon "$swappy"
btrfs quota enable /mnt
lsblk
