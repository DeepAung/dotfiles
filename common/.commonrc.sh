export EDITOR=nvim
export BROWSER=zen-browser

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

source /usr/share/nvm/init-nvm.sh

alias tmux='tmux -u'
alias actconda='source /opt/miniconda3/etc/profile.d/conda.sh'
alias wallpaper='hyprctl hyprpaper reload ,$(find ~/.dotfiles/wallpapers -type f | fzf)'
alias v='nvim'
alias lg='lazygit'

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# rainbow cowsay say random thing
cowsay_array=($(ls /usr/share/cowsay/cows/))
cowsay_variant=${cowsay_array[ $RANDOM % ${#cowsay_array[@]} ]}
fortune | cowsay -f /usr/share/cowsay/cows/$cowsay_variant | lolcat

# # cbonsai say random thing
# random_text=$(fortune)
# cbonsai -p -c "OwO" -m $random_text
