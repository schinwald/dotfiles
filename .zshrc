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

wrap_with_zsh_defer() {
  for cmd in "$@"; do
    eval "${cmd}() { zsh-defer command ${cmd} \"\$@\"; }"
  done
}

# Overrides all completion functions so that they are deferred
wrap_with_zsh_defer compinit compdef compaudit

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
