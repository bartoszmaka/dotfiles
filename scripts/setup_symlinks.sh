ln -vsf ~/.repos/dotfiles/noplugin_vimrc ~/.noplugin_vimrc
ln -vsf ~/.repos/dotfiles/vimrc ~/.vimrc
ln -vsf ~/.repos/dotfiles/vimrc ~/.config/nvim/init.vim
ln -vsf ~/.repos/dotfiles/global_gitignore ~/.gitignore
ln -vsf ~/.repos/dotfiles/zshrc ~/.zshrc
ln -vsf ~/.repos/dotfiles/rubocop.yml ~/.rubocop.yml
ln -vsf ~/.repos/dotfiles/pryrc ~/.pryrc
case "$(uname -s)" in
  Darwin)
    ln -vsf ~/osx/tmux.conf ~/.tmux.conf
    ln -vsf ~/.repos/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -vsf ~/.repos/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
    ln -vsf ~/.repos/dotfiles/vscode/snippets ~/Library/Application\ Support/Code/User/snippets
    ;;
  Linux)
    ln -vsf ~/linux/tmux.conf ~/.tmux.conf
    ;;
esac
