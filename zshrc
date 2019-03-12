setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

ostype="$(uname -s)"
isosx=false
islinux=false
case "$ostype" in
  Linux*) islinux=true;;
  Darwin*) isosx=true;;
esac

[ "$isosx" = true ] &&
  export DEFAULT_USER='bartoszmaka' &&
  export ZSH=/Users/bartoszmaka/.oh-my-zsh &&
  plugins=(git tmux common-aliases z rails zsh-autosuggestions zsh-syntax-highlighting alias-tips brew)

[ "$islinux" = true ] &&
  export DEFAULT_USER='bartosz' &&
  export ZSH=/home/bartosz/.oh-my-zsh &&
  plugins=(git tmux common-aliases z command-not-found rails zsh-autosuggestions zsh-syntax-highlighting alias-tips)

ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh
source $DOTFILES_PATH/secrets.sh

export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export DOTFILES_PATH="$HOME/.repos/dotfiles"

test -e "~/.bin/tmuxinator.zsh" && source "~/.bin/tmuxinator.zsh"

alias spacevim="nvim -u ~/.SpaceVim/init.vim"
alias vi="nvim -u ~/.noplugin_vimrc"
alias minivim="nvim -u ~/.minimal_vimrc"
alias vimrc="$EDITOR $DOTFILES_PATH/vimrc"
alias zshrc="$EDITOR $DOTFILES_PATH/zshrc"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias tnew="tmux new-session -t main"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias dotfiles="cd $DOTFILES_PATH"
alias svim='vim -u ~/.SpaceVim/vimrc'
alias svimrc="$EDITOR ~/.SpaceVim.d/init.toml"
alias snippets="cd $DOTFILES_PATH/vim/vimsnippets/"

alias -g F='| fzf --exact'
alias -g C='| column -t -s " "'
alias -g G!='| grep -v'

alias bers="bundle exec rails server"
alias berc="bundle exec rails console"
alias berr="bundle exec rake routes F C"
alias brp="echo 'pry-remote -w';pry-remote -w"
alias yri="rm -rf yarn.lock node_modules/ && yarn install"
alias yrm="rm -rf yarn.lock node_modules/"
alias ys="yarn start"
alias yi="yarn install"

alias :wq=exit
alias :qa=exit
alias :wqa=exit

function tattach() { tmux new-session -s `uuidgen` -t $1 }
function npmdo { $(npm bin)/$@ }
function startWithTmux() {
  if test -z $TMUX
  then
    tnew
  else
    tattach main
  fi
}

unalias gsd

RPROMPT='%D{%K:%M:%S}'
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
export PATH="/usr/local/bin:$PATH" # make sure homebrew bins are before osx bins
