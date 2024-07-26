OS=$(uname -s)

if [ $OS = "Linux" ]; then
	sudo apt install ripgrep
elif [ $OS = "Darwin" ]; then
	brew install ripgrep
fi
