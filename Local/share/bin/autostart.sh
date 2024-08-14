#!/bin/bash

# Directory containing the .desktop files
AUTOSTART_DIR="$HOME/.config/autostart/"

# Loop through all .desktop files in the directory
for desktop_file in "$AUTOSTART_DIR"*.desktop; do
  # Check if the file exists
  if [ -f "$desktop_file" ]; then
    # Extract the Exec line from the .desktop file
    exec_command=$(grep -E '^Exec=' "$desktop_file" | sed 's/^Exec=//')

    # Check if an Exec command was found
    if [ -n "$exec_command" ]; then
      # Run the command
      $exec_command &
    fi
  fi
done
