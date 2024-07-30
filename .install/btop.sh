OS=$(uname -s)

if [ $OS = "Linux" ]; then
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
elif [ $OS = "Darwin" ]; then
	brew install btop
fi
