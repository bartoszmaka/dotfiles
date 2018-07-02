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
##### neovim
- [install vim-plug](https://github.com/junegunn/vim-plug)
- [install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- install python provider (required for autocomplete)
  ``` bash
  pip2 install neovim
  pip3 install neovim
  ```
- place `vimrc` in proper location - `~/.config/nvim/init.vim`
- install plugins with `:PlugInstall` (inside neovim)


#### neovim plugins dependencies

[https://github.com/junegunn/vim-plug](https://github.com/junegunn/vim-plug)  
[https://github.com/ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher)  
[https://github.com/universal-ctags/ctags](https://github.com/universal-ctags/ctags)  
[https://github.com/uptech/alt](https://github.com/uptech/alt)  

---

#### Oh-My-Zsh Plugins


##### [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) plugins

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

---

#### iTerm2
##### workaround, to get `<M-[>`, `<M-S-[` working in vim and tmux

TODO

##### colorscheme

TODO

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
