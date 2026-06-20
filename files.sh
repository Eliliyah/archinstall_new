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

#sync home files
pacman -S --needed rsync starship fish --noconfirm
cd /home/ellie/
git clone https://github.com/eliliyah/surface
cd /home/ellie/home/ellie/surface/

mkdir /home/ellie/.config
rsync -av /home/ellie/surface/files/.bash_aliases /home/ellie/.bash_aliases
rsync -av /home/ellie/surface/files/bash_aliases /home/ellie/bash_aliases
rsync -av /home/ellie/surface/files/bashrc /home/ellie/bashrc
rsync -av /home/ellie/surface/files/fish_aliases /home/ellie/fish_aliases
rsync -av /home/ellie/surface/files/update.sh /home/ellie/update.sh
rsync -av /home/ellie/surface/files/starship.toml /home/ellie/.config/starship.toml
mkdir /home/ellie/.config/fish/
rsync -av /home/ellie/surface/files/config.fish /home/ellie/.config/fish/config.fish
rsync -av /home/ellie/surface/files/fish_variables /home/ellie/.config/fish/fish_variables
mkdir /home/ellie/.config/fish/conf.d/
rsync -av /home/ellie/surface/files/uv.env.fish /home/ellie/.config/fish/conf.d/uv.env.fish
mkdir /home/llie/.local/
mkdir /home/ellie/.local/bin
rsync -av /home/ellie/surface/files/env.fish /home/ellie/.local/bin/env.fish
mkdir /home/ellie/Pictures
rsync -av /home/ellie/surface/files/arch_pink_background.png /home/ellie/Pictures/arch_pink_background.png
rsync -av /home/ellie/surface/files/ellieossticker_small.png /home/ellie/Pictures/ellieossticker_small.png
rsync -av /home/ellie/surface/files/home_files.zip/ /home/ellie/Downloads/home_files.zip
