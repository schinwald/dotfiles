OS=$(uname -s)

if [ $OS = "Linux" ]; then
	curl -sS https://starship.rs/install.sh | sh
elif [ $OS = "Darwin" ]; then
	curl -sS https://starship.rs/install.sh | sh
fi
