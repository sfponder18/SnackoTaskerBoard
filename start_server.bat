@echo off
REM ============================================================
REM  493rd FS SNACKO OPS - Dashboard Server (Windows)
REM  Double-click this file or run from command prompt.
REM
REM  Then open your browser to: http://localhost:8493
REM ============================================================

set PORT=8493

echo.
echo   ☠  493rd FS SNACKO OPS DASHBOARD  ☠
echo   ======================================
echo   Serving from: %~dp0
echo   URL: http://localhost:%PORT%
echo   Press Ctrl+C to stop
echo.

cd /d "%~dp0"
start http://localhost:%PORT%
python -m http.server %PORT%
