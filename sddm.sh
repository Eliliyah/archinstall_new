#!/usr/bin/bash

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
sudo aura -A archlinux-themes-sddm --noconfirm
echo "[Theme]
Current=archlinux-simplyblack">> /etc/sddm.conf
sudo nano /etc/sddm.conf
confirm "All good?"
