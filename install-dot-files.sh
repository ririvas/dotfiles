#!/bin/bash

# Path to user's .bash_profile
BASH_PROFILE="$HOME/.bash_profile"
DEFAULT_PROFILE=".default_bash_profile"

# Check if .bash_profile exists
if [ ! -f "$BASH_PROFILE" ]; then
    touch "$BASH_PROFILE"
    echo "Created $BASH_PROFILE"
fi

# Define an array of files to symlink
files_to_link=(
    "$DEFAULT_PROFILE"
    ".screenrc"
    ".git-completion.bash"
    ".git-prompt.sh"
    ".prompt-colors.sh"
    ".config/nvim/init.lua"
    ".config/nvim/lazy-lock.json"
    ".config/nvim/lazyvim.json"
    ".config/nvim/lua"
    # Add more files as needed
)

# Get the absolute path of the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create backup directory with timestamp
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Loop through the files and symlink them to home directory
for file in "${files_to_link[@]}"; do
    source_path="$DOTFILES_DIR/$file"
    target_path="$HOME/$file"

    # Create parent directory if it doesn't exist
    target_dir=$(dirname "$target_path")
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
        echo "Created directory: $target_dir"
    fi

    if [ -e "$source_path" ]; then # Use -e to check if file or directory exists
        if [ ! -e "$target_path" ]; then
            # File/directory doesn't exist - create symlink
            ln -sf "$source_path" "$target_path"
            echo "Symlinked $file to $HOME/"
        elif [ -L "$target_path" ]; then
            # Already a symlink
            echo "$target_path is already a symlink"
        else
            # Exists but is not a symlink
            echo "Backing up existing $target_path to $BACKUP_DIR/"
            cp -R "$target_path" "$BACKUP_DIR/"
            rm -rf "$target_path"
            ln -sf "$source_path" "$target_path"
            echo "Replaced $target_path with symlink"
        fi
    else
        echo "Warning: $file not found in $DOTFILES_DIR"
    fi
done
# Check if .bash_profile already sources .default_bash_profile
if ! grep -q "source .*${DEFAULT_PROFILE}" "$BASH_PROFILE"; then
    echo -e "\n# Source default bash profile\nif [ -f \"$HOME/$DEFAULT_PROFILE\" ]; then\n    source \"$HOME/$DEFAULT_PROFILE\"\nfi" >>"$BASH_PROFILE"
    echo "Added source command to $BASH_PROFILE"
else
    echo "$BASH_PROFILE already sources $DEFAULT_PROFILE"
fi
