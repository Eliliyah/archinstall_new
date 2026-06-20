#!/usr/bin/bash

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
pacman -S --needed starship --noconfirm
rsync -av /surface/files/.bash_aliases /home/ellie/
rsync -av /surface/files/bash_aliases /home/ellie/
rsync -av /surface/files/bashrc /home/ellie/
rsync -av /surface/files/fish_aliases /home/ellie
rsync -av /surface/files/update.sh /home/ellie
rsync -av /surface/files/starship.toml /home/ellie/.config/
mkdir /home/ellie/.config/fish/
rsync -av /surface/files/config.fish /home/ellie/.config/fish/
rsync -av /surface/files/fish_variables /home/ellie/.config/fish
mkdir /home/ellie/.config/fish/conf.d/
rsync -av /surface/files/uv.env.fish /home/ellie/.config/fish/conf.d/uv.env.fish
mkdir /home/ellie/.local/bin
rsync -av /surface/files/env.fish /home/ellie/.local/bin/
rsync -av /surface/files/arch_pink_background.png /home/ellie/Pictures
rsync -av /surface/files/ellieossticker_small.png /home/ellie/Pictures
rsync -av /surface/files/home_files.zip/ /home/ellie/Downloads

confirm "Did everything sync?"



