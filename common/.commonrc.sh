export EDITOR=nvim
export VISUAL=nvim
export BROWSER=zen-browser

export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
export PATH="$PATH:${$(go env GOBIN):-$(go env GOPATH)/bin}"
export PATH="$PATH:$HOME/.duckdb/cli/latest"
eval "$(tmuxifier init -)"

source /usr/share/nvm/init-nvm.sh

alias ls='ls --color=auto'
alias l='ls -lah'
alias tmux='tmux -u'
alias v='nvim'
alias lg='lazygit'
alias k='kubectl'
alias actconda='source /opt/miniconda3/etc/profile.d/conda.sh'
alias hypr-change-wallpaper='hyprctl hyprpaper reload ,$(find ~/.dotfiles/wallpapers -type f | fzf)'
alias kde-change-wallpaper='bash ~/.dotfiles/common/kde-change-wallpaper.sh'

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
