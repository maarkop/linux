#!/bin/bash
set -e  # Exit on any error

PHONE_PATH="/storage/emulated/0/YourFolder"
PC_PATH="/home/user/SyncFolder"
TEMP_DIR="/tmp/sync_$$"

# Check if phone is connected
if ! adb devices | grep -q "device$"; then
    echo "Error: No Android device connected"
    exit 1
fi

# Create temp directory for metadata
mkdir -p "$TEMP_DIR"
trap "rm -rf '$TEMP_DIR'" EXIT

echo "Building file lists..."

# Get phone file list with timestamps
adb shell "find '$PHONE_PATH' -type f -exec stat -c '%Y %n' {} \;" 2>/dev/null > "$TEMP_DIR/phone_files" || {
    echo "Error: Cannot access phone directory $PHONE_PATH"
    exit 1
}

# Get PC file list with timestamps
find "$PC_PATH" -type f -printf '%T@ %p\n' 2>/dev/null | sed 's/\.[0-9]* / /' > "$TEMP_DIR/pc_files" || {
    echo "Error: Cannot access PC directory $PC_PATH"
    exit 1
}

# Create directories if they don't exist
mkdir -p "$PC_PATH"
adb shell "mkdir -p '$PHONE_PATH'" 2>/dev/null || true

echo "Syncing files..."

# Process phone files - pull newer ones to PC
while IFS=' ' read -r timestamp filepath; do
    [[ -z "$filepath" ]] && continue
    
    filename=$(basename "$filepath")
    localfile="$PC_PATH/$filename"
    
    # Skip if local file is newer or same age
    if [[ -f "$localfile" ]]; then
        local_timestamp=$(stat -c %Y "$localfile" 2>/dev/null || echo 0)
        if [[ $timestamp -le $local_timestamp ]]; then
            continue
        fi
    fi
    
    echo "← Pulling: $filename"
    if ! adb pull "$filepath" "$localfile" 2>/dev/null; then
        echo "  Failed to pull $filename"
    fi
done < "$TEMP_DIR/phone_files"

# Process PC files - push newer ones to phone
while IFS=' ' read -r timestamp filepath; do
    [[ -z "$filepath" ]] && continue
    
    filename=$(basename "$filepath")
    phonefile="$PHONE_PATH/$filename"
    
    # Check if file exists on phone and get its timestamp
    phone_timestamp=$(adb shell "stat -c %Y '$phonefile' 2>/dev/null || echo 0")
    
    # Skip if phone file is newer or same age
    if [[ ${timestamp%.*} -le $phone_timestamp ]]; then
        continue
    fi
    
    echo "→ Pushing: $filename"
    if ! adb push "$filepath" "$phonefile" 2>/dev/null; then
        echo "  Failed to push $filename"
    fi
done < "$TEMP_DIR/pc_files"

echo "Sync complete!"
