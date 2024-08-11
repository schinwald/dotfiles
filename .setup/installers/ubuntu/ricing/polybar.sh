# Install polybar
prompt "Would you like to install polybar (status bar)?"
sudo apt install \
  build-essential \
  git \
  cmake \
  cmake-data \
  pkg-config \
  python3-sphinx \
  python3-packaging \
  libuv1-dev \
  libcairo2-dev \
  libxcb1-dev \
  libxcb-util0-dev \
  libxcb-randr0-dev \
  libxcb-composite0-dev \
  python3-xcbgen \
  xcb-proto \
  libxcb-image0-dev \
  libxcb-ewmh-dev \
  libxcb-icccm4-dev

(
  cd $INSTALLPATH
  git clone --recursive https://github.com/polybar/polybar
  cd polybarmkdir build
  cd build
  cmake ..
  make -j$(nproc)
  sudo make install
)
