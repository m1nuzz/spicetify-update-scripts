# install_marketplace.ps1

[CmdletBinding()]
param(
    [Parameter()]
    [switch]$BypassAdmin = $true    # Default to bypass admin check
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Invoke-Spicetify {
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$Arguments
    )
    
    $argsList = @()
    if ($BypassAdmin) { $argsList += '--bypass-admin' }
    $argsList += $Arguments
    
    & spicetify @argsList
    return $LASTEXITCODE
}

function Invoke-SpicetifyWithOutput {
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$Arguments
    )
    
    $argsList = @()
    if ($BypassAdmin) { $argsList += '--bypass-admin' }
    $argsList += $Arguments
    
    $output = (& spicetify @argsList 2>&1 | Out-String).Trim()
    return @{ Output = $output; ExitCode = $LASTEXITCODE }
}

Write-Host 'Setting up...' -ForegroundColor Cyan

# Install Spicetify CLI if missing
if (-not (Get-Command spicetify -ErrorAction SilentlyContinue)) {
    Write-Host 'Spicetify CLI not found. Installing...' -ForegroundColor Cyan
    Invoke-WebRequest 'https://raw.githubusercontent.com/spicetify/cli/main/install.ps1' -UseBasicParsing | Invoke-Expression
}

# Determine user data path
try {
    $res = Invoke-SpicetifyWithOutput 'path' 'userdata'
    if ($res.ExitCode -ne 0) { throw $res.Output }
    $userDataPath = $res.Output
} catch {
    Write-Host "Error running spicetify: $_" -ForegroundColor Red
    return
}

if (-not (Test-Path $userDataPath)) {
    $userDataPath = "$env:APPDATA\spicetify"
}

$marketApp    = Join-Path $userDataPath 'CustomApps\marketplace'
$marketTheme  = Join-Path $userDataPath 'Themes\marketplace'

# Clean and create directories
Remove-Item -Recurse -Force $marketApp, $marketTheme -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $marketApp, $marketTheme | Out-Null

# Download and unzip marketplace
Write-Host 'Downloading marketplace...' -ForegroundColor Cyan
$zipPath = Join-Path $marketApp 'marketplace.zip'
Invoke-WebRequest 'https://github.com/spicetify/marketplace/releases/latest/download/marketplace.zip' -UseBasicParsing -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $marketApp -Force
Remove-Item $zipPath

# Configure Spicetify
Invoke-Spicetify 'config' 'custom_apps' 'marketplace'
Invoke-Spicetify 'config' 'inject_css' '1' 'replace_colors' '1'

# Placeholder theme color file
Write-Host 'Setting up theme placeholders...' -ForegroundColor Cyan
Invoke-WebRequest 'https://raw.githubusercontent.com/spicetify/marketplace/main/resources/color.ini' -UseBasicParsing -OutFile (Join-Path $marketTheme 'color.ini')

# Apply configuration
Invoke-Spicetify 'config' 'current_theme' 'marketplace'
Invoke-Spicetify 'backup'
Invoke-Spicetify 'apply'

Write-Host "Done! Marketplace installed with bypass-admin: $BypassAdmin" -ForegroundColor Green
