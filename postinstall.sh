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
  build_tmux
  build_ctags
  build_alt
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

case "$(uname -s)" in
  Darwin)
    if ! [ -d .git ]; then
      # launching from tl;dr link
      git clone https://gitub.com/bartoszmaka/dotfiles ~/.repos/dotfiles
      cd ~/.repos/dotfiles
    fi

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew install \
      automake \                                      # build dependencies
      libevent ncurses reattach-to-user-namespace \   # tmux dependencies
      python3 brew-cask \                             # other dependencies
      the_silver_searcher neovim zsh-completions tmux # tools

    brew cask install iterm2 spectacle pgadmin4

    setup_rust
    setup_vim_plug
    copy_fonts
    setup_oh_my_zsh
    setup_symlinks

    nvim -c PlugInstall
    ;;

  Linux)
    if ! [ -d .git ]; then
      # launching from tl;dr link
      sudo apt install -y git;
      git clone https://gitub.com/bartoszmaka/dotfiles ~/.repos/dotfiles
      cd ~/.repos/dotfiles
    fi

    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update -y
    sudo apt install -y \ 
      gcc perl autoconf pkg-config \                         # build dependencies
      curl wget zsh xclip \                                  # basic tools
      libncurses5 libncurses5-dev libevent-dev \             # tmux dependencies
      python-dev python-pip python3-dev python3-pip neovim \ # neovim dependencies
      postgresql postgresql-contrib                          # postgresql

    sudo -u postgres createuser --interactive # setup postgres account

    setup_rust
    setup_vim_plug
    copy_fonts
    setup_oh_my_zsh
    setup_symlinks
    build_tools_from_source

    nvim -c PlugInstall
    ;;

  CYGWIN*|MINGW32*|MSYS*)
    echo "Good luck"
    ;;
esac
