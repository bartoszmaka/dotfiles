git clone https://github.com/tmux/tmux ~/.repos/tmux
cd ~/.repos/tmux
sh autogen.sh
./configure
make
sudo make install
cd -
