#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

SOURCE_DIR="$1"
DEST_DIR="$2"

# Remove trailing slashes for consistency
SOURCE_DIR="${SOURCE_DIR%/}"
DEST_DIR="${DEST_DIR%/}"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating destination directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
fi

echo "Starting synchronization..."
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_DIR"
echo

# Function to get relative path
get_relative_path() {
    local full_path="$1"
    local base_path="$2"
    echo "${full_path#$base_path/}"
}

# Function to copy file with directory structure
copy_file() {
    local src_file="$1"
    local dest_file="$2"
    
    # Create destination directory if needed
    local dest_dir=$(dirname "$dest_file")
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
    fi
    
    # Copy file preserving timestamps
    cp -p "$src_file" "$dest_file"
    echo "Copied: $(get_relative_path "$src_file" "$SOURCE_DIR")"
}

# Step 1: Copy new/modified files from source to destination
echo "=== Checking for new/modified files ==="
while IFS= read -r -d '' src_file; do
    # Get relative path
    rel_path=$(get_relative_path "$src_file" "$SOURCE_DIR")
    dest_file="$DEST_DIR/$rel_path"
    
    # Check if destination file exists
    if [ ! -f "$dest_file" ]; then
        # File doesn't exist in destination, copy it
        copy_file "$src_file" "$dest_file"
    else
        # File exists, check modification times
        src_mtime=$(stat -c %Y "$src_file" 2>/dev/null || stat -f %m "$src_file" 2>/dev/null)
        dest_mtime=$(stat -c %Y "$dest_file" 2>/dev/null || stat -f %m "$dest_file" 2>/dev/null)
        
        if [ "$src_mtime" -gt "$dest_mtime" ]; then
            # Source file is newer, copy it
            copy_file "$src_file" "$dest_file"
        fi
    fi
done < <(find "$SOURCE_DIR" -type f -print0)

echo

# Step 2: Handle files that exist in destination but not in source
echo "=== Checking for deleted files ==="
files_to_delete=()

while IFS= read -r -d '' dest_file; do
    # Get relative path
    rel_path=$(get_relative_path "$dest_file" "$DEST_DIR")
    src_file="$SOURCE_DIR/$rel_path"
    
    # Check if source file exists
    if [ ! -f "$src_file" ]; then
        files_to_delete+=("$dest_file")
    fi
done < <(find "$DEST_DIR" -type f -print0)

# Ask user about deletion for each file
if [ ${#files_to_delete[@]} -gt 0 ]; then
    echo "Found ${#files_to_delete[@]} file(s) that exist in destination but not in source:"
    echo
    
    for dest_file in "${files_to_delete[@]}"; do
        rel_path=$(get_relative_path "$dest_file" "$DEST_DIR")
        echo -n "Delete '$rel_path'? [Y/n]: "
        read -r response
        
        case "$response" in
            [nN]|[nN][oO])
                echo "Skipped: $rel_path"
                ;;
            *)
                rm "$dest_file"
                echo "Deleted: $rel_path"
                
                # Remove empty directories
                dest_dir=$(dirname "$dest_file")
                while [ "$dest_dir" != "$DEST_DIR" ] && [ -d "$dest_dir" ] && [ -z "$(ls -A "$dest_dir")" ]; do
                    rmdir "$dest_dir"
                    echo "Removed empty directory: $(get_relative_path "$dest_dir" "$DEST_DIR")"
                    dest_dir=$(dirname "$dest_dir")
                done
                ;;
        esac
        echo
    done
else
    echo "No files to delete."
fi

echo "Synchronization complete!"
