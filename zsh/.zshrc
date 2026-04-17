# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Custom scripts
export PATH=~/.mybins:$PATH

# Prompt: show username only for non-default user or SSH sessions
prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
    fi
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Editor aliases
alias vi='nvim'
alias vim='nvim'
alias view='nvim -R'
alias python="python3"

# Mac-specific PATH
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
    export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
fi

# Machine-local settings (API keys, etc.) — not tracked by git
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

cd ~/Projects/

alias cc='CLAUDE_CODE_EFFORT_LEVEL=max claude'

