export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH="/usr/local/man:$MANPATH"
export LANG="en_US.UTF-8"
export DOTFILES="$HOME/.dotfiles"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  # Alias for nvim
  export EDITOR='nvim'
fi

export VISUAL="$EDITOR"
