export ZSH=/Users/bartosz/.oh-my-zsh
export HOMEBREW_GITHUB_API_TOKEN=""

ZSH_THEME="agnoster"

plugins=(git common-aliases rails zsh-autosuggestions zsh-syntax-highlighting alias-tips)

source $ZSH/oh-my-zsh.sh

# User configuration

export DEFAULT_USER='bartosz'
export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias vi="nvim -u ~/.noplugin_vimrc"
alias minivim="nvim -u ~/.minimal_vimrc"
alias vimrc="$EDITOR ~/.vimrc"
alias zshrc="$EDITOR ~/.zshrc"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias tnew="tmux new-session -t bartosz"
alias tattach="tmux new-session -s bartosz2 -t bartosz"

alias -g F='| fzf --exact'

PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
