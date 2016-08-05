echo "Download virtualbox, skype, playonlinux and chrome .deb manually? [y=confirm] "
read input
if [ $input = "t" ] ; then
    firefox https://www.skype.com/pl/download-skype/skype-for-linux/downloading/?type=ubuntu64 https://www.google.pl/chrome/browser/desktop/ https://www.virtualbox.org/wiki/Linux_Downloads https://www.playonlinux.com/script_files/PlayOnLinux/4.2.10/PlayOnLinux_4.2.10.deb
fi
clear
echo "adding neovim, grub-customizer, simplescreenrecorder and numix repositories"
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo apt-add-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
clear
echo "updating and upgrading system"
sudo apt -y update
sudo apt -y upgrade
clear
echo "downloading additional packages"
sudo apt -y install software-properties-common zsh git python-pip python3-pip python-dev python3-dev exuberant-ctags xclip silversearcher-ag synaptic psensor redshift redshift-gtk dconf-editor gparted simplescreenrecorder grub-customizer neovim numix-icon-theme numix-gtk-theme numix-icon-theme-circle fonts-hack-ttf
clear
echo "upgrading pip and neovim"
pip2 install --upgrade pip
pip3 install --upgrade pip
pip2 install --upgrade neovim
pip3 install --upgrade neovim
clear
echo "downloading plugins manager for vim and neovim"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# neovim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
clear
echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
clear
echo "downloading personal dotfiles repository"
git clone https://github.com/bartoszmaka/dotfiles.git dotfiles
cp -v ~/dotfiles/.vimrc ~/
cp -v ~/dotfiles/.zshrc ~/
cp -v ~/dotfiles/redshift.conf ~/.config
ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ~/.vim ~/.config/nvim/.vim
