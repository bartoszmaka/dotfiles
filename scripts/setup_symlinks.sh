ln -vsf ~/.repos/dotfiles/noplugin_vimrc ~/.noplugin_vimrc
ln -vsf ~/.repos/dotfiles/vimrc ~/.vimrc
ln -vsf ~/.repos/dotfiles/vimrc ~/.config/nvim/init.vim
ln -vsf ~/.repos/dotfiles/global_gitignore ~/.gitignore
ln -vsf ~/.repos/dotfiles/zshrc ~/.zshrc
ln -vsf ~/.repos/dotfiles/rubocop.yml ~/.rubocop.yml
case "$(uname -s)" in
  Darwin)
    ln -vsf ~/osx/tmux.conf ~/.tmux.conf
    ;;
  Linux)
    ln -vsf ~/linux/tmux.conf ~/.tmux.conf
    ;;
esac
