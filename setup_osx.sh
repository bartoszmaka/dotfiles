echo 'Running setup for osx'
echo 'copying config files'
cp -v ~/repos/dotfiles/osx/.tmux.conf ~/
cp -v ~/repos/dotfiles/.vimrc ~/
cp -v ~/repos/dotfiles/.rubocop.yml ~/
cp -v ~/repos/dotfiles/redshift.conf ~/.config/

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install python3 fzf automake the_silver_searcher libevent ncurses
brew install --HEAD neovim
pip3 install neovim psutil ipython
$(brew --prefix)/opt/fzf/install

