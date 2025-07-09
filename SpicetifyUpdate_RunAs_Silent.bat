@ECHO OFF

SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%MyPowerShellScript.ps1

start "" /B runas /trustlevel:0x20000 "powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File \"%PowerShellScriptPath%\""
