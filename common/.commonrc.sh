export EDITOR=nvim
export BROWSER=zen-browser
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.duckdb/cli/latest"
eval "$(tmuxifier init -)"

source /usr/share/nvm/init-nvm.sh

alias tmux='tmux -u'
alias actconda='source /opt/miniconda3/etc/profile.d/conda.sh'
alias hypr-change-wallpaper='hyprctl hyprpaper reload ,$(find ~/.dotfiles/wallpapers -type f | fzf)'
alias kde-change-wallpaper='bash /home/deepaung/.dotfiles/common/kde-change-wallpaper.sh'
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
cowsay_array=($(find /usr/share/cowsay/cows -type f))
selected_cowsay=${cowsay_array[ $RANDOM % ${#cowsay_array[@]} ]}
fortune | cowsay -f $selected_cowsay | lolcat

# # cbonsai say random thing
# random_text=$(fortune)
# cbonsai -p -c "OwO" -m $random_text
