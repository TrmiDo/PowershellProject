$BackupLocationsFilePath="C:\Users\triet\Desktop\psproject\BackupDir.txt"
$BackupLocations=Get-Content -Path $BackupLocationsFilePath

$StorageLocation="C:\Users\triet\Desktop\BackUpStorage"
$BackupName="Backup $(Get-Date -Format "yyyy-MM-dd hh-mm")"

foreach($Location in $BackupLocations){
    Write-Output "Backing up $($Location)"
   if (-not (Test-Path "$StorageLocation\$BackupName")) {
    New-Item -Path "$StorageLocation\$BackupName" -ItemType Directory
}

$filesToBackup = Get-ChildItem -Path $Location | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-730) -and $_.LastAccessTime -lt (Get-Date).AddDays(-365) }
Copy-Item -Path $filesToBackup.FullName -Destination "$StorageLocation\$BackupName" -Recurse -Container
}

Compress-Archive -Path "$StorageLocation\$BackupName" -DestinationPath "$StorageLocation\$BackupName.zip" -CompressionLevel Fastest