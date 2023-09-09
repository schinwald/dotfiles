#! /bin/zsh

# +-----------------------+
# | MISCELLANEOUS ALIASES |
# =========================
alias matrix='cmatrix'
alias star_wars='nc towel.blinkenlights.nl 23'

# +-----------------+
# | GENERAL ALIASES |
# ===================
edit_config () {
	declare -A config_list

	config_list[aliases]="$HOME/.zsh/aliases.zsh"
	config_list[i3]="$HOME/.config/i3/config"
	config_list[picom]="$HOME/.config/picom/picom.conf"
	config_list[polybar]="$HOME/.config/polybar/config.ini"
	config_list[sxhkd]="$HOME/.config/sxhkd/launch.sh"
	config_list[rofi]="$HOME/.config/rofi/config.rasi"
	config_list[redshift]="$HOME/.config/redshift/redshift.conf"
	config_list[kitty]="$HOME/.config/kitty/kitty.conf"
	config_list[nvim]="$HOME/.config/nvim/init.lua"
	config_list[starship]="$HOME/.config/starship.toml"
	config_list[flameshot]="$HOME/.config/flameshot/flameshot.ini"
	config_list[ssh]="$HOME/.ssh/config"

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
	
	v ${config_list[$config_chosen]}
}

port_used () {
  sudo netstat -anpe | grep -P "[[:space:]]$1[[:space:]]" | grep "LISTEN"
  # sudo lsof -i :$1
}

alias cfgs=edit_config
alias src='source ~/.zshrc'
alias c='clear'
alias l='ll'
alias ls='exa --header --group-directories-first -t=mod --time-style=long-iso'
alias la='exa --all --header --group-directories-first -t=mod --time-style=long-iso'
alias ll='exa --all --header --long --group-directories-first -t=mod --time-style=long-iso'
alias rm='rm -rf'
alias cp='cp -r'
alias v='nvim'
alias pu=port_used
alias ssh-config='cat ~/.ssh/config'

# +----------------+
# | DOCKER ALIASES |
# ==================
docker_container_stop_all () {
	containers=`docker container list --quiet`
	if [[ -n "$containers" ]]; then
		echo "$containers" | xargs docker container stop
		echo 'docker containers: stopped all'
	else
		echo 'no docker containers'
	fi
}

alias dcl='docker container list'
alias dcs='docker container stop'
alias dcsa=docker_container_stop_all
alias dsp='echo "y" | docker system prune --volumes'

# +-------------+
# | GIT ALIASES |
# ===============
git_branch_prune_all () {
	git switch development &> /dev/null
	git pull &> /dev/null
	git fetch --prune &> /dev/null
	git branch -vv | grep gone | sed -e s/\*//g | awk "{ print \$1 }" | xargs git branch -d 2> /dev/null
}

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gbpa=git_branch_prune_all

# +------------------------+
# | KITTY TERMINAL ALIASES |
# ==========================
alias ssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'

