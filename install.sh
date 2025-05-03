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
cd ~/.dotfiles && stow -t ~ bash common hypr kitty nvim tmux tmuxifier waybar wofi yazi zsh

echo "enable and start services (NetworkManager, bluetooth, ssdm, docker)"
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now ssdm.service
sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

echo "create docker group and add it to current user"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

echo "install go packages"
go install github.com/air-verse/air@latest # air
go install github.com/go-jet/jet/v2/cmd/jet@latest # jet
go install github.com/a-h/templ/cmd/templ@latest # templ
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest # grpc
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install -tags 'postgres sqlite sqlite3' github.com/golang-migrate/migrate/v4/cmd/migrate@latest # migrate
go install github.com/pressly/goose/v3/cmd/goose@latest # goose

echo "install duckdb"
curl https://install.duckdb.org | sh

echo "install tilt"
curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
