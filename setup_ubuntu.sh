echo 'Running setup for ubuntu'
echo 'copying config files'
cp -v ~/repos/dotfiles/linux/.tmux.conf ~/
cp -v ~/repos/dotfiles/.vimrc ~/
cp -v ~/repos/dotfiles/.rubocop.yml ~/
cp -v ~/repos/dotfiles/redshift.conf ~/.config/
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y zsh silversearcher-ag python-dev python3-dev python-pip python3-pip libncurses5 libncurses5-dev
