case "$(uname -s)" in
  Darwin)
      brew install neovim reattach-to-user-namespace tmux asdf gnupg coreutils curl git ripgrep git-delta imagemagick
      brew install --cask alacritty spectacle flux slack karabiner-elements lunar whatsapp iterm2 istat-menus alfred spotify contexts intel-power-gadget steam visual-studio-code
      brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    ;;

  Linux)
      git clone https://github.com/asdf-vm/asdf.git ~/.asdf
      cd ~/.asdf
      git checkout "$(git describe --abbrev=0 --tags)"
      cd -
      sudo add-apt-repository -y ppa:neovim-ppa/unstable
      sudo apt update -y
      sudo apt install -y gcc perl autoconf pkg-config curl wget zsh xclip \
        python-dev python-pip python3-dev python3-pip neovim \
        silversearcher-ag scrot tmux
    ;;
esac

asdf plugin-add postgres
asdf plugin-add ruby
asdf plugin-add python
asdf plugin-add nodejs
asdf plugin-add rust
asdf plugin-add redis
