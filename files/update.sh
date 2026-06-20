#!/usr/bin/bash
sudo mkinitcpio -p linux
sudo mkinitcpio -p linux-zen
sudo grub-mkconfig -o /boot/grub/grub.cfg
