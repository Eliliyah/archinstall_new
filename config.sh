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

#set time
timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc
timedatectl set-ntp true
timedatectl status
locale-gen
confirm "Did the time set correctly?"

#install system services
pacman -S --needed networkmanager --noconfirm
systemctl enable NetworkManager
confirm "Did networkmanager install?"

pacman -S --needed lm_sensors --noconfirm
systemctl enable lm_sensors
confirm "Did lmsensors install?"

pacman -S --needed acpid --noconfirm
systemctl enable acpid
confirm "Did acpid install?"

pacman -S --needed power-profiles-daemon --noconfirm
systemctl enable power-profiles-daemon
confirm "Did power-profiles-daemon install?"

pacman -S --needed bluez bluez-utils --noconfirm
systemctl enable bluetooth
confirm "Did bluetooth install?"

pacman -S --needed preload --noconfirm
systemctl enable preload
confirm "Did preload install?"

pacman -S --needed upower --noconfirm
systemctl enable upower
confirm "Did upower install?"

#install aura
pacman -S aura --noconfirm
aura - A beautyline
confirm "Did aura install?"

for pkg in pamac zellij yazi yay rsync vim konsole fish iwd aura starship vscodium btop dolphin strawberry libreoffice-fresh ttf-daddytime-mono-nerd kde-style-oxygen-qt6 snapper; do
  pacman -S --needed --noconfirm "$pkg"
done

#Install AUR packages
#for pkg in oxygen-cursors-extra hunspell-en-med-glut-git debtap masterpdfeditor-free appimagelauncher hunspell-en-med-glut-git libreoffice-extension-cleandoc ocs-url onevpl-intel-gpu pacdiff-pacman-hook-git wd719x-firmware aic94xx-firmware snap-pac-grub; do
#  aura -A --noconfirm "$pkg"
#done

#Configure journal
echo "Storage=persistent" >> /etc/systemd/journald.conf

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#enable late microcode updates
pacman -S --needed intel-ucode --noconfirm

#configure rclone
mkdir /home/ellie/proton
pacman -S --needed rclone rsync --noconfirm
#rclone config
#rsync -av /surface/rclone.service /etc/systemd/system/rclone.service
#systemctl enable rclone
#confirm "Did rclone configure successfully?"

#Configure zram
pacman -S zram-generator --noconfirm
rsync -av /archinstall_new/zram-generator.conf /etc/systemd/zram-generator.conf

#sync files
chmod +x files.sh
./files.sh
confirm "Did home files sync?"

#set theme elements
pacman -S --needed beautyline oxygen --noconfirm

#install flatpak packages
for flat in brave discord feishin jellyfin; do
  flatpak install "$flat"
done

#Generate the initramfs
for kerns in linux linux-lts; do
  mkinitcpio -p "$kerns"
done
confirm "Did the initramfs generate successfully?"
