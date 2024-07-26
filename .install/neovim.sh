OS=$(uname -s)

if [ $OS = "Linux" ]; then
	sudo apt install neovim
elif [ $OS = "Darwin" ]; then
	brew install neovim
fi
