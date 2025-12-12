#! /bin/zsh

# +-----------------------+
# | MISCELLANEOUS ALIASES |
# =========================
alias matrix='cmatrix'
alias star_wars='nc towel.blinkenlights.nl 23'

# +-----------------+
# | GENERAL ALIASES |
# ===================
alias cf=edit_config
alias src='source ~/.zshrc'
alias c='clear'
alias ls='lsd'
alias la='ls -a'
alias lla='ls -la'
alias l='lla'
alias lt='ls --tree'
alias rm='rm -rfi'
alias cp='cp -ri'
alias v=nvim_open
alias vt=nvim_open_neotest
alias pu=port_used
alias envs=source_environment_file
alias s='ssh $(cat ~/.ssh/config | grep ^Host | cut -d " " -f 2 | fzf)'
alias colors='
  cat $HOME/.config/constants/colors/main |
  fzf --ansi --exact --header-lines=1 \
  --bind "enter:become(echo {} | sed \"s/ \{1,\}/@/g\" | cut -d \"@\" -f 3 | sed \"s/\x1b/\\\\\\\\u001b/g\" | tr -d \"\n\" | pbcopy)"
'
alias ips='echo "Public: $(curl -s ifconfig.me)"; echo "Local: $(ipconfsg getifaddr en0 2>/dev/null || hostname -I | awk "{print \$1}")"'

copy () {
  pbcopy "$@"
}

double_quote () {
  if [ "$#" -gt 0 ]; then
    for arg in "$@"; do
      echo "\"$arg\""
    done
  else
    while IFS= read -r line; do
      echo "\"$line\""
    done
  fi
}

# +----------------+
# | DOCKER ALIASES |
# ==================
alias dcl=docker_container_list
alias dcr='dcl | tr -s "  " | cut -d " " -f 1 | xargs docker container restart'
alias dce='dcl | sed -e "s/ \{2,\}/@/g" | cut -d "@" -f 7 | xargs -I {} docker container exec -t {}'
alias dcs='dcl | tr -s "  " | cut -d " " -f 1 | xargs docker container stop'
alias dclg=docker_container_log
alias dnk='docker container list --quiet > /dev/null | xargs docker container stop; docker system prune --all --volumes --force && docker volume prune --all --force'
alias dcu='docker-compose up --build --detach'
alias dcd='docker-compose down'

# +-------------+
# | GIT ALIASES |
# ===============
# gh cli
alias ghp='open https://github.com/schinwald'
alias ghl='gh repo list | cut -f1 | fzf'
alias ghb='ghl | xargs gh browse --repo'
alias ghc='ghl | xargs gh repo clone'
alias gha='gh repo create'

# dotfiles
alias df='git --git-dir=$DOTFILES --work-tree=$HOME'
alias dfd=dotfiles_diff
alias dfa='
  git --git-dir=$DOTFILES --work-tree=$HOME status --short --untracked-files=all |
  fzf --ansi --exact --header="Git add" \
    --bind "right:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME add && git --git-dir=$DOTFILES --work-tree=$HOME status --short --untracked-files=all)" \
    --bind "shift-right:reload(git --git-dir=$DOTFILES --work-tree=$HOME add --all && git --git-dir=$DOTFILES --work-tree=$HOME status --short --untracked-files=all)" \
    --bind "left:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME restore --staged && git --git-dir=$DOTFILES --work-tree=$HOME status --short --untracked-files=all)" \
    --bind "shift-left:reload(git --git-dir=$DOTFILES --work-tree=$HOME reset > /dev/null && git --git-dir=$DOTFILES --work-tree=$HOME status --short --untracked-files=all)" \
    --bind "enter:become(git --git-dir=$DOTFILES --work-tree=$HOME status --short --untracked-files=all)"
'
alias dfaa='df add --all'
alias dfapa='df add --patch'
alias dfc='df commit -v'
alias dfca='df commit --amend'
alias dfco='
  git-graph --color=always --path=$DOTFILES |
  fzf --ansi --exact --header="Git checkout" \
    --bind "enter:become(echo {} | grep -o \"\w\+[^[:space:]]\" | head -1 | xargs git --git-dir=$DOTFILES --work-tree=$HOME checkout)"
'
alias dfp='df push'
alias dfpsu='git push --set-upstream origin $(git branch --show-current)'
alias dfpl='df pull'
alias dfst='df status --untracked-files=all'
alias dfstl='
  df stash list |
  fzf --ansi --exact --header="Git stash list" \
'
alias dfstp='df stash push --staged'
alias dfstpa='dfaa && df stash push --staged'
alias dfstpp='
  df stash list |
  fzf --ansi --exact --header="Git stash pop" \
    --bind "enter:become(echo {} | grep -o \"stash@{\d\+}\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME stash pop)"
