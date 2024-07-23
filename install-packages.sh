#!/bin/bash

# Read the dependencies file
file="$1"

# Function to install packages using paru
install_packages() {
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Skip empty lines and lines starting with #
        [[ -z "$line" || $line == \#* ]] && continue
        
        # Extract the package name by removing comments
        package=$(echo "$line" | cut -d '#' -f 1 | xargs)
        
        # If package is non-empty, install it using paru
        if [[ -n "$package" ]]; then
            echo "Installing $package..."
            paru -S --noconfirm "$package"
        fi
    done < "$file"
}

# Run the install_packages function
install_packages

echo "All packages installed."

