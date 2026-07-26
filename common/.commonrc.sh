export EDITOR=nvim
export VISUAL=nvim
export BROWSER=zen-browser
export TMUXIFIER_LAYOUT_PATH="$HOME/.dotfiles/tmuxifier/layouts/"
export ANDROID_HOME=$HOME/Android/Sdk

export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
export PATH="$PATH:${$(go env GOBIN):-$(go env GOPATH)/bin}"
export PATH="$PATH:$HOME/.duckdb/cli/latest"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/home/deepaung/.local/bin:$PATH"
eval "$(tmuxifier init -)"

# init nvm
source /usr/share/nvm/init-nvm.sh

# enable conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

alias ls='ls --color=auto'
alias l='ls -lah'
alias tmux='tmux -u'
alias v='nvim'
alias lg='lazygit'
alias k='kubectl'
alias hypr-change-wallpaper='hyprctl hyprpaper reload ,$(find ~/.dotfiles/wallpapers -type f | fzf)'
alias fs='sudo du -h --max-depth=1 | sort -hr'
alias fsh='fs | head -n 10'

# setup cisco anyconnect
alias vpn='/opt/cisco/anyconnect/bin/vpn'
alias vpnui='/opt/cisco/anyconnect/bin/vpnui'

function kde-change-wallpaper() {
  selected_wallpaper=$(find ~/.dotfiles/wallpapers -type f | fzf)
  if [[ -z "$selected_wallpaper" ]]; then
    echo "No wallpaper selected. Aborting."
    return 1
  fi

  dbus-send --session --dest=org.kde.plasmashell \
    --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript \
    "string:
  var Desktops = desktops();
  for (i = 0; i < Desktops.length; i++) {
      d = Desktops[i];
      d.wallpaperPlugin = \"org.kde.image\";
      d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
      d.writeConfig(\"Image\", \"${selected_wallpaper}\");
  }"
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function cowsay_random_thing() {
  cowsay_array=($(find /usr/share/cowsay/cows -type f))
  selected_cowsay=${cowsay_array[ $RANDOM % ${#cowsay_array[@]} ]}
  fortune | cowsay -f $selected_cowsay | lolcat
}

fastfetch --config arch
