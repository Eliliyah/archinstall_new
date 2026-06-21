#!/bin/usr/env bash

# Define menu options
options=("KDE Plasma 6" "Cinnamon" "Cosmic" "None")

# Set the prompt displayed before the menu
PS3="Please select a Desktop Enviornment:"

# Display the menu and handle selection
select opt in "${options[@]}"; do
    case $opt in
        "KDE Plasma 6")
            pacman -S plasma plasma-meta --noconfirm
            ;;
        "Cinnamon")
            pacman -S cinnamon xorg wayland --noconfirm
            ;;
        "Cosmic")
            pacman -S cosmic --noconfirm
            ;;
        "None")
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option: $REPLY"
            ;;
    esac
done
