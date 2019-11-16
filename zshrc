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
test -e "$DOTFILES_PATH/secrets.sh" && source $DOTFILES_PATH/secrets.sh

export BAT_THEME='TwoDark'
export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='ag --hidden -g "" --ignore-dir .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export DOTFILES_PATH="$HOME/.repos/dotfiles"

test -e "~/.bin/tmuxinator.zsh" && source "~/.bin/tmuxinator.zsh"

alias tmux="tmux -u"
alias tnew="tmux -u new-session -t main"
alias spacevim="vim -u ~/.SpaceVim/init.vim"
alias spacenvim="nvim -u ~/.SpaceVim/init.vim"
alias svimrc="$EDITOR ~/.SpaceVim.d/init.toml"
alias vimrc="$EDITOR $DOTFILES_PATH/vim/vimrc"
alias zshrc="$EDITOR $DOTFILES_PATH/zshrc"
alias alacrittyrc="$EDITOR $DOTFILES_PATH/alacritty.yml"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias dotfiles="cd $DOTFILES_PATH"
alias snippets="cd $DOTFILES_PATH/vim/vimsnippets/"

alias -g F='| fzf --exact'
alias -g N='| nvim -'
alias -g C='| cat'
alias -g H='| head'
alias -g G!='| grep -v'
alias -g COL='| column -t -s " "'

alias bers="bundle exec rails server"
alias berc="bundle exec rails console"
alias berr="bundle exec rake routes F C"
alias bert="bundle exec rspec"
alias brp="echo 'pry-remote -w';pry-remote -w"
alias yri="rm -rf yarn.lock node_modules/ && yarn install"
alias yrm="rm -rf yarn.lock node_modules/"
alias ys="yarn start"
alias yi="yarn install"
alias n='nvim'

alias gcof="git checkout \$(git branch -a | fzf)"

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bartoszmaka/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bartoszmaka/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bartoszmaka/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bartoszmaka/Applications/google-cloud-sdk/completion.zsh.inc'; fi
