#!/bin/bash
# System startup script called when i3 starts
#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Store the wlan interface in an env variable
export WLAN=$(ip link show | grep \<BROADCAST | awk -F':' '{print $2}' | xargs)

blueman-applet &

# Launch Polybar, using default config location ~/.config/polybar/config
polybar bottom &

# Set monitor placement and size
#xrandr --output LVDS1 --auto --left-of HDMI1
#xrandr --output HDMI1 --auto
