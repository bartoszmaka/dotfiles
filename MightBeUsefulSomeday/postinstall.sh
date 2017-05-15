# git repos
cd ~/.config
mkdir -p Repos

git clone https://github.com/universal-ctags/ctags
git clone https://github.com/jwilm/alacritty
git clone https://github.com/junegunn/fzf
git clone https://github.com/tmux/tmux

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


