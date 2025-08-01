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

function git-switch-account() {
  set -euo pipefail

  local json=~/.ssh/accounts.json

  local profile=$(jq -r '.[].identity' $json | fzf)
  local username=$(cat $json | jq ".[] | select(.identity==\"$profile\") | .username")
  local email=$(cat $json | jq ".[] | select(.identity==\"$profile\") | .email")

  git config --global user.name $username
  git config --global user.email $email
  echo "✅ git account switched to $profile"
}

function generate-ssh-config() {
  set -euo pipefail

  local json=~/.ssh/accounts.json
  local config=~/.ssh/config

  echo "# Auto-generated SSH config" > "$config"

  jq -r '.[] |
"Host \(.host)
\tHostName github.com
\tIdentityFile ~/.ssh/\(.identity)
\tIdentitiesOnly yes
"' "$json" >> "$config"

  # chmod 644 "$config"
  echo "✅ SSH config written to $config"
}

# ------------------------------------------------------------------------------
# 📁 Example ~/.ssh/ folder structure:
#
# ~/.ssh/
# ├── accounts.json        # Contains user profiles
# ├── config               # SSH config file (can be generated)
# ├── ashira-a             # Private key (workplace)
# ├── ashira-a.pub         # Public key (workplace)
# ├── deepaung             # Private key (personal)
# ├── deepaung.pub         # Public key (personal)
# └── known_hosts
#
# 🧾 Example accounts.json:
# [
#   {
#     "identity": "deepaung",
#     "username": "DeepAung",
#     "email": "deepaung@gmail.com",
#     "host": "github.com"
#   },
#   {
#     "identity": "ashira-a",
#     "username": "ashira.a",
#     "email": "ashira.a@gmail.com"
#     "host": "github.com-workplace"
#   }
# ]
# ------------------------------------------------------------------------------

function cowsay_random_thing() {
  cowsay_array=($(find /usr/share/cowsay/cows -type f))
  selected_cowsay=${cowsay_array[ $RANDOM % ${#cowsay_array[@]} ]}
  fortune | cowsay -f $selected_cowsay | lolcat
}

fastfetch --colors-block-range-start 9 --colors-block-width 3 --config arch
