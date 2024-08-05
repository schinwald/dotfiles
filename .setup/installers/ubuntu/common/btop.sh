# Install btop (https://github.com/aristocratos/btop)
prompt "Would you like to install btop?"
sudo apt install \
  coreutils \
  sed \
  git \
  build-essential \
  gcc-11 \
  g++-11

(
  cd $INSTALLPATH
  git clone --recursive https://github.com/aristocratos/btop.git
  cd btop
  make
  sudo make install
)
