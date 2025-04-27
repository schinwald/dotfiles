# Set this to 1 to profile
ZSH_PROFILE=0

# Start profiler
if [[ ZSH_PROFILE -eq 1 ]]; then
  zmodload zsh/zprof
fi

# Add all configuration files
for FILE in ~/.zsh/config/**/*.zsh; do
	source $FILE
done
unset FILE

# Allows queued (deferred) commands to not block startup
[ -f ~/.zsh/defer.zsh ] && source ~/.zsh/defer.zsh

# Overrides all completion functions so that they are deferred
autoload -U compinit
zsh-defer compinit
zsh-defer compdef
zsh-defer compaudit
zsh-defer compdump

# Add all plugin files using a deferred strategy
for FILE in ~/.zsh/plugins/**/*.zsh; do
	source $FILE
done
unset FILE

# End profiler
if [[ ZSH_PROFILE -eq 1 ]]; then
  zprof
fi

# Stops C-d from exiting
setopt IGNORE_EOF
