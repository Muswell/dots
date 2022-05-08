#!/bin/bash
# System startup script called when i3 starts

# Set monitor placement and size
#xrandr --output LVDS1 --auto --left-of HDMI1
#xrandr --output HDMI1 --auto

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# adjust screens
#autorandr --change
#feh --bg-fill /usr/share/pixmaps/dm-background.jpg

# getting this from ip link takes too long, todo find a faster way of dynamically setting
#export WLAN=wlp7s0
export ETH=enp9s0


# Launch Polybar, using default config location ~/.config/polybar/config
#for m in $(polybar --list-monitors | cut -d":" -f1); do
#  MONITOR=$m polybar --reload bottom > $HOME/log/polybar/polybar.log &
#done

MONITOR='HDMI-A-0' polybar --reload bottom > $HOME/log/polybar/hdmi.log &
export MONITOR_RIGHT='DisplayPort-2'
polybar --reload bottom_right > $HOME/log/polybar/dp.log &
