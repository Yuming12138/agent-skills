[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Destination,

    [ValidateSet('powershell-command-safety', 'ui-craft', 'ui-ux-pro-max', 'web-design-guidelines')]
    [string[]]$Skill
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'skills')).Path
$selectedSkills = if ($Skill -and $Skill.Count -gt 0) {
    @($Skill)
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
