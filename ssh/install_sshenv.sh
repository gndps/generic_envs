#!/bin/bash

# URL of the script to be downloaded
SCRIPT_URL="https://raw.githubusercontent.com/gndps/generic_envs/refs/heads/main/ssh/sshenv"

# Destination path for the script
DEST_PATH="$HOME/.ssh/sshenv"
mkdir -p $HOME/.ssh

# Download the script
echo "Downloading script from $SCRIPT_URL to $DEST_PATH..."
curl -sSf "$SCRIPT_URL" -o "$DEST_PATH"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download the script. Please check the URL and try again."
    exit 1
fi

# Make the script executable
chmod +x "$DEST_PATH"
echo "Script downloaded and made executable."

# Determine the appropriate shell profile file
if [ -f "$HOME/.bash_profile" ]; then
    PROFILE_FILE="$HOME/.bash_profile"
elif [ -f "$HOME/.bashrc" ]; then
    PROFILE_FILE="$HOME/.bashrc"
else
    PROFILE_FILE=""
fi

# Append the source command to the profile file if it exists
if [ -n "$PROFILE_FILE" ]; then
    echo "Appending source command to $PROFILE_FILE..."
    echo "source $DEST_PATH" >> "$PROFILE_FILE"
    echo "Source command added. Please restart your terminal or run 'source $PROFILE_FILE' to apply changes."
else
    echo "No .bash_profile or .bashrc found. Please manually add the following line to your shell profile:"
    echo "source $DEST_PATH"
fi