'
alias dfsta='
  df stash list |
  fzf --ansi --exact --header="Git stash apply" \
    --bind "enter:become(echo {} | grep -o \"stash@{\d\+}\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME stash apply)"
'
alias dfsw='
  df branch --color |
  fzf --ansi --exact --header="Git branches" --query="$1" \
    --bind "enter:become(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME switch)"
'
alias dfr='df reset'
alias dfrs='df reset --soft'
alias dfrm='df reset --mixed'
alias dfrh='df reset --hard'
alias dfrst='df restore'
alias dfrev='df revert'
alias dfb='
  df branch --color |
  fzf --ansi --exact --header="Git branches"
'
alias dfds='df diff --cached'
alias dfl='
  git-graph --color=always --path=$DOTFILES |
  fzf --ansi --exact --header="Git commits"
'

# git
alias ga='
  git status --short --untracked-files=all |
  fzf --ansi --exact --header="Git add" --phony \
    --bind "right:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git add && git status --short --untracked-files=all)" \
    --bind "shift-right:reload(git add --all && git status --short --untracked-files=all)" \
    --bind "left:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git restore --staged && git status --short --untracked-files=all)" \
    --bind "shift-left:reload(git reset > /dev/null && git status --short --untracked-files=all)" \
    --bind "enter:become(git status --short --untracked-files=all)"
'
alias gd=diff
alias gaa='git add --all'
alias gapa='git add --patch'
alias gc='git commit -v'
alias gca='git commit --amend'
alias gco='
  git-graph --color=always |
  fzf --ansi --exact --header="Git checkout" \
    --bind "enter:become(echo {} | grep -o \"\w\+[^[:space:]]\" | head -1 | xargs git checkout)"
'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsu='git push --set-upstream origin $(git branch --show-current)'
alias gpl='git pull'
alias gst='git status --untracked-files=all'
alias gstl='
  git stash list |
  fzf --ansi --exact --header="Git stash list" \
'
alias gstp='git stash push --staged'
alias gstpa='gaa && git stash push --staged'
alias gstpp='
  git stash list |
  fzf --ansi --exact --header="Git stash pop" \
    --bind "enter:become(echo {} | grep -o \"stash@{\d\+}\" | xargs git stash pop)"
'
alias gsta='
  git stash list |
  fzf --ansi --exact --header="Git stash apply" \
    --bind "enter:become(echo {} | grep -o \"stash@{\d\+}\" | xargs git stash apply)"
'
alias gsw='
  git branch --color |
  fzf --ansi --exact --header="Git branches" \
    --bind "enter:become(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git switch)"
'
alias gr='git reset'
alias grs='git reset --soft' # Move head, but current keep changes staged
alias grm='git reset --mixed' # Move head, unstage current changes, but keep changes in working tree
alias grh='git reset --hard' # Move head, unstage current chaanges, and discard all changes from working tree (fresh start)
alias grst='git restore'
alias grev='git revert'
alias gb='
  git branch --color |
  fzf --ansi --exact --header="Git branches"
'
alias gds='git diff --cached'
alias gbpa=git_branch_prune_all
alias gl='
  git-graph --color=always |
  fzf --ansi --exact --header="Git commits"
'
alias grrm='git rm --cached' # Remove remote files from history
alias gurm='git clean -f' # Remove file from working tree
alias grb='git rebase -i'
alias gcb='git checkout -b'

# +--------------+ 
# | TMUX ALIASES | 
# ================
alias tl='tmux ls | fzf --ansi --exact --header="TMUX sessions"'
alias ta='~/.config/tmux/utils/switch_session.sh'
alias td='tmux detach'
alias tc='tmux new-session -s'
alias tk='tmux kill-server'
alias tps='
  tmuxinator list | tail -n +2 | tr -s " " | tr " " "\n" | xargs -n 1 tmuxinator start
'

# +-------------------------------+ 
# | GOOGLE CLOUD PLATFORM ALIASES | 
# =================================
alias gcpl='gcloud container clusters list | fzf --exact --header="GCP cluser" --header-lines=1'
alias gcpsw=gcp_switch_cluster

# +--------------------+
# | KUBERNETES ALIASES |
# ======================
alias k='kubectl'
alias kgp='k get pods | fzf --exact --header="Kubernetes pods" --header-lines=1'
alias kgr='k get replicasets | fzf --exact --header="Kubernetes replicasets" --header-lines=1'
alias kgd='k get deployments | fzf --exact --header="Kubernetes deployments" --header-lines=1'
alias kgn='k get namespaces | fzf --exact --header="Kubernetes namespaces" --header-lines=1'
alias ksw='k config get-contexts | fzf --exact --header="Kubernetes contexts" --header-lines=1'

