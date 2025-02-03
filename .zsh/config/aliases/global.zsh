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
alias ls='lsd'
alias la='ls -a'
alias lla='ls -la'
alias l='lla'
alias lt='ls --tree'
alias rm='rm -rfi'
alias cp='cp -ri'
alias v=nvim_open
alias pu=port_used
alias s='ssh $(cat ~/.ssh/config | grep ^Host | cut -d " " -f 2 | fzf)'

# +----------------+
# | DOCKER ALIASES |
# ==================
alias dcl='docker container list | fzf --multi --exact --header-lines=1'
alias dcr='dcl | tr -s "  " | cut -d " " -f 1 | xargs docker container restart'
alias dce='dcl | sed -e "s/ \{2,\}/@/g" | cut -d "@" -f 7 | xargs -I {} docker container exec -t {}'
alias dcs='dcl | tr -s "  " | cut -d " " -f 1 | xargs docker container stop'
alias dclg='dcl | sed "s/  /@/g" | tr -s "@" | cut -d "@" -f 7 | xargs docker logs --follow'
alias dnk='docker container list --quiet > /dev/null | xargs docker container stop; docker system prune --all --volumes --force && docker volume prune --all --force'
alias dcu='docker-compose up --build -d'
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
alias dfa='
  git --git-dir=$DOTFILES --work-tree=$HOME status --short |
  fzf --ansi --exact --header="Git add" --phony \
    --bind "right:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME add && git --git-dir=$DOTFILES --work-tree=$HOME status --short)" \
    --bind "shift-right:reload(git --git-dir=$DOTFILES --work-tree=$HOME add --all && git --git-dir=$DOTFILES --work-tree=$HOME status --short)" \
    --bind "left:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git --git-dir=$DOTFILES --work-tree=$HOME restore --staged && git --git-dir=$DOTFILES --work-tree=$HOME status --short)" \
    --bind "shift-left:reload(git --git-dir=$DOTFILES --work-tree=$HOME reset > /dev/null && git --git-dir=$DOTFILES --work-tree=$HOME status --short)" \
    --bind "enter:become(git --git-dir=$DOTFILES --work-tree=$HOME status)"
'
alias dfaa='df add --all'
alias dfapa='df add --patch'
alias dfc='df commit -v'
alias dfco='
  git-graph --color=always --path=$DOTFILES |
  fzf --ansi --exact --header="Git checkout" \
    --bind "enter:become(echo {} | grep -o \"\w\+[^[:space:]]\" | head -1 | xargs git --git-dir=$DOTFILES --work-tree=$HOME checkout)"
'
alias dfp='df push'
alias dfpsu='git push --set-upstream origin $(git branch --show-current)'
alias dfpl='df pull'
alias dfst='df status'
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
  git status --short |
  fzf --ansi --exact --header="Git add" --phony \
    --bind "right:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git add && git status --short)" \
    --bind "shift-right:reload(git add --all && git status --short)" \
    --bind "left:reload(echo {} | grep -o \"[^[:space:]]\+$\" | xargs git restore --staged && git status --short)" \
    --bind "shift-left:reload(git reset > /dev/null && git status --short)" \
    --bind "enter:become(git status)"
'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gc='git commit -v'
alias gco='
  git-graph --color=always |
  fzf --ansi --exact --header="Git checkout" \
    --bind "enter:become(echo {} | grep -o \"\w\+[^[:space:]]\" | head -1 | xargs git checkout)"
'
alias gp='git push'
alias gpsu='git push --set-upstream origin $(git branch --show-current)'
alias gpl='git pull'
alias gst='git status'
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
alias grs='git reset --soft'
alias grm='git reset --mixed'
alias grh='git reset --hard'
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

# +-------------------------------+ 
# | GOOGLE CLOUD PLATFORM ALIASES | 
# =================================
alias gcpl='gcloud container clusters list | fzf --exact --header="GCP cluser" --header-lines=1'
alias gcpsw=gcp_switch_cluster

# +--------------------+
# | KUBERNETES ALIASES |
# ======================
alias k='kubectl'
alias kpl='k get pods | fzf --exact --header="Kubernetes pods" --header-lines=1'
alias krl='k get replicasets | fzf --exact --header="Kubernetes replicasets" --header-lines=1'
alias kdl='k get deployments | fzf --exact --header="Kubernetes deployments" --header-lines=1'
alias knl='k get namespaces | fzf --exact --header="Kubernetes namespaces" --header-lines=1'

# +------------------------+
# | KITTY TERMINAL ALIASES |
# ==========================
alias ssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'

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
	config_list[ssh]="$HOME/.ssh/config"
	config_list[zshrc]="$HOME/.zshrc"
	config_list[zsh]="$HOME/.zsh/"
	config_list[aliases]="$HOME/.zsh/config/aliases/global.zsh"
	config_list[xprofile]="$HOME/.xprofile"
	config_list[setup]="$HOME/.setup"
	config_list[daemons]="$HOME/.daemons"

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

  if [[ -z $1 ]]; then
    DIRECTORY=`pwd`
  else
    DIRECTORY=`dirname $@[$#]`
  fi

  nvim -c "cd $DIRECTORY" $@
}

port_used () {
  sudo netstat -anpe | grep -P "[[:space:]]$1[[:space:]]" | grep "LISTEN"
  # sudo lsof -i :$1
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

