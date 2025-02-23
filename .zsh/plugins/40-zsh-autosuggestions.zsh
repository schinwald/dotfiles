source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Accepts the auto suggestion inside of ghostty
bindkey '^[[121;6u' end-of-line

# Accepts the auto suggestion inside of tmux
# I have to do this because tmux extended-keys only affect applications inside
# of tmux, not the terminal itself, so this is C-S-y in tmux
bindkey '^Y' end-of-line
