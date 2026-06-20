#!/usr/bin/env bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

#Install chaotic AUR keyring
pacman-key --init
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist">> /etc/pacman.conf
pacman-key --populate
pacman-key -u

confirm "Do you want to install the Blackarch keyring?"
confirm "Really? Do you think you're ever going to need that?"

#Install blackarch
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh

confirm "Did it work?"

#Update mirrors and keys
reflector
pacman-key --populate
pacman-key -u 
pacman -Syu
