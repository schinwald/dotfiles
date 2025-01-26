# zstyle: Instructs the shell on how to provide inline, contextual hints
# fpath: The git-completion.zsh is a function file, not designed to be sourced like the bash script. This command appends the ~/.zsh directory onto the shell’s function lookup list.
# autoload: Scan each path within the fpath variable for files starting with an underscore (_git, in our case) and loads the corresponding script as a function file
# compinit: Initializes the shell’s auto-completion functionality

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit
