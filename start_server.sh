#!/bin/bash
# ============================================================
#  493rd FS SNACKO OPS - Dashboard Launcher
#  Starts the server and opens Chromium in kiosk mode.
#
#  First time setup:
#    chmod +x start_server.sh
#
#  Then just double-click or run:
#    ./start_server.sh
# ============================================================

PORT=8493

# Always use the directory where this script lives
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Kill any previous instance
pkill -f "python3 server.py" 2>/dev/null
pkill -f chromium 2>/dev/null
sleep 1

echo ""
echo "  SNACKO OPS DASHBOARD"
echo "  ======================================"
echo "  Serving from: $DIR"
echo "  URL: http://localhost:$PORT"
echo ""

# Start server in background
cd "$DIR"
python3 server.py &
sleep 2

# Find the right browser command
BROWSER=""
for cmd in chromium chromium-browser google-chrome google-chrome-stable firefox; do
  if command -v "$cmd" &>/dev/null; then
    BROWSER="$cmd"
    break
  fi
done

if [ -z "$BROWSER" ]; then
  echo "  No browser found. Open http://localhost:$PORT manually."
else
  echo "  Opening $BROWSER..."
  "$BROWSER" --kiosk --noerrdialogs --disable-infobars \
    --disable-session-crashed-bubble http://localhost:$PORT &
fi

wait
