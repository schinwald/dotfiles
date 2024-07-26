# Uncomment this line and the line at the bottom of the file to profile
# zmodload zsh/zprof

# export ZSH_PROFILE=1
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Add all configuration files
for FILE in ~/.zsh/config/*.zsh; do
	source $FILE
done
unset FILE

# Allows queued (deferred) commands to not block startup
[ -f ~/.zsh/defer.zsh ] && source ~/.zsh/defer.zsh

# Add all plugin files using a deferred strategy
for FILE in ~/.zsh/plugins/*.zsh; do
	echo $FILE
	zsh-defer source $FILE
done
unset FILE

# zprof
