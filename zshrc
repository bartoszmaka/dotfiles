ostype="$(uname -s)"
isosx=false
islinux=false
case "$ostype" in
  Linux*) islinux=true;;
  Darwin*) isosx=true;;
esac

if [ "$isosx" = true ]; then
  export ZSH=/Users/bartoszmaka/.oh-my-zsh
fi
if [ "$islinux" = true ]; then
  export ZSH=/home/bartoszmaka/.oh-my-zsh
fi

ZSH_THEME="agnoster"

if [ "$isosx" = true ]; then
  plugins=(git tmux common-aliases rails zsh-autosuggestions zsh-syntax-highlighting alias-tips brew)
fi
if [ "$islinux" = true ]; then
  plugins=(git tmux common-aliases rails zsh-autosuggestions zsh-syntax-highlighting alias-tips)
fi

source $ZSH/oh-my-zsh.sh

export DEFAULT_USER='bartoszmaka'
export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function tattach() {
  tmux new-session -s `uuidgen` -t $1
}

test -e "~/.bin/tmuxinator.zsh" && source "~/.bin/tmuxinator.zsh"

alias vi="nvim -u ~/.noplugin_vimrc"
alias minivim="nvim -u ~/.minimal_vimrc"
alias vimrc="$EDITOR ~/.vimrc"
alias zshrc="$EDITOR ~/.zshrc"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias tnew="tmux new-session -t bartosz"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias ra="ranger"

alias -g F='| fzf --exact'
alias -g C='| column -t -s " "'
alias -g G!='| grep -v'

alias bers="bundle exec rails server"
alias berc="bundle exec rails console"
alias berr="bundle exec rake routes F C"
alias brp="echo 'pry-remote -w';pry-remote -w"

alias :wq=exit
alias :qa=exit
alias :wqa=exit

RPROMPT='%D{%K:%M:%S}'
export PATH="$PATH:$HOME/.rvm/bin"
fpath=(/usr/local/share/zsh-completions $fpath)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
