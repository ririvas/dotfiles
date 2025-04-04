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
  # Add more files as needed
)

# Get the absolute path of the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create backup directory with timestamp
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Loop through the files and symlink them to home directory
for file in "${files_to_link[@]}"; do
  if [ -f "$DOTFILES_DIR/$file" ]; then
    if [ ! -e "$HOME/$file" ]; then
      # File doesn't exist - create symlink
      ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
      echo "Symlinked $file to $HOME/"
    elif [ -L "$HOME/$file" ]; then
      # File is already a symlink
      echo "$HOME/$file is already a symlink"
    else
      # File exists but is not a symlink
      echo "Backing up existing $HOME/$file to $BACKUP_DIR/"
      cp "$HOME/$file" "$BACKUP_DIR/"
      rm "$HOME/$file"
      ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
      echo "Replaced $HOME/$file with symlink"
    fi
  else
    echo "Warning: $file not found in $DOTFILES_DIR"
  fi
done

# Check if .bash_profile already sources .default_bash_profile
if ! grep -q "source .*${DEFAULT_PROFILE}" "$BASH_PROFILE"; then
    echo -e "\n# Source default bash profile\nif [ -f \"$HOME/$DEFAULT_PROFILE\" ]; then\n    source \"$HOME/$DEFAULT_PROFILE\"\nfi" >> "$BASH_PROFILE"
    echo "Added source command to $BASH_PROFILE"
else
    echo "$BASH_PROFILE already sources $DEFAULT_PROFILE"
fi
