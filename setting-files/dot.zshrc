alias gst="git status"
alias vim="nvim"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# claude code
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5 # europe-west1 if in Europe and don’t need Opus
export ANTHROPIC_VERTEX_PROJECT_ID=chronosphere-rc-b

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# droidcli setup
export DROIDCLI_MONOREPO_PATH="$HOME/workspace/monorepo"
export PATH="$DROIDCLI_MONOREPO_PATH/bin:$PATH"

# Secrets (HAPPO_API_KEY, HAPPO_API_SECRET, ...) live here so they stay out of git.
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
