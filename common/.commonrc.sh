[[ -s "/home/deepaung/.gvm/scripts/gvm" ]] && source "/home/deepaung/.gvm/scripts/gvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.cargo/env"

# PATHS
export PATH="$PATH:/opt"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/opt/speedtest"
export PATH="$HOME/.tmuxifier/bin:$PATH"

export BROWSER=wslview
export EDITOR=nvim
export LC_ALL=en_US.UTF-8

eval "$(tmuxifier init -)"
alias tmux='tmux -u'
alias actconda='source ~/anaconda3/bin/activate'
