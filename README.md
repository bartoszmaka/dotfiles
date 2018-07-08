#### TL;DR (requires curl)
###### set up most of required development software (not tested on osx yet)
``` bash
curl https://raw.githubusercontent.com/bartoszmaka/dotfiles/master/postinstall.sh >> postinstall.sh
bash postinstall.sh
```
or (requires git)
``` bash
git clone https://github.com/bartoszmaka/dotfiles ~/.repos/dotfiles
cd ~/.repos/dotfiles
bash postinstall.sh
```

---

#### Manual setup
#### [neovim](https://github.com/neovim/neovim)
- [install vim-plug](https://github.com/junegunn/vim-plug)
- [install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- install python provider (required for autocomplete)
  ``` bash
  pip2 install neovim
  pip3 install neovim
  ```
- install ruby provider
  ``` bash
  gem install neovim
  ```
- install npm plugins dependencies provider
  ``` bash
  npm install -g tern import-js
  ```
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
