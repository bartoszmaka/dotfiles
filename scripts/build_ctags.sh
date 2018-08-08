git clone https://github.com/universal-ctags/ctags ~/.repos/ctags
cd ~/.repos/ctags
./autogen.sh
./configure
make
sudo make install
cd -
