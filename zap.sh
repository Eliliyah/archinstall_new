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

#Use timedatectl(1) to ensure the system clock is accurate:
loadkeys us 
timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc
timedatectl set-ntp true
timedatectl status

#Format the drive
lsblk
read -p "Which device will you be installing to? Please specify the full path." dev
confirm "Is "$dev" correct?"
sgdisk --zap-all "$dev"

read -p "How large would you like your swap partition to be?" swapsize
confirm "Is "$swapsize" correct?"
sgdisk --zap-all "$dev"

sgdisk --clear \
         --new=1:0:+1024MiB --typecode=1:ef00 \
         --new=2:0:+"$swapsize"MiB   --typecode=2:8200 \
         --new=3:0:0       --typecode=3:8300 \
          "$dev"

