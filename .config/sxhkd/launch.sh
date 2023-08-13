#!/bin/sh


# Logging locations
LOG_STATUS=/var/tmp/sxhkd_status.log
LOG_REDIRECT=/var/tmp/sxhkd_redirect.log

# SXHKD config locations
# SXHKD_CONFIG_RESET=~/.config/sxhkd/hotkeys/reset
SXHKD_CONFIG_GENERAL=~/.config/sxhkd/hotkeys/general
SXHKD_CONFIG_MODE=~/.config/sxhkd/hotkeys/window_managers/i3/mode
SXHKD_CONFIG_MODE_FOCUS=~/.config/sxhkd/hotkeys/window_managers/i3/modes/focus
SXHKD_CONFIG_MODE_MOVE=~/.config/sxhkd/hotkeys/window_managers/i3/modes/move
SXHKD_CONFIG_MODE_NAVIGATE=~/.config/sxhkd/hotkeys/window_managers/i3/modes/navigate
SXHKD_CONFIG_MODE_RESIZE=~/.config/sxhkd/hotkeys/window_managers/i3/modes/resize
SXHKD_CONFIG_MODE_TRADE=~/.config/sxhkd/hotkeys/window_managers/i3/modes/trade

# I3 config locations
I3_CONFIG_MODE_FOCUS=~/.config/i3/modes/focus
I3_CONFIG_MODE_MOVE=~/.config/i3/modes/move
I3_CONFIG_MODE_NAVIGATE=~/.config/i3/modes/navigate
I3_CONFIG_MODE_RESIZE=~/.config/i3/modes/resize
I3_CONFIG_MODE_TRADE=~/.config/i3/modes/trade

# Remove all previous instances of sxhkd
killall -9 sxhkd 2> /dev/null

log () {
	TIMESTAMP=$(date "+%T.%3N")
	echo "$TIMESTAMP - $1" >> /var/tmp/sxhkd_launch.logs
}

# Check for mode command
if [ "$1" = "mode" ]; then
	# Switch mode to focus
	if [ "$2" = "focus" ]; then
		# Start new instance of sxhkd focus
		log "Attempting to switch mode to $2."

		log "Setting up $2 keybindings."
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_FOCUS &

		log "Updating polybar to switch to $2 appearance."
		polybar-msg hook mode 1

		log "Changing i3 configuration to switch to $2 appearance."
		cat $I3_CONFIG_MODE_FOCUS > ~/.config/i3/mode

		log "Reloading i3 to commit $2 appearance changes."
		i3 reload

		log "Successfully switched mode to $2."
	# Switch mode to move
	elif [ "$2" = "move" ]; then
		# Start new instance of sxhkd move
		log "Attempting to switch mode to $2."

		log "Setting up $2 keybindings."
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_MOVE $SXHKD_CONFIG_RESET &

		log "Updating polybar to switch to $2 appearance."
		polybar-msg hook mode 2

		log "Changing i3 configuration to switch to $2 appearance."
		cat $I3_CONFIG_MODE_MOVE > ~/.config/i3/mode

		log "Reloading i3 to commit $2 appearance changes."
		i3 reload

		log "Successfully switched mode to $2."
	# Switch mode to navigate
	elif [ "$2" = "navigate" ]; then
		# Start new instance of sxhkd navigate
		log "Attempting to switch mode to $2."

		log "Setting up $2 keybindings."
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_NAVIGATE $SXHKD_CONFIG_RESET &

		log "Updating polybar to switch to $2 appearance."
		polybar-msg hook mode 3

		log "Changing i3 configuration to switch to $2 appearance."
		cat $I3_CONFIG_MODE_NAVIGATE > ~/.config/i3/mode

		log "Reloading i3 to commit $2 appearance changes."
		i3 reload

		log "Successfully switched mode to $2."
	# Switch mode to resize
	elif [ "$2" = "resize" ]; then
		# Start new instance of sxhkd resize
		log "Attempting to switch mode to $2."

		log "Setting up $2 keybindings."
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_RESIZE $SXHKD_CONFIG_RESET &

		log "Updating polybar to switch to $2 appearance."
		polybar-msg hook mode 4

		log "Changing i3 configuration to switch to $2 appearance."
		cat $I3_CONFIG_MODE_RESIZE > ~/.config/i3/mode

		log "Reloading i3 to commit $2 appearance changes."
		i3 reload

		log "Successfully switched mode to $2."
	# Switch mode to trade
	elif [ "$2" = "trade" ]; then
		# Start new instance of sxhkd trade	
		log "Attempting to switch mode to $2."

		log "Setting up $2 keybindings."
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_TRADE $SXHKD_CONFIG_RESET &

		log "Updating polybar to switch to $2 appearance."
		polybar-msg hook mode 5

		log "Changing i3 configuration to switch to $2 appearance."
		cat $I3_CONFIG_MODE_TRADE > ~/.config/i3/mode

		log "Reloading i3 to commit $2 appearance changes."
		i3 reload

		log "Successfully switched mode to $2."
	fi
fi
