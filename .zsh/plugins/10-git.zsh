if [[ ! -f "$HOME/.zsh/completions/_git" ]]; then
  curl -o "$HOME/.zsh/completions/_git" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

if [[ ! -f "$HOME/.zsh/completions/git-completion.bash" ]]; then
  curl -o "$HOME/.zsh/completions/git-completion.bash" \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi


if [[ ! "$fpath" == *"$HOME/.zsh/completions"* ]]; then
  fpath=("$HOME/.zsh/completions" $fpath)
fi

autoload -Uz compinit
compinit
