echo "Installing packages..."

case "$(uname -s)" in
  Darwin)
      brew install neovim reattach-to-user-namespace tmux asdf gnupg coreutils curl git ripgrep git-delta imagemagick wget
      brew install --cask alacritty spectacle slack karabiner-elements whatsapp iterm2 istat-menus alfred spotify contexts steam visual-studio-code monitorcontrol chromedriver tradingview binance
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

echo "Installing asdf..."

asdf plugin-add postgres
asdf plugin-add ruby
asdf plugin-add python
asdf plugin-add nodejs
asdf plugin-add rust
asdf plugin-add redis

echo "Copying fonts"

case "$(uname -s)" in
  Darwin)
    cp -r ~/.repos/dotfiles/resources/fonts ~/Library/Fonts/
    ;;
  Linux)
    cp -r ~/.repos/dotfiles/resources/fonts ~/.fonts
    ;;
esac

echo "Setting up oh my zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Creating symlinks"

mkdir -p ~/.config/ranger
mkdir -p ~/.config/nvim
mkdir -p ~/.config/alacritty

# vim files
ln -vsf ~/.repos/dotfiles/vim/init.lua ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/lua ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/UltiSnips ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/vsnip ~/.vsnip

ln -vsf ~/.repos/dotfiles/zshrc ~/.zshrc
ln -vsf ~/.repos/dotfiles/resources/global_gitignore ~/.gitignore
ln -vsf ~/.repos/dotfiles/resources/gitconfig ~/.gitconfig
ln -vsf ~/.repos/dotfiles/resources/rubocop.yml ~/.rubocop.yml
ln -vsf ~/.repos/dotfiles/resources/pryrc ~/.pryrc
ln -vsf ~/.repos/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -vsf ~/.repos/dotfiles/jetbrains/ideavimrc ~/.ideavimrc
ln -vsf ~/.repos/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -vsf ~/.repos/dotfiles/kitty/macos-launch-serviecs-cmdline ~/.config/kitty/macos-launch-serviecs-cmdline

ln -vsf ~/.repos/dotfiles/asdf/default-npm-packages ~/.default-npm-packages
ln -vsf ~/.repos/dotfiles/asdf/default-gems ~/.default-gems
ln -vsf ~/.repos/dotfiles/asdfrc ~/.asdfrc

ln -vsf ~/.repos/dotfiles/tmux ~/
ln -vsf ~/.repos/dotfiles/tmuxinator ~/
ln -vsf ~/.repos/dotfiles/tmuxinator ~/.config/

case "$(uname -s)" in
  Darwin)
    mkdir -p ~/Library/Application\ Support/Code/User
    mkdir -p ~/.config/karabiner

    ln -vsf ~/.repos/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -vsf ~/.repos/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
    ln -vsf ~/.repos/dotfiles/vscode/snippets ~/Library/Application\ Support/Code/User
    ln -vsf ~/.repos/dotfiles/resources/osx/tmux.conf ~/.tmux.conf
    ln -vsf ~/.repos/dotfiles/resources/osx/rc.conf ~/.config/ranger/rc.conf
    ln -vsf ~/.repos/dotfiles/resources/osx/karabiner.json ~/.config/karabiner/karabiner.json
    ;;
  Linux)
    ln -vsf ~/.repos/dotfiles/resources/linux/tmux.conf ~/.tmux.conf
    ln -vsf ~/.repos/dotfiles/resources/linux/rc.conf ~/.config/ranger/rc.conf
    ln -vsf ~/.repos/dotfiles/resources/linux/redshift.conf ~/.config/redshift.conf
    ;;
esac
