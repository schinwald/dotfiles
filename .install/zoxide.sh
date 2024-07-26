OS=$(uname -s)

if [ $OS = "linux" ]; then
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh	
elif [ $OS = "Darwin" ]; then
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh	
fi
