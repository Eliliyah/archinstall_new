#!/usr/bin/env bash

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

read -p "What is the hostname for this device?" host
confirm "Is $host correct?"
echo "$host">> /etc/hostname
cat /etc/hostname
confirm "Was the hostname set correctly?"

    #Generate locales
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
locale-gen 
confirm "Did locales generate?"
echo "LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LANGUAGE=en_US.UTF-8">> /etc/locale.conf
echo "KEYMAP=us
FONT=Lat2-Terminus16">> /etc/vconsole.conf

#Set the root password
passwd

echo "
%wheel ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL">> /etc/sudoers

#add yourself as a user
read -p "What is your username going to be?" username
confirm "Is $username correct?"
useradd -m -G wheel -s /bin/bash $username
passwd $username
groupadd fuse
usermod -a -G fuse $username
