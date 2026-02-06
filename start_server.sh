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
DIR="$(cd "$(dirname "$0")" && pwd)"

# Kill any previous instance
pkill -f "python3 server.py" 2>/dev/null

echo ""
echo "  SNACKO OPS DASHBOARD"
echo "  ======================================"
echo "  Serving from: $DIR"
echo "  URL: http://localhost:$PORT"
echo ""

# Start server in background
cd "$DIR"
python3 server.py &>/dev/null &

# Wait for server to be ready
sleep 1

# Launch Chromium in kiosk mode
chromium-browser --kiosk --noerrdialogs --disable-infobars \
  --disable-session-crashed-bubble http://localhost:$PORT
