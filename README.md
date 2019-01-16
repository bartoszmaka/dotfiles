#### basic custom vim shortcuts
```
  mapping      mode        description

  C-p C-p      [NORMAL] => fuzzy search file
  C-p C-r      [NORMAL] => fuzzy search recent file
  C-p C-l      [NORMAL] => fuzzy search line in file
  C-p C-f      [NORMAL] => fuzzy search string in project

  C-k C-e      [NORMAL] => toggle NERDTree
  C-k C-f      [NORMAL] => find current file in NERDTree

  C-m C-s      [VISUAL] => sort selected lines
  C-m C-t      [VISUAL] => align by pattern
  C-m C-f      [NORMAL] => fix file with ALE fixer (e.g. eslint for js)
  C-m C-s      [NORMAL] => break statement into multiple lines
  <leader> j   [NORMAL] => break line
  <leader> k   [NORMAL] => join to previous line

  C-g C-b      [NORMAL] => toggle git blame buffer
  C-g C-d      [NORMAL] => toggle git diff buffer

  C-n          [NORMAL] => add cursor in next word occurrence
  C-n          [VISUAL] => add cursor in next selected pattern occurrence

  <leader> r   [NORMAL] => replace current word
  <leader> r   [VISUAL] => replace selected pattern
  <leader> t o [VISUAL] => go to test file
```

#### Manual setup
#### [neovim](https://github.com/neovim/neovim)
- [install vim-plug](https://github.com/junegunn/vim-plug)
- [install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- install python provider and language server
  ``` bash
  pip2 install neovim
  pip3 install neovim
  pip3 install 'python-language-server[all]'
  ```
- install ruby provider and language server
  ``` bash
  gem install neovim solargraph yard
  # index project with `yard gems`
  ```
- install npm provider, language server and plugin dependencies
  ``` bash
  npm install -g neovim tern typescript typescript-language-server javascript-typescript-langserver eslint importjs
  ```
- install system plugins dependencies
  ``` bash
  brew install the_silver_searcher
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags

  sudo apt install silversearcher_ag
  build ctags from source
  ```
- install json formatter
  ```
  brew install jq
  sudo apt install jq
  ```
- setup rust and install `alt` (see below)
- place `vimrc` in proper location - `~/.config/nvim/init.vim`

- install plugins with `:PlugInstall` (inside neovim)


neovim plugins dependencies

[https://github.com/junegunn/vim-plug](https://github.com/junegunn/vim-plug)  
[https://github.com/ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher)  
[https://github.com/universal-ctags/ctags](https://github.com/universal-ctags/ctags)  
[https://github.com/uptech/alt](https://github.com/uptech/alt)  



#### [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)
- install oh my zsh
  ``` bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
- place `zshrc` in proper location - `~/.zshrc`
- install plugins, that are not downloaded by default

  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  
  ``` bash
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  ```
  
  [alias-tips](https://github.com/djui/alias-tips)
  
  ``` bash
  git clone https://github.com/djui/alias-tips.git $ZSH_CUSTOM/plugins/alias-tips
  ```
  
  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  
  ``` bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```
  
#### [tmux](https://github.com/tmux/tmux/wiki)
- install ncurses and libevent
  ```
  brew install ncurses libevent
  ```
- install tmux
  ```
  brew install tmux
  ```
  or
  ```
  git clone https://github.com/tmux/tmux.git
  cd tmux
  sh autogen.sh
  ./configure && make
  ```
- place `.tmux.conf` in proper location `~/.tmux.conf`


#### iTerm2
##### workaround, to get meta key bindings working in vim and tmux

```
preferences > profiles > keys
map
cmd [	send hex 0x20 0x5b
cmd ]	send hex 0x20 0x5d
cmd h	send hex 0x0  0x68
cmd j	send hex 0x0  0x6a
cmd k	send hex 0x0  0x6b
cmd l	send hex 0x0  0x6c
cmd {	send hex 0x0  0x70
cmd }	send hex 0x0  0x6e
# 0x20 - space
# 0x17 - <C-w>
# 0x0  - <C-space>
```

##### colorscheme

TODO

#### Other apps
```
brew cask install spectacle slack flux iterm2 
```
---

#### Config files proper location

``` bash
~/.config/redshift.conf  
~/.config/alacritty/alacritty.yml  
~/.imwheelrc  
~/.vimrc  
~/.tmux.conf  
~/.zshrc  
~/.rubocop.yml  
~/.tmux/plugins/tmux-powerline/themes/default.sh
```

---

#### References

[https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors](https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors)  
[https://pilotmoon.com/scrollreverser/](https://pilotmoon.com/scrollreverser/)  
[alt left / right behavior for iterm2](https://apple.stackexchange.com/questions/136928/using-alt-cmd-right-left-arrow-in-iterm)  
[sync iterm2 with dotfiles](http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)  
