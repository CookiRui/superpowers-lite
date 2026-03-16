# Stop the brainstorm server and clean up (PowerShell version)
# Usage: stop-server.ps1 <screen_dir>

param(
    [Parameter(Mandatory=$true)]
    [string]$ScreenDir
)

if ([string]::IsNullOrEmpty($ScreenDir)) {
    Write-Output '{"error": "Usage: stop-server.ps1 <screen_dir>"}'
    exit 1
}

$PidFile = Join-Path $ScreenDir ".server.pid"

if (Test-Path $PidFile) {
    $pid = Get-Content $PidFile
    try { Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue } catch {}
    Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $ScreenDir ".server.log") -Force -ErrorAction SilentlyContinue

    # Only delete ephemeral temp directories
    if ($ScreenDir -like "$env:TEMP*") {
        Remove-Item $ScreenDir -Recurse -Force -ErrorAction SilentlyContinue
    }

    Write-Output '{"status": "stopped"}'
} else {
    Write-Output '{"status": "not_running"}'
}
