zsh-defer eval "$(mise activate zsh)"

if [[ ! -f "$HOME/.zsh/completions/_mise" ]]; then
  mise completion zsh > ~/.zsh/completions_mise
fi

autoload -Uz compinit
compinit
