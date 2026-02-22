#!/bin/bash

# q4_backup.sh
# This script creates a backup of a directory with a timestamp

echo "Enter source directory:"
read source

echo "Enter backup destination directory:"
read destination

# Check if source directory exists
if [ ! -d "$source" ]; then
    echo "Source directory does not exist."
    exit 1
fi

# Create timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

# Backup file name
backup_name="backup_$timestamp.tar.gz"

# Create backup
tar -czf "$destination/$backup_name" "$source"

echo "Backup created successfully at $destination/$backup_name"