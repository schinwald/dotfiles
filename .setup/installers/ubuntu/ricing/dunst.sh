# Install dunst
prompt "Would you like to install dunst (notifications)?"
sudo apt install \
  libdbus-1-dev \
  libx11-dev \
  libxinerama-dev \
  libxrandr-dev \
  libxss-dev \
  libglib2.0-dev \
  libpango1.0-dev \
  libgtk-3-dev \
  libxdg-basedir-dev \
  libnotify-dev

(
  cd $INSTALLPATH
  git clone https://github.com/dunst-project/dunst.git
  cd dunst
  make
  sudo make install
)
