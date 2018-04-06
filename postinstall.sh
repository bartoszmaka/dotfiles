#! /bin/bash
function copy_fonts {
  case "$(uname -s)" in
    Darwin)
      cp -r ~/.repos/dotfiles/fonts ~/Library/Fonts/
      ;;
    Linux)
      cp -r ~/.repos/dotfiles/fonts ~/.fonts
      ;;
  esac
}

function build_tmux {
  git clone https://github.com/tmux/tmux ~/.repos/tmux
  cd ~/.repos/tmux
  sh autogen.sh
  ./configure
  make
  sudo make install
  cd -
}

function build_ctags {
  git clone https://github.com/universal-ctags/ctags ~/.repos/ctags
  cd ~/.repos/ctags
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd -
}

function build_alt {
  git clone https://github.com/uptech/alt ~/.repos/alt
  cd ~/.repos/alt
  cargo build --release
  cd -
  sudo cp -v ~/.repos/alt/target/release/alt /usr/local/bin
  sudo cp -v ~/.repos/alt/doc/alt.1 /usr/local/share/man/man1/
}

function build_tools_from_source {
  if [ $build_tmux == 'y' ]; then
    build_tmux
  fi

  if [ $build_ctags == 'y' ]; then
    build_ctags
  fi

  if [ $build_alt == 'y' ]; then
    build_alt
  fi
}

function setup_vim_plug {
  mkdir -p ~/.config/nvim
  mkdir -p ~/.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function setup_oh_my_zsh {
  echo "type 'exit' after oh my zsh is installed"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  sed -ie 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"'/ ~/.zshrc
}

function setup_symlinks {
  ln -vsf ~/.repos/dotfiles/noplugin_vimrc ~/.noplugin_vimrc
  ln -vsf ~/.repos/dotfiles/vimrc ~/.vimrc
  ln -vsf ~/.repos/dotfiles/vimrc ~/.config/nvim/init.vim
  ln -vsf ~/.repos/dotfiles/global_gitignore ~/.gitignore
  ln -vsf ~/.vim ~/.config/nvim/.vim
}

function setup_rust {
  curl https://sh.rustup.rs -sSf | sh
  source $HOME/.cargo/env
}

echo 'Install packages? [y/n]'
read install_packages
echo 'Setup postgres? [y/n]'
read setup_postgres
echo 'Install rust? [y/n]'
read install_rust
echo 'Install vim plug? [y/n]'
read install_plug
echo 'Copy fonts? [y/n]'
read copy_fonts
echo 'Install oh my zsh? [y/n]'
read install_ohmyzsh
echo 'Create symlinks? [y/n]'
read create_symlinks
echo 'Build ctags from source? [y/n]'
read build_ctags
echo 'Build alt from source? [y/n]'
read build_alt
echo 'Build tmux from source? [y/n]'
read build_tmux
echo 'Install vim plugins? [y/n]'
read install_vim_plugins

case "$(uname -s)" in
  Darwin)
    if ! [ -d .git ]; then
      # launching from tl;dr link
      git clone https://github.com/bartoszmaka/dotfiles ~/.repos/dotfiles
      cd ~/.repos/dotfiles
    fi


    if [ $install_packages == 'y' ]; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew install automake libevent ncurses reattach-to-user-namespace python3 brew-cask the_silver_searcher neovim zsh-completions tmux
      brew cask install iterm2 spectacle pgadmin4
    fi

    if [ $install_rust == 'y' ]; then
      setup_rust
    fi

    if [ $install_plug == 'y' ]; then
      setup_vim_plug
    fi

    if [ $copy_fonts == 'y' ]; then
      copy_fonts
    fi
    if [ $install_ohmyzsh == 'y' ]; then
      setup_oh_my_zsh
    fi

    if [ $create_symlinks == 'y' ]; then
      setup_symlinks
    fi

    if [ $install_vim_plugins == 'y' ]; then
      nvim -c PlugInstall
    fi
    ;;

  Linux)
    if ! [ -d .git ]; then
      # launching from tl;dr link
      sudo apt install -y git;
      git clone https://github.com/bartoszmaka/dotfiles ~/.repos/dotfiles
      cd ~/.repos/dotfiles
    fi

    if [ $install_packages == 'y' ]; then
      sudo add-apt-repository -y ppa:neovim-ppa/unstable
      sudo apt update -y
      sudo apt install -y gcc perl autoconf pkg-config curl wget zsh xclip libncurses5 libncurses5-dev libevent-dev python-dev python-pip python3-dev python3-pip neovim postgresql postgresql-contrib silversearcher-ag
    fi

    if [ $setup_postgres == 'y' ]; then
      sudo -u postgres createuser --interactive # setup postgres account
    fi

    if [ $install_rust == 'y' ]; then
      setup_rust
    fi

    if [ $install_plug == 'y' ]; then
      setup_vim_plug
    fi

    if [ $copy_fonts == 'y' ]; then
      copy_fonts
    fi

    if [ $install_ohmyzsh == 'y' ]; then
      setup_oh_my_zsh
    fi

    if [ $create_symlinks == 'y' ]; then
      setup_symlinks
    fi

    build_tools_from_source

    if [ $install_vim_plugins == 'y' ]; then
      nvim -c PlugInstall
    fi
    ;;

  CYGWIN*|MINGW32*|MSYS*)
    echo "Good luck"
    ;;
esac
