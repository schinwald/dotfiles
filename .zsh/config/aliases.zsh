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
alias ghl='gh repo list | cut -f1 | fzf'
alias ghb='ghl | xargs gh browse --repo'
alias ghc='ghl | xargs gh repo clone'
alias gha='gh repo create'

# dotfiles
alias df='/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME'
alias dfa='df add'
alias dfaa='df add --all'
alias dfapa='df add --patch'
alias dfc='df commit -v'
alias dfp='df push'
alias dfl='df pull'
alias dfst='df status'

# git
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gc='git commit -v'
alias gp='git push'
alias gl='git pull'
alias gst='git status'
alias gsta='git stash push'
alias gg='git-graph --color=always | bat'
alias gbpa=git_branch_prune_all

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
	config_list[aliases]="$HOME/.zsh/config/aliases.zsh"
	config_list[xprofile]="$HOME/.xprofile"
	config_list[setup]="$HOME/.setup"

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

