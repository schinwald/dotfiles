session=$(\
  tmux ls |
  fzf --exact --header="Choose a tmux session" --border none --height 100% \
    --bind "enter:become(echo {} | cut -d \" \" -f 1)"
)
if [[ -z "$TMUX" ]]; then
  tmux attach -t $session
else
  tmux switch -t $session
fi
