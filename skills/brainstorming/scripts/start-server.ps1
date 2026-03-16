# Start the brainstorm server and output connection info (PowerShell version)
# Usage: start-server.ps1 [-ProjectDir <path>] [-Host <bind-host>] [-UrlHost <display-host>] [-Foreground]

param(
    [string]$ProjectDir = "",
    [string]$BindHost = "127.0.0.1",
    [string]$UrlHost = "",
    [switch]$Foreground,
    [switch]$Background
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ([string]::IsNullOrEmpty($UrlHost)) {
    if ($BindHost -eq "127.0.0.1" -or $BindHost -eq "localhost") {
        $UrlHost = "localhost"
    } else {
        $UrlHost = $BindHost
    }
}

# Generate unique session directory
$SessionId = "$PID-$([DateTimeOffset]::UtcNow.ToUnixTimeSeconds())"

if (-not [string]::IsNullOrEmpty($ProjectDir)) {
    $ScreenDir = Join-Path $ProjectDir ".superpowers" "brainstorm" $SessionId
} else {
    $ScreenDir = Join-Path $env:TEMP "brainstorm-$SessionId"
}

$PidFile = Join-Path $ScreenDir ".server.pid"
$LogFile = Join-Path $ScreenDir ".server.log"

# Create fresh session directory
New-Item -ItemType Directory -Path $ScreenDir -Force | Out-Null

# Kill any existing server
if (Test-Path $PidFile) {
    $oldPid = Get-Content $PidFile
    try { Stop-Process -Id $oldPid -Force -ErrorAction SilentlyContinue } catch {}
    Remove-Item $PidFile -Force
}

Set-Location $ScriptDir

# Get owner PID (parent of parent)
$OwnerPid = $PID
try {
    $parentProcess = Get-Process -Id $PID
    if ($parentProcess.Parent) {
        $OwnerPid = $parentProcess.Parent.Id
    }
} catch {}

$env:BRAINSTORM_DIR = $ScreenDir
$env:BRAINSTORM_HOST = $BindHost
$env:BRAINSTORM_URL_HOST = $UrlHost
$env:BRAINSTORM_OWNER_PID = $OwnerPid

if ($Foreground) {
    Set-Content -Path $PidFile -Value $PID
    & node server.js
    exit $LASTEXITCODE
}

# Background mode
$process = Start-Process -FilePath "node" -ArgumentList "server.js" `
    -RedirectStandardOutput $LogFile -RedirectStandardError "$LogFile.err" `
    -PassThru -NoNewWindow

Set-Content -Path $PidFile -Value $process.Id

# Wait for server-started message
for ($i = 0; $i -lt 50; $i++) {
    Start-Sleep -Milliseconds 100
    if (Test-Path $LogFile) {
        $content = Get-Content $LogFile -Raw -ErrorAction SilentlyContinue
        if ($content -match "server-started") {
            # Verify server is still alive
            $alive = $true
            for ($j = 0; $j -lt 20; $j++) {
                try {
                    Get-Process -Id $process.Id -ErrorAction Stop | Out-Null
                } catch {
                    $alive = $false
                    break
                }
                Start-Sleep -Milliseconds 100
            }
            if (-not $alive) {
                Write-Output '{"error": "Server started but was killed. Retry with -Foreground flag."}'
                exit 1
            }
            ($content -split "`n" | Select-String "server-started" | Select-Object -First 1).Line
            exit 0
        }
    }
}

Write-Output '{"error": "Server failed to start within 5 seconds"}'
exit 1
