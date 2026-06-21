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

chmod +x locales.sh
./locales.sh
confirm "Were the locales set successfully?"

chmod +x user.sh
./user.sh
confirm "Was the hostname set and user created successfully?"

pacman-key --init
pacman-key --update
pacman -Syu
pacman -S --needed vim rsync --noconfirm

chmod +x keyrings.sh
./keyrings.sh
confirm "Did the keyrings install and mirrors update successfully?"

#install packages
for pkg in $(cat pkglist.txt | tr '\n' ' ' ) ; do
    pacman --needed -S "$pkg" --noconfirm
done
confirm "Did all packages install successfully?"

#install a desktop enviornment
chmod +x de.sh
./de.sh
confirm "Was a desktop enviornment installed?"

chmod +x config.sh
./config.sh
confirm "Was the system configured successfully?"

chmod +x grub.sh
./grub.sh
confirm "Was the bootloader installed properly?"
"Please exit the chroot and reboot."
