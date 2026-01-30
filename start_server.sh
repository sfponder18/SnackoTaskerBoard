#!/bin/bash
# ============================================================
#  493rd FS SNACKO OPS - Dashboard Server
#  Run this on the Raspberry Pi Zero to serve the dashboard.
#
#  Usage:
#    chmod +x start_server.sh
#    ./start_server.sh
#
#  Then open Chromium in kiosk mode on the Pi's display:
#    chromium-browser --kiosk --noerrdialogs --disable-infobars \
#      --disable-session-crashed-bubble http://localhost:8493
#
#  To update data remotely:
#    ssh pi@<pi-ip-address>
#    nano /home/pi/SnackoTaskerBoard/data.json
#    (dashboard auto-refreshes every 30 seconds)
# ============================================================

PORT=8493
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "  ☠  493rd FS SNACKO OPS DASHBOARD  ☠"
echo "  ======================================"
echo "  Serving from: $DIR"
echo "  URL: http://localhost:$PORT"
echo "  Press Ctrl+C to stop"
echo ""

cd "$DIR"
python3 -m http.server "$PORT"
