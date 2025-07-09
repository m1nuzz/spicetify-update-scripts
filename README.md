# Spicetify Update Scripts

Scripts to update Spicetify after Spotify client updates (PowerShell and BAT).

## Usage

1. Place all files in the same folder.
2. Run `SpicetifyUpdate_RunAs.bat` to update Spicetify in the required trust level mode.

- `MyPowerShellScript.ps1`: PowerShell script for Spicetify update/backup/restore
- `SpicetifyUpdate_RunAs.bat`: Batch file to run the PowerShell script with runas /trustlevel:0x20000
