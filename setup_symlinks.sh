function download_repos {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  git clone https://github.com/universal-ctags/ctags ~/.repos
  git clone https://github.com/uptech/alt ~/.repos
  git clone https://github.com/tmux/tmux ~/.repos

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

case "$(uname -s)" in

   Darwin)
     md -p ~/.config/nvim
     md -p ~/.vim

     ln -s noplugin_vimrc ~/.noplugin_vimrc
     ln -s vimrc ~/.vimrc
     ln -s vimrc ~/.config/nvim/init.vim
     ln -s ~/.vim ~/.config/nvim/.vim
     ln -s global_gitignore ~/.gitignore
     download_repos
     ;;

   Linux)
     md -p ~/.config/nvim
     md -p ~/.vim
     md -p ~/.fonts

     ln -s ~/.config/nvim/init.vim vimrc
     ln -s ~/.config/nvim/.vim ~/.vim
     ln -s ~/.gitignore global_gitignore
     ln -s ~/.rubocop.yml rubocop.yml
     ln -s ~/.config/redshift.conf linux/redshift.conf
     download_repos
     ;;
esac
