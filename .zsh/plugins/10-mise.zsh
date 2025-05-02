zsh-defer eval "$(mise activate zsh)"

mkdir -p /usr/local/share/zsh/site-functions
mise completion zsh  > /usr/local/share/zsh/site-functions/_mise

