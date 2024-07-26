OS=$(uname -s)

if [ $OS = "Linux" ]; then
	sudo apt install lsd
elif [ $OS = "Darwin" ]; then
	brew install lsd
fi
