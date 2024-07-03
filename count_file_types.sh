#!/bin/bash

# Check if no arguments or more than one argument is provided
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "Error: Exactly one directory path must be provided."
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

# Check if the provided path is a valid directory
if [ ! -d "$1" ]; then
    echo "Error: Invalid directory path provided."
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

# Initialize counts
dir_count=0
file_count=0
symlink_count=0

# Iterate through the items in the directory and count file types
while IFS= read -r -d '' item; do
    if [ -d "$item" ]; then
        ((dir_count++))
    elif [ -f "$item" ]; then
        ((file_count++))
    elif [ -L "$item" ]; then
        ((symlink_count++))
    fi
done < <(find "$1" -mindepth 1 -maxdepth 1 -print0)

# Display the counts
echo "Directories: $dir_count"
echo "Regular files: $file_count"
echo "Symbolic links: $symlink_count"