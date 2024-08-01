#!/usr/bin/env bash

# Get the current paused state
paused=$(dunstctl is-paused)

# get the icon directory
icondir="$HOME/.config/dunst/icons"

if [ "$paused" = "false" ]; then
    # Turn on DND
    notify-send -i "$icondir/dnd-on.svg" "DND ON" "Notifications are now paused."
    dunstctl set-paused true
else
    # Turn off DND
    dunstctl set-paused false
    notify-send -i "$icondir/allow-notifications.svg" "DND OFF" "Notifications are now active."
fi

