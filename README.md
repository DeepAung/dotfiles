# dotfiles

## Setup steps
- Install [wslu](https://wslutiliti.es/wslu/install.html)
- Setup [systemd script](https://github.com/DamionGans/ubuntu-wsl2-systemd-script)
- Install common dependencies
```
sudo apt update && sudo apt install -y \
	curl \
	wget \
	git \
	make \
	tree \
	zsh \
	zip unzip
```
- Setup git
	- `git config --global user.email "<my email>" && git config --global user.name "<my username>"`
	- [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)	
	- [Adding a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- Clone this repo to ~/.dotfiles and `cd ~/.dotfiles && stow -t ~ */`

- Install softwares
	- go, gvm
	- node, npm, nvm
	- python
	- rustup, cargo
	- gcc, g++, clang, make
	- nvim
	- tmux
 		- tmux plugin manager
   		- tmuxifier
	- lazygit
	- bruno
	- dbeaver
	- docker
