#!/bin/bash

read -p "suggested to set ParallelDownloads in /etc/pacman.conf before. continue? [y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	echo "[No]"
	exit 1
fi
echo "[Yes]"

# Install yay
echo "installing yay"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

echo "installing packages in pacman"
sudo pacman -S --needed - < pkglist.txt

echo "installing packages in yay"
yay -S --needed - < aurpkglist.txt

echo "linking dotfiles"
cd ~/.dotfiles && stow -t ~ */

echo "enable and start services (NetworkManager, bluetooth)"
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now ssdm.service
