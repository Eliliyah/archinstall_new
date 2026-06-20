#!/usr/bin/env bash

#FUNCTIONS GO HERE

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
example-function() {
    echo "$2"
}

#Update mirrors and keys
pacman -Syyu
pacman -S archlinux-keyring
reflector
pacman-key --populate
pacman-key -u


#Generate the initramfs
for pkg in linux linux-lts linux-surface; do
  mkinitcpio -p "$pkg"
done
confirm "Did the initramfs generate successfully?"

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

confirm "Did the bootloader regenerate successfully?"

confirm "Type exit and reboot."
