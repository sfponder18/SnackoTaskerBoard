#!/usr/bin/env python3
"""
493rd FS SNACKO OPS - API Server
Serves static files + JSON API for reading/writing data.json
Binds to 0.0.0.0 for LAN access.
"""

import json
import os
from http.server import HTTPServer, SimpleHTTPRequestHandler
from pathlib import Path

PORT = 8493
DATA_FILE = Path(__file__).parent / "data.json"


class SnackoHandler(SimpleHTTPRequestHandler):

    def do_GET(self):
        if self.path == "/api/data":
            self._serve_data()
        else:
            super().do_GET()

    def do_POST(self):
        if self.path == "/api/data":
            self._save_data()
        else:
            self.send_error(404, "Not Found")

    def do_OPTIONS(self):
        self.send_response(204)
        self.end_headers()

    def _serve_data(self):
        try:
            content = DATA_FILE.read_bytes()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(content)))
            self.send_header("Cache-Control", "no-cache")
            self.end_headers()
            self.wfile.write(content)
        except FileNotFoundError:
            self.send_error(404, "data.json not found")

    def _save_data(self):
        try:
            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length)
            json.loads(body)  # validate JSON before writing
            DATA_FILE.write_bytes(body)
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(b'{"ok": true}')
        except json.JSONDecodeError:
            self.send_error(400, "Invalid JSON")
        except Exception as e:
            self.send_error(500, str(e))

    def end_headers(self):
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        super().end_headers()


def main():
    os.chdir(Path(__file__).parent)
    server = HTTPServer(("0.0.0.0", PORT), SnackoHandler)
    print()
    print("  SNACKO OPS SERVER")
    print("  ======================================")
    print(f"  Serving on http://0.0.0.0:{PORT}")
    print(f"  Data file: {DATA_FILE}")
    print("  Press Ctrl+C to stop")
    print()
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n  Server stopped.")
        server.server_close()


if __name__ == "__main__":
    main()
