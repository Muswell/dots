#!/bin/bash
# System startup script called when i3 starts

# Set monitor placement and size
#xrandr --output LVDS1 --auto --left-of HDMI1
#xrandr --output HDMI1 --auto

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Sometimes the interface values don't populate immediately, so loop /shrug
while [ -z "$WLAN" ]
do
  # Store the wlan interface in an env variable
  export WLAN=$(ip link show | grep \<BROADCAST | awk -F':' '{print $2}' | xargs)
  #export DEFAULT_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
done

# Launch Polybar, using default config location ~/.config/polybar/config
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --reload bottom &
done
