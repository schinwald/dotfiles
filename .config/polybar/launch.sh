#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
CONFIG=~/.config/polybar/config.ini
 
# Wait for polybar to start
while pgrep -x polybar >/dev/null; do sleep 1; done

# Grab screens
SCREENS=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)

# Handle one monitor layout
if [[ $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l) == 1 ]]; then
  SCREEN=$(polybar --list-monitors | cut -d":" -f1)
  
  MONITOR=$SCREEN polybar --config=$CONFIG primary 2>&1 | tee -a /var/tmp/polybar_$m.log & disown
# Handle multiple monitor layout
else
  PRIMARY=$(xrandr --query | grep primary | cut -d" " -f1)

  for SCREEN in $SCREENS; do
    # Handle primary monitor
    if [[ $SCREEN == $PRIMARY ]]; then
      MONITOR=$SCREEN polybar --config=$CONFIG primary 2>&1 | tee -a /var/tmp/polybar_$m.log & disown
    # Handle secondary monitors
    else
      MONITOR=$SCREEN polybar --config=$CONFIG secondary 2>&1 | tee -a /var/tmp/polybar_$m.log & disown
    fi
  done
fi
