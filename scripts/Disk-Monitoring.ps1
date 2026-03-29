# ==========================================
# Disk Monitoring Lab
# Checks disk usage and creates report + log
# ==========================================

$basePath   = "C:\Disk-Monitoring-Lab"
$reportPath = Join-Path $basePath "Reports"
$logPath    = Join-Path $basePath "Logs"

$today      = Get-Date -Format "yyyy-MM-dd"
$timestamp  = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

$reportFile = Join-Path $reportPath "Disk_Report_$timestamp.csv"
$logFile    = Join-Path $logPath "Disk_Log_$today.txt"

# Create folders if missing
foreach ($folder in @($reportPath, $logPath)) {
    if (-not (Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory -Force | Out-Null
    }
}

# Logging function
function Write-Log {
    param([string]$Message)
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$time - $Message"
}

try {
    Write-Log "Disk monitoring script started."

    $diskReport = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
        $sizeGB = [math]::Round($_.Size / 1GB, 2)
        $freeGB = [math]::Round($_.FreeSpace / 1GB, 2)
        $usedGB = [math]::Round($sizeGB - $freeGB, 2)
        $freePercent = [math]::Round(($_.FreeSpace / $_.Size) * 100, 2)

        $status = if ($freePercent -lt 10) {
            "Critical"
        }
        elseif ($freePercent -lt 20) {
            "Warning"
        }
        else {
            "Healthy"
        }

        [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            DriveLetter  = $_.DeviceID
            TotalSizeGB  = $sizeGB
            UsedSpaceGB  = $usedGB
            FreeSpaceGB  = $freeGB
            FreePercent  = $freePercent
            Status       = $status
            CheckedAt    = Get-Date
        }
    }

    $diskReport | Export-Csv -Path $reportFile -NoTypeInformation -Encoding UTF8
    Write-Log "Disk report exported to $reportFile"

    $criticalDisks = $diskReport | Where-Object { $_.Status -eq "Critical" }
    $warningDisks  = $diskReport | Where-Object { $_.Status -eq "Warning" }

    if ($criticalDisks) {
        Write-Log "Critical disk condition detected."
    }

    if ($warningDisks) {
        Write-Log "Warning disk condition detected."
    }

    Write-Log "Disk monitoring script completed successfully."
}
catch {
    Write-Log "ERROR: $($_.Exception.Message)"
    throw
}

$diskReport | Where-Object { $_.Status -ne "Healthy" }

Get-ChildItem -Path $reportPath -File |
Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-14) } |
Remove-Item -Force

$diskReport | Format-Table -AutoSize
