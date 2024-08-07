mkdir -p ~/.config/nvim
mkdir -p ~/.config/alacritty

# vim files
ln -vsf ~/.repos/dotfiles/vim/nvim-logo.sh ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/init.lua ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/lua ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/UltiSnips ~/.config/nvim/
ln -vsf ~/.repos/dotfiles/vim/vsnip ~/.vsnip
# ln -vfs ~/.repos/dotfiles/vim/lazy-lock.json ~/.config/nvim

ln -vsf ~/.repos/dotfiles/zshrc ~/.zshrc
ln -vsf ~/.repos/dotfiles/resources/global_gitignore ~/.gitignore
ln -vsf ~/.repos/dotfiles/resources/gitconfig ~/.gitconfig
ln -vsf ~/.repos/dotfiles/resources/rubocop.yml ~/.rubocop.yml
ln -vsf ~/.repos/dotfiles/resources/pryrc ~/.pryrc
ln -vsf ~/.repos/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -vsf ~/.repos/dotfiles/jetbrains/ideavimrc ~/.ideavimrc
ln -vsf ~/.repos/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -vsf ~/.repos/dotfiles/kitty/macos-launch-serviecs-cmdline ~/.config/kitty/macos-launch-serviecs-cmdline

ln -vsf ~/.repos/dotfiles/asdf/default-npm-packages ~/.default-npm-packages
ln -vsf ~/.repos/dotfiles/asdf/default-gems ~/.default-gems
ln -vsf ~/.repos/dotfiles/asdfrc ~/.asdfrc

ln -vsf ~/.repos/dotfiles/tmux ~/.tmux
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
    ln -vsf ~/.repos/dotfiles/resources/osx/karabiner.json ~/.config/karabiner/karabiner.json
    ;;
  Linux)
    ln -vsf ~/.repos/dotfiles/resources/linux/tmux.conf ~/.tmux.conf
    ln -vsf ~/.repos/dotfiles/resources/linux/redshift.conf ~/.config/redshift.conf
    ;;
esac
