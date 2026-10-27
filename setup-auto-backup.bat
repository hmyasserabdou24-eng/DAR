@echo off
chcp 65001 >nul
title Setup Auto Backup - Dar El Ihsan

echo.
echo ==============================================================
echo     Auto Monthly Backup Setup - Dar El Ihsan
echo ==============================================================
echo.

where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] Python not found. Install Python 3.8+
    pause
    exit /b 1
)

set TOOL_PATH=%~dp0backup-tool.py
set BACKUP_DIR=%USERPROFILE%\DarElIhsan_Backups

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

echo [*] Tool: %TOOL_PATH%
echo [*] Output: %BACKUP_DIR%
echo.

schtasks /create /tn "DarElIhsan_Monthly_Backup" /tr "python \"%TOOL_PATH%\" --auto --out \"%BACKUP_DIR%\"" /sc monthly /d 2 /st 03:00 /rl HIGHEST /f

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==============================================================
    echo  [OK] Scheduled task created successfully!
    echo ==============================================================
    echo.
    echo  Task: DarElIhsan_Monthly_Backup
    echo  Schedule: 2nd of every month at 03:00 AM
    echo  Output: %BACKUP_DIR%
    echo.
    echo  Manual run:
    echo    python "%TOOL_PATH%" --auto --out "%BACKUP_DIR%"
    echo.
    echo  To remove:
    echo    schtasks /delete /tn "DarElIhsan_Monthly_Backup" /f
    echo.
) else (
    echo [!] Failed. Try Run as Administrator.
)

pause
