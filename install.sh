BINPATH='/usr/local/bin'
MANPATH='/usr/local/man/man1'
INSTALLPATH='/var/tmp/dotfiles'

rm -rf $INSTALLPATH 
mkdir $INSTALLPATH

# +--------------------+
# | COMMAND-LINE TOOLS |
# ======================

# Update system
sudo apt update

# Install moreutils (https://joeyh.name/code/moreutils)
sudo apt install moreutils

# Install github & extensions
sudo apt install gh
gh extension install https://github.com/nektos/gh-act

# Install git
sudo apt install git

# Install zsh
sudo apt install zsh

# Install starship
sudo snap install starship

# Install ripgrep (https://github.com/BurntSushi/ripgrep)
sudo apt install ripgrep

# Install fd (https://github.com/sharkdp/fd)
sudo apt install fd-find

# Install fzf (https://github.com/junegunn/fzf)
sudo apt install fzf

# Install exa (https://github.com/ogham/exa)
sudo apt install exa

# Install z (https://github.com/rupa/z) 
(
	cd $INSTALLPATH 
	git clone git@github.com:rupa/z.git
	cd z
	sudo mv ./z.sh $BINPATH/z.sh
	sudo mv ./z.1 $MANPATH/z.1 
)

# Install pomo
(
	cd $INSTALLPATH
	git clone git@github.com:kevinschoon/pomo.git
	cd pomo
	make
	sudo mv ./bin/pomo $BINPATH/pomo 	
)

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install neovim
sudo apt install neovim

# Install imagemagick
sudo apt install imagemagick

# Install autorandr
sudo apt install autorandr

# Install sxhkd
sudo apt install sxhkd

# Install btop
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

# +-------------+
# | PROGRAMMING |
# ===============

# Install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install bun
npm install -g bun

# Install commit citizen
npm install -g commitizen

# Install zx
npm install -g zx

# Install ntl
npm install -g ntl

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# +----------------
# | RICING SYSTEM |
# =================

# Install rofi
sudo apt install rofi

# Install picom
sudo apt install \
  libxext-dev \
  libxcb1-dev \
  libxcb-damage0-dev \
  libxcb-dpms0-dev \
  libxcb-xfixes0-dev \
  libxcb-shape0-dev \
  libxcb-render-util0-dev \
  libxcb-render0-dev \
  libxcb-randr0-dev \
  libxcb-composite0-dev \
  libxcb-image0-dev \
  libxcb-present-dev \
  libxcb-glx0-dev \
  libpixman-1-dev \
  libdbus-1-dev \
  libconfig-dev \
  libgl-dev \
  libegl-dev \
  libpcre2-dev \
  libevdev-dev \
  uthash-dev \
  libev-dev \
  libx11-xcb-dev \
  meson

(
  cd $INSTALLPATH
  git clone https://github.com/yshui/picom.git
  cd picom
  git submodule update --init --recursive
  meson setup --buildtype=release . build
  ninja -C build
)

# Install polybar
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

# Install dunst
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

# +--------------+
# | MISCELLANOUS |
# ================

# Install cmatrix
sudo apt install cmatrix
