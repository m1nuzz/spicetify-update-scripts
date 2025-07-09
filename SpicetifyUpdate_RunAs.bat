@ECHO OFF

SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%MyPowerShellScript.ps1

runas /trustlevel:0x20000 "powershell -NoProfile -ExecutionPolicy Bypass -File \"%PowerShellScriptPath%\""
