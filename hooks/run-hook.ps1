# PowerShell hook runner for Windows native environments
# Usage: run-hook.ps1 <script-name> [args...]
#
# This is the PowerShell equivalent of run-hook.cmd for environments
# where bash is not available.

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ScriptName,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

$HookDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptPath = Join-Path $HookDir $ScriptName

# Try bash first (Git Bash, MSYS2, WSL)
$bashPaths = @(
    "C:\Program Files\Git\bin\bash.exe",
    "C:\Program Files (x86)\Git\bin\bash.exe"
)

foreach ($bashPath in $bashPaths) {
    if (Test-Path $bashPath) {
        & $bashPath $ScriptPath @Args
        exit $LASTEXITCODE
    }
}

# Try bash on PATH
$bashOnPath = Get-Command bash -ErrorAction SilentlyContinue
if ($bashOnPath) {
    & bash $ScriptPath @Args
    exit $LASTEXITCODE
}

# No bash found — try PowerShell equivalent if it exists
$psScript = "$ScriptPath.ps1"
if (Test-Path $psScript) {
    & $psScript @Args
    exit $LASTEXITCODE
}

# No runner available — exit silently
exit 0
