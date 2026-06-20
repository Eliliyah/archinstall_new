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

#set username variable
read -p "What did you name your user?" username
confirm "Is "$username" correct?"

#sync home files
pacman -S --needed rsync starship fish --noconfirm
cd /home/"$username"/
pwd
confirm "Are you in the correct directory?"

git clone https://github.com/eliliyah/archinstall_new
cd /home/"$username"/archinstall_new/
pwd
confirm "Are you in the correct directory?"

rsync -av /home/"$username"/archinstall_new/files/.bash_aliases /home/"$username"/.bash_aliases
rsync -av /home/"$username"/archinstall_new/files/bash_aliases /home/"$username"/bash_aliases
rsync -av /home/"$username"/archinstall_new/files/bashrc /home/"$username"/bashrc
rsync -av /home/"$username"/archinstall_new/files/fish_aliases /home/"$username"/fish_aliases
rsync -av /home/"$username"/archinstall_new/files/update.sh /home/"$username"/update.sh

mkdir /home/"$username"/.config
rsync -av /home/"$username"/archinstall_new/files/starship.toml /home/"$username"/.config/starship.toml

mkdir /home/"$username"/.config/fish/
rsync -av /home/"$username"/archinstall_new/files/config.fish /home/"$username"/.config/fish/config.fish
rsync -av /home/"$username"/archinstall_new/files/fish_variables /home/"$username"/.config/fish/fish_variables

mkdir /home/"$username"/.config/fish/conf.d/
rsync -av /home/"$username"/archinstall_new/files/uv.env.fish /home/"$username"/.config/fish/conf.d/uv.env.fish

mkdir /home/llie/.local/
mkdir /home/"$username"/.local/bin/
rsync -av /home/"$username"/archinstall_new/files/env.fish /home/"$username"/.local/bin/env.fish

mkdir /home/"$username"/Pictures
rsync -av /home/"$username"/archinstall_new/files/arch_pink_background.png /home/"$username"/Pictures/arch_pink_background.png
rsync -av /home/"$username"/archinstall_new/files/"$username"ossticker_small.png /home/"$username"/Pictures/"$username"ossticker_small.png
