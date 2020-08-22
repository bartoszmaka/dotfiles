case "$(uname -s)" in
  Darwin)
      brew install python3 the_silver_searcher neovim reattach-to-user-namespace tmux diff-so-fancy asdf gnupg coreutils curl git 
      brew cask install alacritty spectacle flux slack karabiner-elements lunar whatsapp iterm2 goofy istat-menus alfred spotify ripgrep contexts intel-power-gadget
      asdf plugin-add postgres
      asdf plugin-add ruby
      asdf plugin-add python
      asdf plugin-add node
    ;;

  Linux)
      sudo add-apt-repository -y ppa:neovim-ppa/unstable
      sudo apt update -y
      sudo apt install -y gcc perl autoconf pkg-config curl wget zsh xclip \
        python-dev python-pip python3-dev python3-pip neovim \
        silversearcher-ag scrot tmux
    ;;
esac
