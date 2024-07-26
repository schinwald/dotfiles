OS=$(uname -s)

if [ $OS = "Linux" ]; then
	sudo apt install fzf
elif [ $OS = "Darwin" ]; then
	brew install fzf
fi
