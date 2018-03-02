#! /bin/bash

function build_tmux {
  git clone https://github.com/tmux/tmux ~/.repos/tmux
  cd ~/.repos/tmux
  sh autogen.sh
  ./configure
  make
  cd -
}

function build_ctags {
  git clone https://github.com/universal-ctags/ctags ~/.repos/ctags
  cd ~/.repos/ctags
  ./autogen.sh
  ./configure
  make
  cd -
}

function build_alt {
  git clone https://github.com/uptech/alt ~/.repos/alt
  cd ~/.repos/alt
  cargo build --release
  cd -
}

function build_repos {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  build_tmux
  build_ctags
  build_alt
}

function setup_oh_my_zsh {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  # sed -ie 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"'/ ~/.zshrc
  # sed -ie 's/^plugins=\(\n\ \ git\n\)/source ~\/.repos\/dotfiles\/zsh_plugins.sh/' ~/.zshrc
}

case "$(uname -s)" in
  Darwin)
    md -p ~/.config/nvim
    md -p ~/.vim

    build_repos

    ln -vsf ~/.repos/dotfiles/noplugin_vimrc ~/.noplugin_vimrc
    ln -vsf ~/.repos/dotfiles/vimrc ~/.vimrc
    ln -vsf ~/.repos/dotfiles/vimrc ~/.config/nvim/init.vim
    ln -vsf ~/.repos/dotfiles/global_gitignore ~/.gitignore
    ln -vsf ~/.vim ~/.config/nvim/.vim
    ;;

  Linux)
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update -y
    sudo apt install -y gcc perl curl wget git zsh pkg-config autoconf libncurses5 libncurses5-dev libevent-dev xclip python-dev python-pip python3-dev python3-pip neovim
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
    mkdir -p ~/.config/nvim
    mkdir -p ~/.vim
    cp -r ~/.repos/dotfiles/fonts ~/.fonts

    build_repos

    setup_oh_my_zsh

    ln -vsf ~/.repos/dotfiles/noplugin_vimrc ~/.noplugin_vimrc
    ln -vsf ~/.repos/dotfiles/vimrc ~/.vimrc
    ln -vsf ~/.repos/dotfiles/vimrc ~/.config/nvim/init.vim
    ln -vsf ~/.repos/dotfiles/global_gitignore ~/.gitignore
    ln -vsf ~/.vim ~/.config/nvim/.vim

    cd ~/.repos/tmux && sudo make install
    cd ~/.repos/ctags && sudo make install
    cp ~/.repos/alt/target/release/alt /usr/local/bin
    cp ~/.repos/alt/doc/alt.1 /usr/local/share/man/man1/
    ;;

  CYGWIN*|MINGW32*|MSYS*)
    echo "Good luck"
    ;;
esac
