OS=$(uname -s)

if [ $OS = "Linux" ]; then
	sudo apt install fd-find
elif [ $OS = "Darwin" ]; then
	brew install fd
fi
