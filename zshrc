export ZSH=/Users/bartosz/.oh-my-zsh
export HOMEBREW_GITHUB_API_TOKEN=""

ZSH_THEME="agnoster"


plugins=(git common-aliases rails zsh-autosuggestions zsh-syntax-highlighting alias-tips)

source $ZSH/oh-my-zsh.sh

export DEFAULT_USER='bartosz'
export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias vi="nvim -u ~/.noplugin_vimrc"
alias minivim="nvim -u ~/.minimal_vimrc"
alias vimrc="$EDITOR ~/.vimrc"
alias zshrc="$EDITOR ~/.zshrc"

PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
export PATH="$PATH:$HOME/.rvm/bin"
fpath=(/usr/local/share/zsh-completions $fpath)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
