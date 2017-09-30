echo 'Creating neovim symlinks'
cd ~/
mkdir -pv ~/.config/nvim
ln -sv ~/.vim ~/.config/nvim.vim
ln -sv ~/.vimrc ~/.config/init.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Downloading github repost'
mkdir -pv ~/repos
cd ~/repos
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &
git clone https://github.com/tmux/tmux &
git clone https://github.com/jwilm/alacritty &
git clone https://github.com/universal-ctags/ctags &

echo 'Checking system'
cd ~/repos/dotfiles
if [ "$(uname)" == "Darwin" ]; then
  sh setup_osx.sh
elif [ "$(uname)" == "Linux" ]; then
  if [ "$(lsb_release -is)" == "Ubuntu" ]; then
    sh setup_ubuntu.sh
  elif [ "$(lsb_release -is)" == "Fedora" ]; then
    sh setup_fedora.sh
  fi
fi
