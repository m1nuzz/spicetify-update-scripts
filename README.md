# Spicetify Update Scripts

Scripts to automatically update Spicetify after Spotify client updates (PowerShell + BAT).

## Usage

1. Download or clone this repo into any folder.
2. To run the update manually:

   * **With window:** double‑click `SpicetifyUpdate_RunAs.bat`
   * **Silent:** double‑click `SpicetifyUpdate_RunAs_Silent.bat`

## Autostart on Windows

To have the update run automatically at login:

1. Press **Win + R**, type `shell:startup`, and press **Enter**.
2. In the Startup folder, right‑click your chosen script (`.bat` file) and select **Create shortcut**.
3. Move the shortcut into the Startup folder.

The script will now execute each time you sign in.

## Files

* **MyPowerShellScript.ps1**
  Performs update, backup, and restore operations for Spicetify.
* **SpicetifyUpdate\_RunAs.bat**
  Launches the PowerShell script with elevated privileges.
* **SpicetifyUpdate\_RunAs\_Silent.bat**
  Same as above, but hides the console window.
