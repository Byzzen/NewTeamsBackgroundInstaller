#Initial check if Teams is installed, if not exit script.
$msTeamsPathPattern = "C:\Program Files\WindowsApps\MSTeams*"

# Get all directories that match the pattern
$directories = Get-ChildItem -Path $msTeamsPathPattern -Directory

# Check if any directories were found
if ($directories.Count -eq 0) {
    exit
}


# Define the folder paths
$sourceFolder = $PSScriptRoot # Current folder where the script resides
$destinationFolder = "C:\Windows\customization\TeamsBackground"
$uploadsFolder = Join-Path -Path $destinationFolder -ChildPath "uploads"
$Backgroundsfolder = Join-Path -Path $sourceFolder -ChildPath "uploads"

# Check if the destination folder exists, if not, create it
if (-not (Test-Path -Path $uploadsFolder -PathType Container)) {
    New-Item -Path $uploadsFolder -ItemType Directory -Force | Out-Null
}

# Copy all *.jpeg files from the source to the destination
Copy-Item -Path "$Backgroundsfolder\*.jpeg" -Destination $uploadsFolder -Force

# Copy the PowerShell script that copies the backgrounds from the current folder to the destination folder
Get-ChildItem -Path $sourceFolder -Filter CopyTeamsBackground.ps1 | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $destinationFolder -Force
}


# Define registry key path
$TeamsBackgroundkeypath = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{CopyTeamsBackground}"

if (-not (Test-Path -Path $TeamsBackgroundkeypath)) {
    New-Item -Path $TeamsBackgroundkeypath -Force | Out-Null
}

# Add registry values

New-ItemProperty -Path $TeamsBackgroundkeypath -Name "(Default)" -Value "CopyTeamsBackgrounds" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $TeamsBackgroundkeypath -Name "Version" -Value "1.0" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $TeamsBackgroundkeypath -Name "StubPath" -Value 'powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Windows\customization\TeamsBackground\CopyTeamsBackground.ps1"' -PropertyType String -Force | Out-Null
