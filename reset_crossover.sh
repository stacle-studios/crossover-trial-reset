#!/usr/bin/env bash

echo "=== CrossOver Trial Reset Script ==="
echo "Started at: $(date)"
echo

# Locate CrossOver binary
# Locate CrossOver binary
path=/Applications/CrossOver.app/Contents/MacOS
CO_PWD="$HOME$path"

[ -d "${CO_PWD}" ] || CO_PWD="$path"
while [ ! -d "${CO_PWD}" ]; do
    echo "[ERROR] Application not valid. Please provide the binary location."
    read -r -p "Location: " CO_PWD
done

echo "[INFO] CrossOver path: ${CO_PWD}"

# Kill all CrossOver processes
echo "[INFO] Killing running CrossOver processes..."
pkill -9 CrossOver 2>/dev/null || echo "[INFO] No running CrossOver processes found."

sleep 2

# Set new RFC3339 UTC datetime (3 hours back)
DATETIME=$(date -u -v -3H '+%Y-%m-%dT%TZ')
PLIST=~/Library/Preferences/com.codeweavers.CrossOver.plist

if [ -f "${PLIST}" ]; then
    echo "[INFO] Updating trial start date in preferences..."
    plutil -replace FirstRunDate -date "${DATETIME}" "${PLIST}"
    plutil -replace SULastCheckTime -date "${DATETIME}" "${PLIST}"
else
    echo "[WARNING] CrossOver plist not found. Skipping plist update."
fi

# Clean bottle system.reg entries
BOTTLE_DIR="$(defaults read com.codeweavers.CrossOver BottleDir 2>/dev/null)"
BOTTLE_DIR="${BOTTLE_DIR:-$HOME/Library/Application Support/CrossOver/Bottles}"
BOTTLE_DIR="${BOTTLE_DIR/#\~/$HOME}"
echo "[INFO] Cleaning system.reg entries from bottles..."
for file in "${BOTTLE_DIR}"/*/system.reg; do
    [ -f "${file}" ] || continue
    sed -i '' -e "/^\[Software\\\\\\\\CodeWeavers\\\\\\\\CrossOver\\\\\\\\cxoffice\]/,+6d" "${file}"
    echo "  → Cleaned ${file}"
done

# Remove update timestamp files
echo "[INFO] Removing .update-timestamp files..."
for update_file in "${BOTTLE_DIR}"/*/.update-timestamp; do
    [ -f "${update_file}" ] && rm -f "${update_file}" && echo "  → Deleted ${update_file}"
done

# Show macOS notifications
/usr/bin/osascript -e "display notification \"Trial date reset to ${DATETIME}\" with title \"CrossOver Trial Reset\""
/usr/bin/osascript -e "display notification \"Bottle timestamps removed\" with title \"CrossOver Trial Reset\""

# Start original CrossOver binary
ORIGINAL="${CO_PWD}/CrossOver"
[ -x "${ORIGINAL}" ] && {
    echo "[INFO] Launching CrossOver..."
    open -a "${ORIGINAL}"
} || {
    echo "[ERROR] Could not find executable: ${ORIGINAL}"
    exit 1
}

echo
echo "=== Done ==="

