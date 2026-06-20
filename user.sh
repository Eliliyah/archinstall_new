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

#set the device hostname
read -p "What is the hostname for this device?" host
confirm "Is "$host" correct?"
echo "$host" >> /etc/hostname
cat /etc/hostname
confirm "Was the hostname set correctly?"

#Set the root password
passwd

echo "
%wheel ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

#add yourself as a user
read -p "What is your username going to be?" username
confirm "Is $username correct?"
useradd -m -G wheel -s /bin/bash $username
passwd $username
groupadd fuse
usermod -a -G fuse $username 
ls /home/
confirm "Was the user set correctly?
