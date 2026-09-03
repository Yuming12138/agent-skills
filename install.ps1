[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Destination,

    [string[]]$Skill
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'skills')).Path
$allowedSkills = @('powershell-command-safety', 'ui-craft', 'ui-ux-pro-max', 'web-design-guidelines')
$selectedSkills = if ($Skill -and $Skill.Count -gt 0) {
    # Accept both -Skill ui-craft,ui-ux-pro-max and a native argument array.
    $requestedSkills = @($Skill | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    $invalidSkills = @($requestedSkills | Where-Object { $_ -notin $allowedSkills })
    if ($invalidSkills.Count -gt 0) {
        throw "Unknown skill name(s): $($invalidSkills -join ', '). Allowed names: $($allowedSkills -join ', ')"
    }
    $requestedSkills
} else {
    @('powershell-command-safety', 'ui-craft', 'ui-ux-pro-max', 'web-design-guidelines')
}

if (-not (Test-Path -LiteralPath $Destination)) {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
}
$destinationRoot = (Resolve-Path -LiteralPath $Destination).Path

foreach ($skillName in $selectedSkills) {
    $sourcePath = Join-Path $repoRoot $skillName
    $targetPath = Join-Path $destinationRoot $skillName
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Container)) {
        throw "Skill source not found: $sourcePath"
    }
    if (Test-Path -LiteralPath $targetPath) {
        Write-Verbose "Updating existing skill: $targetPath"
    }
    Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Recurse -Force
    Write-Output "Installed $skillName -> $targetPath"
}
