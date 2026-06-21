param(
  [Parameter(Mandatory=$true)][string]$Namespace,
  [Parameter(Mandatory=$true)][string]$Folder,
  [Parameter(Mandatory=$true)][string]$Target,
  [int]$MaxWaitSeconds = 60
)

$ErrorActionPreference = "Stop"

function Write-Step($msg) {
  Write-Host "== $msg =="
}

$DfsPath = Join-Path $Namespace $Folder

Write-Step "Ensuring DFS folder $DfsPath"
try {
  $existingFolder = Get-DfsnFolder -Path $DfsPath -ErrorAction Stop
} catch {
  New-DfsnFolder -Path $DfsPath -TargetPath $Target | Out-Null
  $existingFolder = Get-DfsnFolder -Path $DfsPath
}

Write-Step "Ensuring target $Target"
$targets = @(Get-DfsnFolderTarget -Path $DfsPath -ErrorAction SilentlyContinue)
$found = $targets | Where-Object { $_.TargetPath -ieq $Target }
if (-not $found) {
  New-DfsnFolderTarget -Path $DfsPath -TargetPath $Target | Out-Null
}

Write-Step "Waiting for target visibility"
$deadline = (Get-Date).AddSeconds($MaxWaitSeconds)
do {
  $targets = @(Get-DfsnFolderTarget -Path $DfsPath -ErrorAction SilentlyContinue)
  $found = $targets | Where-Object { $_.TargetPath -ieq $Target }
  if ($found) {
    Write-Host "OK: $DfsPath -> $Target"
    exit 0
  }
  Start-Sleep -Seconds 2
} while ((Get-Date) -lt $deadline)

throw "Target was not visible before timeout: $Target"
