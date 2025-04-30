#!/usr/bin/env bash

echo "=== CrossOver Trial Reset Script ==="
echo "Started at: $(date)"
echo

# Check if pidof exists, install if needed
if ! command -v pidof >/dev/null 2>&1; then
    echo "[INFO] 'pidof' not found. Installing via Homebrew..."
    brew install pidof || { echo "[ERROR] Failed to install pidof. Exiting."; exit 1; }
fi

# Locate CrossOver binary
CO_PWD=~/Applications/CrossOver.app/Contents/MacOS
[ -d "${CO_PWD}" ] || CO_PWD=/Applications/CrossOver.app/Contents/MacOS
[ -d "${CO_PWD}" ] || { echo "[ERROR] Could not locate CrossOver binary. Exiting."; exit 1; }

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
BOTTLE_DIR=~/Library/Application\ Support/CrossOver/Bottles
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

