install_essential() {
    clear
    echo "installing essential packages"
    sudo apt update
    sudo apt install build-essential cmake make gcc
}

install_dev() {
    clear
    echo "installing packages for development"
    sudo apt update
    sudo apt install git zsh curl wget tmux bless fonts-hack-ttf
}

install_ubuntu() {
    clear
    echo "installing packages for ubuntu"
    sudo apt update
    sudo apt install redshift redshift-gtk indicator-multiload gparted unity-tweak-tool compizconfig-settings-manager psensor unrar thunderbird
}

install_multimedia() {
    clear
    echo "installing multimedia packages"
    sudo apt update
    sudo apt install vlc gimp inkscape
}

install_simplescreenrecorder() {
    clear
    echo "installing simple screen recorder"
    sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
    sudo apt update
    sudo apt install simplescreenrecorder
}

install_grub_customizer() {
    clear
    echo "installing grub customizer"
    sudo add-apt-repository ppa:danielrichter2007/grub-customizer
    sudo apt update
    sudo apt install grub-customzier
}

install_neovim() {
    echo "installing neovim requirements and dependencies"
    sudo apt install software-properties-common python-dev python-pip python3-dev python3-pip exuberant-ctags xclip make cmake gcc silversearcher-ag
    echo "installing neovim"
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install neovim
    echo "upgrading python provider"
    sudo -H pip install --upgrade pip
    sudo -H pip3 install --upgrade pip
    sudo -H pip install --upgrade neovim
    sudo -H pip3 install --upgrade neovim

    echo "installing vim-plug"
    echo "vim-plug" > ~/checklist
    echo "https://github.com/junegunn/vim-plug" > ~/checklist
    echo "after you install rvm -> `gem install neovim`" > ~/checklist

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "creating symlinks"
    ln -s ~/.vim ~/.config/nvim/.vim
    ln -s ~/.vimrc ~/.config/nvim/init.vim
}
fill_checklist() {
    echo "numix icons" > ~/checklist
    echo "add-apt-repository ppa:numix/ppa" > ~/checklist
    echo "gtk theme" > ~/checklist
    echo "add-apt-repository ppa:noobslab/themes" > ~/checklist
    echo "enable 24 bit colors in tmux" > ~/checklist
    echo "https://sunaku.github.io/tmux-24bit-color.html#usage" > ~/checklist
    echo "oh-my-zsh" > ~/checklist
    echo "https://github.com/robbyrussell/oh-my-zsh" > ~/checklist
    echo "change console bg to #282C34" > ~/checklist
    echo "change console font color to #A7AEBB" > ~/checklist
    echo "check zshrc" > ~/checklist
    echo "spotify" > ~/checklist
    echo "https://www.spotify.com/pl/download/linux/" > ~/checklist
    echo "virtualbox" > ~/checklist
    echo "https://www.virtualbox.org/wiki/Downloads" > ~/checklist
    echo "messenger" > ~/checklist
    echo "https://github.com/Aluxian/Messenger-for-Desktop/releases" > ~/checklist
    echo "rvm" > ~/checklist
    echo "https://rvm.io/rvm/install" > ~/checklist
}
clone_dotfiles() {
    # I assume, this file was downloaded from my repo to ~/dotfiles
    cp redshift.conf ~/.config/
    cp .vimrc ~/
    cp .rubocop.yml ~/
    cp .tmux.conf ~/
    sed -i -e 's/robbyrussell/agnoster/g' ~/.zshrc
}

fill_checklist
install_essential
install_dev
install_ubuntu
install_multimedia
install_grub_customizer
install_simplescreenrecorder
clone_dotfiles

echo "Downloading chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
