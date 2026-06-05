#!/usr/bin/env sh
window_data=$(hyprctl activewindow -j)
if [ -z "$window_data" ]; then
    echo "Failed to retrieve active window data."
    exit 1
fi
pid=$(echo "$window_data" | jq '.pid')
if [ -z "$pid" ]; then
    echo "Failed to retrieve PID from active window data."
    exit 1
fi
pkill -TERM -P "$pid"
if [ $? -eq 0 ]; then
    echo "Process with PID $pid has been sent a SIGTERM signal."
else
    echo "Failed to send SIGTERM to process with PID $pid. Make sure the PID is correct and you have sufficient permissions."
fi
