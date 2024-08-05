# Install bat (https://github.com/sharkdp/bat)
prompt "Would you like to install bat?"
sudo apt install bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
