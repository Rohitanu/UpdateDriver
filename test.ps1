# Dell Driver Auto-Update Script using Dell Command | Update
# Ensure Dell Command | Update is installed

$dcuPath = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"

# Check if Dell Command | Update is installed
if (-Not (Test-Path $dcuPath)) {
    Write-Host "Dell Command | Update not found. Downloading and installing..."

    $installerUrl = "https://dl.dell.com/FOLDER04358530M/6/Dell-Command-Update_X79N4_WIN_2.3.1_A00_03.EXE?uid=e079d75b-5f89-4555-2b96-0732b498d3eb&fn=Dell-Command-Update_X79N4_WIN_2.3.1_A00_03.EXE"
    $installerPath = "$env:TEMP\DellCommandUpdate.exe"

    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
    Start-Process -FilePath $installerPath -ArgumentList "/s" -Wait

    if (-Not (Test-Path $dcuPath)) {
        Write-Error "Failed to install Dell Command | Update."
        exit 1
    }
}

# Run Dell Command | Update in silent mode
Write-Host "Running Dell Command | Update..."
Start-Process -FilePath $dcuPath -ArgumentList "/scan -update -silent" -Wait

Write-Host "Dell driver update process completed."
