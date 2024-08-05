# Install lua
prompt "Would you like to install lua v5.4?"
sudo apt install lua5.4


# Install luarocks
prompt "Would you like to install luarocks v3.9.2?"
(
  VERSION=3.9.2
  cd ~/Downloads
  wget https://luarocks.org/releases/luarocks-$VERSION.tar.gz
  tar zxpf luarocks-$VERSION.tar.gz
  cd luarocks-$VERSION
  ./configure && make && sudo make install
  sudo luarocks install luasocket
  cd ~/Downloads
  rm -rf luarocks-$VERSION.tar.gz
)
