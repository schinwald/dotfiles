# Setup fzf
# ---------
if [[ ! "$PATH" == */home/james/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/james/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/james/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/james/.fzf/shell/key-bindings.zsh"
