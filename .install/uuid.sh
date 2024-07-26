OS=$(uname -s)

if [ $OS = "Linux" ]; then
	sudo apt install uuid
elif [ $OS = "Darwin" ]; then
	brew install ossp-uuid
fi
