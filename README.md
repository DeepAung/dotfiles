# dotfiles

## Setup steps
- Install Arch Linux
- Setup git
	- `git config --global user.email "<my email>" && git config --global user.name "<my username>"`
	- [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
	- [Adding a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- Clone this repo to ~/.dotfiles and `cd ~/.dotfiles && stow -t ~ */`
