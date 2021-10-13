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
  export DEFAULT_USER=`whoami` &&
  export ZSH=$HOME/.oh-my-zsh &&
  plugins=(git tmux common-aliases z rails zsh-autosuggestions zsh-syntax-highlighting alias-tips brew)

[ "$islinux" = true ] &&
  export DEFAULT_USER=`whoami` &&
  export ZSH=/home/bartosz/.oh-my-zsh &&
  plugins=(git tmux common-aliases z command-not-found rails zsh-autosuggestions zsh-syntax-highlighting alias-tips)

ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh
test -e "$DOTFILES_PATH/secrets.sh" && source $DOTFILES_PATH/secrets.sh

export BAT_THEME='TwoDark'
export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden -g '!.git/' -g '!node_modules/' -g '!tmp/' -g '!vendor/' -g '!doc/'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export DOTFILES_PATH="$HOME/.repos/dotfiles"

test -e "~/.bin/tmuxinator.zsh" && source "~/.bin/tmuxinator.zsh"

alias tmux="tmux -u"
alias tnew="\tmux -u new-session -t main"
alias spacevim="nvim -u ~/.SpaceVim/init.vim"
alias svimrc="$EDITOR ~/.SpaceVim.d/init.toml"
alias vimrc="cd $DOTFILES_PATH; $EDITOR $DOTFILES_PATH/vim/lua/plugins/init.lua; cd -"
alias zshrc="$EDITOR $DOTFILES_PATH/zshrc"
alias coderc="code $DOTFILES_PATH/vscode/settings.json $DOTFILES_PATH/vscode/keybindings.json"
alias alacrittyrc="$EDITOR $DOTFILES_PATH/alacritty.yml"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias dotfiles="cd $DOTFILES_PATH"
alias snippets="cd $DOTFILES_PATH/vim/vimsnippets/"
alias n='nvim'
alias oldvim='nvim -u $DOTFILES_PATH/vim/vimrc'

alias -g F='| fzf --exact'
alias -g N='| nvim -'
alias -g C='| cat'
alias -g H='| head'
alias -g G!='| grep -v'
alias -g COL='| column -t -s " "'

alias bers="bundle exec rails server"
alias berc="bundle exec rails console"
alias berr="bundle exec rake routes"
alias bert="bundle exec rspec"
alias bect="bundle exec cucumber"
alias brp="echo 'pry-remote -w';pry-remote -w"
alias yri="rm -rf yarn.lock node_modules/ && yarn install"
alias yrm="rm -rf yarn.lock node_modules/"
alias ys="yarn start"
alias yi="yarn install"
alias luavim='nvim -u $DOTFILES_PATH/vim/init.lua'
alias js='tmuxinator start frontend .'
alias mailcatcher='echo "running mailcatcher --foreground. If you want to use default mailcatcher - escape the alias"; mailcatcher --foreground'
alias tf="terraform"
alias ls="exa"
alias cat="bat"
alias lsplog="tail -f ~/.cache/nvim/lsp.log"
alias goneovim="/Applications/goneovim.app/Contents/MacOS/goneovim"
alias gclean="git clean -fd"

alias gcof="git checkout \$(git branch -a | fzf)"

alias :wq=exit
alias :qa=exit
alias :wqa=exit

alias cbc=compare_branch_commits
function compare_branch_commits() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
}
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath=(/usr/local/share/zsh-completions $fpath)

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
zstyle ':completion:*' menu select
export PATH="/usr/local/sbin:$PATH"
. $(brew --prefix asdf)/asdf.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=/opt/homebrew/bin:$PATH
export PATH="/usr/local/bin:$PATH" # make sure homebrew bins are before osx bins
