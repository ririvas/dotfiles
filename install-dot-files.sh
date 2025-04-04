#!/bin/bash

# Path to user's .bash_profile
BASH_PROFILE="$HOME/.bash_profile"
DEFAULT_PROFILE=".default_bash_profile"

# Check if .bash_profile exists
if [ ! -f "$BASH_PROFILE" ]; then
    touch "$BASH_PROFILE"
    echo "Created $BASH_PROFILE"
fi

# Copy .default_bash_profile to home directory if it doesn't exist
if [ ! -f "$HOME/$DEFAULT_PROFILE" ]; then
    cp "$DEFAULT_PROFILE" "$HOME/$DEFAULT_PROFILE"
    echo "Copied $DEFAULT_PROFILE to $HOME/"
else
    echo "$HOME/$DEFAULT_PROFILE already exists"
fi

# Copy .git-completion.bash to home directory if it doesn't exist
if [ ! -f "$HOME/.git-completion.bash" ]; then
    cp ".git-completion.bash" "$HOME/.git-completion.bash"
    echo "Copied .git-completion.bash to $HOME/"
else
    echo "$HOME/.git-completion.sh already exists"
fi

# Copy .prompt-colors.sh to home directory if it doesn't exist
if [ ! -f "$HOME/.prompt-colors.sh" ]; then
    cp ".prompt-colors.sh" "$HOME/.prompt-colors.sh"
    echo "Copied .prompt-colors.sh to $HOME/"
else
    echo "$HOME/.prompt-colors.sh already exists"
fi

# Copy .git-prompt.sh to home directory if it doesn't exist
if [ ! -f "$HOME/.git-prompt.sh" ]; then
    cp ".git-prompt.sh" "$HOME/.git-promit.sh"
    echo "Copied .git-prompt.sh to $HOME/"
else
    echo "$HOME/.git-prompt.sh already exists"
fi

# Check if .bash_profile already sources .default_bash_profile
if ! grep -q "source .*${DEFAULT_PROFILE}" "$BASH_PROFILE"; then
    echo -e "\n# Source default bash profile\nif [ -f \"$HOME/$DEFAULT_PROFILE\" ]; then\n    source \"$HOME/$DEFAULT_PROFILE\"\nfi" >> "$BASH_PROFILE"
    echo "Added source command to $BASH_PROFILE"
else
    echo "$BASH_PROFILE already sources $DEFAULT_PROFILE"
fi
