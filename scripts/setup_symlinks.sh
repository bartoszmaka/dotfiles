mkdir -p ~/.config/ranger
mkdir -p ~/.config/nvim
mkdir -p ~/.config/coc

ln -vsf ~/.repos/dotfiles/vim/vimrc ~/.config/nvim/init.vim
ln -vsf ~/.repos/dotfiles/global_gitignore ~/.gitignore
ln -vsf ~/.repos/dotfiles/gitconfig ~/.gitconfig
ln -vsf ~/.repos/dotfiles/zshrc ~/.zshrc
ln -vsf ~/.repos/dotfiles/rubocop.yml ~/.rubocop.yml
ln -vsf ~/.repos/dotfiles/pryrc ~/.pryrc
ln -vsf ~/.repos/dotfiles/tmux ~/.tmux
ln -vsf ~/.repos/dotfiles/vim/cocSnippets ~/.config/coc/ultisnips
ln -vsf ~/.repos/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -vsf ~/.repos/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

case "$(uname -s)" in
  Darwin)
    mkdir -p ~/Library/Application\ Support/Code/User
    mkdir -p ~/.config/karabiner

    ln -vsf ~/.repos/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -vsf ~/.repos/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
    ln -vsf ~/.repos/dotfiles/vscode/snippets ~/Library/Application\ Support/Code/User/snippets
    ln -vsf ~/.repos/dotfiles/osx/tmux.conf ~/.tmux.conf
    ln -vsf ~/.repos/dotfiles/osx/rc.conf ~/.config/ranger/rc.conf
    ln -vsf ~/.repos/dotfiles/osx/karabiner.json ~/.config/karabiner/karabiner.json
    ;;
  Linux)
    ln -vsf ~/.repos/dotfiles/linux/tmux.conf ~/.tmux.conf
    ln -vsf ~/.repos/dotfiles/linux/rc.conf ~/.config/ranger/rc.conf
    ln -vsf ~/.repos/dotfiles/linux/redshift.conf ~/.config/redshift.conf
    ;;
esac
