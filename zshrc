# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

ostype="$(uname -s)"
is_osx=false
is_linux=false
case "$ostype" in
  Linux*) is_linux=true;;
  Darwin*) is_osx=true;;
esac

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::rails
zinit snippet OMZP::brew
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::common-aliases
zinit snippet OMZL::key-bindings.zsh

# zinit load "zsh-users/zsh-autosuggestions"
# zinit load "djui/alias-tips"
# zinit load "zsh-users/zsh-syntax-highlighting"

zinit load zdharma-continuum/history-search-multi-word
zinit load zsh-users/zsh-autosuggestions
zinit load zdharma-continuum/fast-syntax-highlighting

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit load "agkozak/zsh-z"
autoload -U compinit; compinit
# export DEFAULT_USER=`whoami` &&
# export ZSH=$HOME/.oh-my-zsh &&
# [ "$isosx" = true ] &&
#   plugins=(git tmux common-aliases z rails zsh-autosuggestions zsh-syntax-highlighting alias-tips brew colored-man-pages)

# [ "$islinux" = true ] &&
#   plugins=(git tmux common-aliases z command-not-found rails zsh-autosuggestions zsh-syntax-highlighting alias-tips colored-man-pages)

# ZSH_THEME="agnoster"

# source $ZSH/oh-my-zsh.sh
# test -e "$DOTFILES_PATH/secrets.sh" && source $DOTFILES_PATH/secrets.sh
test -e "~/.bin/tmuxinator.zsh" && source "~/.bin/tmuxinator.zsh"

export BAT_THEME='TwoDark'
export DISABLE_SPRING=1
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden -g '!.git/' -g '!node_modules/' -g '!tmp/' -g '!vendor/' -g '!doc/'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export DOTFILES_PATH="$HOME/.repos/dotfiles"
export DEFAULT_USER=`whoami`

RPROMPT='%D{%K:%M:%S}'
zstyle ':completion:*' menu select

alias tmux="tmux -u"
alias tnew="\tmux -u new-session -t main"
alias spacevim="nvim -u ~/.SpaceVim/init.vim"
alias svimrc="$EDITOR ~/.SpaceVim.d/init.toml"
alias vimrc="cd $DOTFILES_PATH; $EDITOR $DOTFILES_PATH/vim/lua/plugins/init.lua; cd -"
alias zshrc="$EDITOR $DOTFILES_PATH/zshrc"
alias coderc="code $DOTFILES_PATH/vscode/settings.json $DOTFILES_PATH/vscode/keybindings.json"
alias alacrittyrc="$EDITOR $DOTFILES_PATH/alacritty.yml"
alias kittyrc="$EDITOR $DOTFILES_PATH/kitty/kitty.conf"
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
alias ys="yarn start"
alias mailcatcher='echo "running mailcatcher --foreground. If you want to use default mailcatcher - escape the alias"; mailcatcher --foreground'
alias tf="terraform"
alias ls="exa"
alias cat="bat"
alias lsplog="tail -f ~/.cache/nvim/lsp.log"
alias nulllslog="tail -f ~/.cache/nvim/null-ls.log"
alias gclean="git clean -fd"
alias gcof="git checkout \$(git branch -a | fzf)"
alias ggpush="git push origin \$(git branch --show-current)"
alias subster="tmuxinator start subster"
alias sublime="./Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

alias :wq=exit
alias :qa=exit
alias :wqa=exit

alias cbc=compare_branch_commits
function compare_branch_commits() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
}
function tattach() { tmux new-session -s `uuidgen` -t $1 }


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. $(brew --prefix asdf)/asdf.sh
export PATH=/opt/homebrew/bin:$PATH
export PATH="/usr/local/bin:$PATH" # make sure homebrew bins are before osx bins

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_BACKGROUND=236
typeset -g POWERLEVEL9K_DIR_FOREGROUND=232
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=232
typeset -g POWERLEVEL9K_LEFT_LEFT_WHITESPACE=' '
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%k%F{$POWERLEVEL9K_BACKGROUND}\uE0B4%k \uE0B6"
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="%k%F{$POWERLEVEL9K_BACKGROUND}\uE0B4%k \uE0B6"
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6'
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
