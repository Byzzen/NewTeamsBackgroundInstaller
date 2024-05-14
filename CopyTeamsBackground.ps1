# Specify the destination directory
$destinationDirectory = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads"

# Check if the destination directory exists, if not, create it
if (-not (Test-Path -Path $destinationDirectory)) {
    New-Item -Path $destinationDirectory -ItemType Directory -Force
}

# Get the path of the current script directory
$currentScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Copy files from the uploads directory to the destination directory
Copy-Item -Path "$currentScriptDirectory\uploads\*.jpeg" -Destination $destinationDirectory -Force
