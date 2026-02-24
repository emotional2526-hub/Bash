#!/bin/bash


echo "================================="
echo "     AUTOMATED BACKUP SCRIPT"
echo "================================="

# Ask for source directory
echo -n "Enter directory to backup: "
read SOURCE

# Validate source directory
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory does not exist!"
    exit 1
fi

# Ask for destination
echo -n "Enter backup destination: "
read DEST

# Create destination if not exists
mkdir -p "$DEST"

# Backup type selection
echo "Backup Type:"
echo "1. Simple copy"
echo "2. Compressed archive (tar.gz)"
echo -n "Enter choice: "
read CHOICE

# Create timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Extract directory name
DIRNAME=$(basename "$SOURCE")

START=$(date +%s)

echo "[*] Starting backup..."
echo "[*] Source: $SOURCE"
echo "[*] Destination: $DEST"

# Perform backup
if [ "$CHOICE" -eq 1 ]; then
    BACKUP_NAME="backup_${TIMESTAMP}"
    cp -r "$SOURCE" "$DEST/$BACKUP_NAME"
    
elif [ "$CHOICE" -eq 2 ]; then
    BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
    echo "[*] Creating compressed archive..."
    tar -czf "$DEST/$BACKUP_NAME" -C "$(dirname "$SOURCE")" "$DIRNAME"
    
else
    echo "Invalid choice!"
    exit 1
fi

END=$(date +%s)
DURATION=$((END - START))

# Verify backup
if [ -e "$DEST/$BACKUP_NAME" ]; then
    SIZE=$(du -sh "$DEST/$BACKUP_NAME" | awk '{print $1}')
    
    echo ""
    echo "Backup completed successfully!"
    echo "---------------------------------"
    echo "Backup Details:"
    echo "File: $BACKUP_NAME"
    echo "Location: $DEST"
    echo "Size: $SIZE"
    echo "Time taken: $DURATION seconds"
else
    echo "Backup failed!"
    exit 1
fi

# ==============================
# BONUS: Keep only last 5 backups
# ==============================

echo ""
echo "[*] Checking old backups..."

ls -tp "$DEST"/backup_* 2>/dev/null | grep -v '/$' | tail -n +6 | xargs -r rm --

echo "[*] Old backups cleaned (keeping latest 5)."

# ==============================
# BONUS: Log file
# ==============================

LOGFILE="$DEST/backup.log"

echo "$(date) - Backup created: $BACKUP_NAME - Size: $SIZE - Time: $DURATION sec" >> "$LOGFILE"

echo "[*] Backup log updated."
echo "================================="