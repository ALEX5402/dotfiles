#!/usr/bin/env bash

paused=$(dunstctl is-paused)

if [ "$paused" = "false" ]; then
    hyprctl notify 2 1666 "rgb(E5BD49)" "fontsize:20 Notifications are now paused."
    dunstctl set-paused true
else
    # Turn off DND
    dunstctl set-paused false
    hyprctl notify 5 1666 "rgb(AE446A)" "fontsize:20 Notifications are now active."
fi

