#! /bin/bash
case "$(uname -s)" in
  Darwin)
    if ! [ -d .git ]; then
      # launching from tl;dr link
      git clone https://github.com/bartoszmaka/dotfiles ~/.repos/dotfiles
      cd ~/.repos/dotfiles
    fi

    if [ $install_packages == 'y' ]; then
    fi

    if [ $build_tmux ]; then
      brew install libevent ncurses reattach-to-user-namespace tmux
    fi

    if [ $setup_postgres ]; then
      brew cask install pgadmin4
    fi

    if [ $install_node == 'y' ]; then
      brew install node
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
      sudo apt install -y gcc perl autoconf pkg-config curl wget zsh xclip python-dev python-pip python3-dev python3-pip neovim silversearcher-ag
    fi

    if [ $build_tmux ]; then
      sudo apt install -y libncurses5 libncurses5-dev libevent-dev
    fi

    if [ $setup_postgres ]; then
      sudo apt install -y postgresql postgresql-contrib libpq-dev
      sudo -u postgres createuser --interactive # setup postgres account
    fi

    if [ $install_node == 'y' ]; then
      curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
      sudo apt-get install -y nodejs
      curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      sudo apt-get update && sudo apt-get install yarn
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

    if [ $install_postman == 'y' ]; then
      install_postman
    fi

    if [ $install_vim_plugins == 'y' ]; then
      nvim -c PlugInstall
    fi
    ;;
esac