# +------------------+
# | HELPER FUNCTIONS |
# ====================
edit_config () {
	declare -A config_list

	config_list[home]="$HOME/"
	config_list[i3]="$HOME/.config/i3/config"
	config_list[picom]="$HOME/.config/picom/picom.conf"
	config_list[polybar]="$HOME/.config/polybar/config.ini"
	config_list[sxhkd]="$HOME/.config/sxhkd"
	config_list[rofi]="$HOME/.config/rofi/config.rasi"
	config_list[redshift]="$HOME/.config/redshift/redshift.conf"
	config_list[kitty]="$HOME/.config/kitty/kitty.conf"
	config_list[ghostty]="$HOME/.config/ghostty"
	config_list[nvim]="$HOME/.config/nvim/"
	config_list[starship]="$HOME/.config/starship/starship.toml"
	config_list[flameshot]="$HOME/.config/flameshot/flameshot.ini"
	config_list[aerospace]="$HOME/.config/aerospace/aerospace.toml"
	config_list[jankyborders]="$HOME/.config/borders/bordersrc"
	config_list[kanata]="$HOME/.config/kanata"
	config_list[kanata-tray]="$HOME/.config/kanata-tray"
	config_list[gitignore]="$HOME/.config/mise"
	config_list[ssh]="$HOME/.ssh/config"
	config_list[zshrc]="$HOME/.zshrc"
	config_list[zsh]="$HOME/.zsh/"
	config_list[aliases]="$HOME/.zsh/config/aliases/global.zsh"
	config_list[xprofile]="$HOME/.xprofile"
	config_list[setup]="$HOME/.setup"
	config_list[daemons]="$HOME/.daemons"
	config_list[btop]="$HOME/.config/btop/btop.conf"
	config_list[tmux]="$HOME/.config/tmux/tmux.conf"
	config_list[tmuxinator]="$HOME/.config/tmuxinator"
	config_list[gitignore]="$HOME/.gitignore"

	config_keys=`for key in "${(@k)config_list}"; do; echo $key; done`

	if [[ -z "$1" ]]; then
		config_chosen=`echo $config_keys | fzf`
	elif [[ -z "${config_list[$1]}" ]]; then
		config_chosen=`echo $config_keys | fzf -q $1 -1`
	else
		config_chosen="$1"
	fi

	if [[ -z "${config_list[$config_chosen]}" ]]; then
		return 0
	fi
	
	nvim_open ${config_list[$config_chosen]}
}

nvim_open () {
  DIRECTORY=""

  # Check if argument exists
  if [[ -z $1 ]]; then
    DIRECTORY=`pwd`
  # Check if argument is a directory
  elif [[ -d $1 ]]; then
    DIRECTORY=$1
  # Otherwise extract directory from path
  else
    DIRECTORY=`dirname $@[$#]`
  fi

  nvim -c "cd $DIRECTORY" $@
}

nvim_open_neotest () {
  nvim -c "NeotestOpen" $@
}

diff () {
  nvim -c "DiffviewOpen" $@
}

dotfiles_diff () {
  nvim --cmd "cd ~" -c "DiffviewOpen" $@
}

port_used () {
  PORT=$(lsof -i :$1)

  if [[ -z $PORT ]]; then
    echo "Port $1 not used"
    return 0
  fi

  echo "$PORT" |
    fzf --ansi --exact --header="Port used" --header-lines=1
}

git_branch_prune_all () {
	git switch development &> /dev/null
	git pull &> /dev/null
	git fetch --prune &> /dev/null
	git branch -vv | grep gone | sed -e s/\*//g | awk "{ print \$1 }" | xargs git branch -d 2> /dev/null
}

gcp_switch_cluster () {
  clusters=$(gcloud container clusters list)
  echo "$clusters" |
    fzf --ansi --exact --header="GCP switch cluser" --header-lines=1 \
      --bind "enter:become(echo {} | cut -d \" \" -f 1 | xargs gcloud container clusters get-credentials)"
}

source_environment_file () {
  set -a
  source "$1"
  set +a
}

docker_container_list () {
  containers=$(docker container list)
  echo "$containers" |
    fzf --ansi --exact --header="Docker containers" --header-lines=1 --query="$1"
}

docker_container_log () {
  containers=$(docker container list)
  selected=$(echo "$containers" | fzf --ansi --exact --header="Docker containers" --header-lines=1 --query="$1" --select-1)
  if [[ -z $selected ]]; then
    return 0
  fi
  echo "$selected" | sed "s/  /@/g" | tr -s "@" | cut -d "@" -f 7 | xargs docker logs --follow
}

# Run tmuxinator scripts (must be at the end)
if [[ ! -v "$TMUX" ]]; then
  TMUX_SESSION=$(tmux display-message -p '#S')
  TMUX_WINDOW=$(tmux display-message -p '#W')
  TMUX_PANE=$(tmux display-message -p '#P')
  FILE=~/.config/tmuxinator/$TMUX_SESSION.zsh
  if [[ -f $FILE ]]; then
    source $FILE
  fi
  unset FILE
fi
