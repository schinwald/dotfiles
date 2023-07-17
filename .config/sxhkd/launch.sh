#!/bin/sh


# Logging locations
LOG_STATUS=/var/tmp/sxhkd_status.log
LOG_REDIRECT=/var/tmp/sxhkd_redirect.log

# SXHKD config locations
SXHKD_CONFIG_RESET=~/.config/sxhkd/hotkeys/reset
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

# Check for mode command
if [ "$1" = "mode" ]; then
	# Switch mode to focus
	if [ "$2" = "focus" ]; then
		# Start new instance of sxhkd focus
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_FOCUS &
		polybar-msg hook mode 1
		cat $I3_CONFIG_MODE_FOCUS > ~/.config/i3/mode
		i3 reload
	# Switch mode to move
	elif [ "$2" = "move" ]; then
		# Start new instance of sxhkd move
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_MOVE $SXHKD_CONFIG_RESET &
		polybar-msg hook mode 2
		cat $I3_CONFIG_MODE_MOVE > ~/.config/i3/mode
		i3 reload
	# Switch mode to navigate
	elif [ "$2" = "navigate" ]; then
		# Start new instance of sxhkd navigate
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_NAVIGATE $SXHKD_CONFIG_RESET &
		polybar-msg hook mode 3
		cat $I3_CONFIG_MODE_NAVIGATE > ~/.config/i3/mode
		i3 reload
	# Switch mode to resize
	elif [ "$2" = "resize" ]; then
		# Start new instance of sxhkd resize
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_RESIZE $SXHKD_CONFIG_RESET &
		polybar-msg hook mode 4
		cat $I3_CONFIG_MODE_RESIZE > ~/.config/i3/mode
		i3 reload
	# SWitch mode to trade
	elif [ "$2" = "trade" ]; then
		# Start new instance of sxhkd trade	
		sxhkd -s $LOG_STATUS -r $LOG_REDIRECT -c $SXHKD_CONFIG_GENERAL $SXHKD_CONFIG_MODE $SXHKD_CONFIG_MODE_TRADE $SXHKD_CONFIG_RESET &
		polybar-msg hook mode 5
		cat $I3_CONFIG_MODE_TRADE > ~/.config/i3/mode
		i3 reload
	fi
fi
