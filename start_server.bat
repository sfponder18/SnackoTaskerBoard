@echo off
REM ============================================================
REM  493rd FS SNACKO OPS - Dashboard Server (Windows)
REM  Double-click this file or run from command prompt.
REM
REM  Then open your browser to: http://localhost:8493
REM ============================================================

echo.
echo   SNACKO OPS DASHBOARD
echo   ======================================
echo   Press Ctrl+C to stop
echo.

cd /d "%~dp0"
start http://localhost:8493
python server.py
