## Things that require manual installation
----
### [Vim-Plug](https://github.com/junegunn/vim-plug)

`curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

`curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

### Oh-My-Zsh plugins

[zsh-autosuggestions] (https://github.com/zsh-users/zsh-autosuggestions)

`git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions`

[alias-tips] (https://github.com/djui/alias-tips)
`git clone https://github.com/djui/alias-tips.git $ZSH_CUSTOM/plugins/alias-tips`

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

### check if console supports 24bit - truecolor
`bash testcase-truecolors.sh`

![](http://i.imgur.com/2OfD8qT.png, "Truecolor")

![](http://i.imgur.com/B7npkfM.png, "Not really")


