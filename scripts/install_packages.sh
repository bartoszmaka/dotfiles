case "$(uname -s)" in
  Darwin)
      brew install the_silver_searcher neovim reattach-to-user-namespace tmux diff-so-fancy asdf gnupg coreutils curl git ripgrep git-delta imagemagick
      brew cask install alacritty spectacle flux slack karabiner-elements lunar whatsapp iterm2 goofy istat-menus alfred spotify contexts intel-power-gadget steam
      brew install --HEAD universal-ctags/universal-ctags/universal-ctags
      asdf plugin-add postgres
      asdf plugin-add ruby
      asdf plugin-add python
      asdf plugin-add nodejs
      asdf plugin-add rust
      asdf plugin-add redis
    ;;

  Linux)
      sudo add-apt-repository -y ppa:neovim-ppa/unstable
      sudo apt update -y
      sudo apt install -y gcc perl autoconf pkg-config curl wget zsh xclip \
        python-dev python-pip python3-dev python3-pip neovim \
        silversearcher-ag scrot tmux
    ;;
esac
