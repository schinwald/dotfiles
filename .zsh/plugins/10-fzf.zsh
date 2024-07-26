# Setup fzf
# ---------
if [[ ! "$PATH" == */home/james/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Settings
# --------
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Auto-completion
# ---------------
[[ $- == *i* ]] && zsh-defer source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/home/james/.fzf/shell/key-bindings.zsh"
