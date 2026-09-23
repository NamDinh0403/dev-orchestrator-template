<#
.SYNOPSIS
  Installs this Development Orchestrator template into your local ~/.copilot/ setup.

.DESCRIPTION
  Installs or updates template agents/, skills/, prompts/, and the workflow policies and
  templates in shared-brain/. Existing files at those template paths are backed up before
  replacement. Custom files alongside them, Shared Brain knowledge, and existing
  project-memory/ are never overwritten.

  Removes retired skills only when their SKILL.md exactly matches a previously shipped
  template version and the skill directory contains no other files.

.PARAMETER Force
  Accepted for compatibility with older installer commands; updates are now the default.

.EXAMPLE
  .\install.ps1
  .\install.ps1 -Force
#>
[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$repoRoot = $PSScriptRoot
$copilotHome = Join-Path $env:USERPROFILE '.copilot'
$backupRoot = Join-Path $copilotHome ("template-backups\{0}-{1}" -f (Get-Date -Format 'yyyyMMdd-HHmmss'), [guid]::NewGuid().ToString('N').Substring(0, 8))

Write-Host "Development Orchestrator template installer" -ForegroundColor Cyan
Write-Host "  Source: $repoRoot"
Write-Host "  Target: $copilotHome"
Write-Host ""

function Copy-TemplateFiles {
    param(
        [string]$SourceDir,
        [string]$TargetDir,
        [string]$Label
    )
    Get-ChildItem -LiteralPath $SourceDir -Recurse -File | ForEach-Object {
        $relativePath = $_.FullName.Substring($SourceDir.Length).TrimStart('\')
        $targetPath = Join-Path $TargetDir $relativePath
        if (Test-Path -LiteralPath $targetPath) {
            if ((Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash -eq
                (Get-FileHash -LiteralPath $targetPath -Algorithm SHA256).Hash) {
                Write-Host "  unchanged: $Label/$relativePath"
                return
            }
            $backupPath = Join-Path $backupRoot (Join-Path $Label $relativePath)
            New-Item -ItemType Directory -Force -Path (Split-Path -Parent $backupPath) | Out-Null
            Copy-Item -LiteralPath $targetPath -Destination $backupPath
        }
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $targetPath) | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $targetPath -Force
        Write-Host "  installed: $Label/$($relativePath.Replace('\', '/'))" -ForegroundColor Green
    }
}

Copy-TemplateFiles -SourceDir (Join-Path $repoRoot 'agents')  -TargetDir (Join-Path $copilotHome 'agents')  -Label 'agents'
Copy-TemplateFiles -SourceDir (Join-Path $repoRoot 'skills')  -TargetDir (Join-Path $copilotHome 'skills')  -Label 'skills'
Copy-TemplateFiles -SourceDir (Join-Path $repoRoot 'prompts') -TargetDir (Join-Path $copilotHome 'prompts') -Label 'prompts'

# Only remove the four skills replaced by investigate-issue and implement-card when
# their content is an exact match for a published template version.
$retiredSkills = @{
    'code-investigation' = @(
        'be853e28c7962bb8ccabe82e05bfbc322a6153ca3c68cb7c1351984a331f0f76'
        '19b061cddf06e081b348a8d077c2a48efbbc12f4283f73c6b4ee04e5e9dd36f3'
        '7219bd1b5b101da7eddfd268b54de24c4f34595cb9202c51181845a07f317d37'
    )
    'diff-review' = @('932a6b7802a1b9a7653c35efa2c7f4c3a50e8078c560a67c07a1e1e484b3cba5')
    'implementation-planning' = @('9f2acb6fd68d5e73ed9678e47f7fa82b243c5c2bf41fa15e00717642cfc8318d')
    'targeted-validation' = @('d6e9aee7c05ba7a93081d5fb93631e140b1dd5131e5658eccca456b2fe32c8df')
}
foreach ($skillName in $retiredSkills.Keys) {
    $skillDir = Join-Path (Join-Path $copilotHome 'skills') $skillName
    if (-not (Test-Path -LiteralPath $skillDir)) { continue }
    $skillFile = Join-Path $skillDir 'SKILL.md'
    $entries = @(Get-ChildItem -LiteralPath $skillDir -Force)
    if ($entries.Count -ne 1 -or $entries[0].Name -ne 'SKILL.md' -or
        -not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
        Write-Warning "Retired skill skills/$skillName was customized; remove it manually if no longer needed."
        continue
    }
    $text = [IO.File]::ReadAllText($skillFile).Replace("`r`n", "`n")
    $sha256 = [Security.Cryptography.SHA256]::Create()
    try {
        $hash = ([BitConverter]::ToString($sha256.ComputeHash([Text.Encoding]::UTF8.GetBytes($text)))).Replace('-', '').ToLowerInvariant()
    } finally {
        $sha256.Dispose()
    }
    if ($hash -notin $retiredSkills[$skillName]) {
        Write-Warning "Retired skill skills/$skillName was customized; remove it manually if no longer needed."
        continue
    }
    Remove-Item -LiteralPath $skillFile
    Remove-Item -LiteralPath $skillDir
    Write-Host "  retired: skills/$skillName" -ForegroundColor Green
}

Write-Host ""
Write-Host "Project Memory (preserved) and Shared Brain (knowledge preserved; policies/templates updated):" -ForegroundColor Cyan

$pmTarget = Join-Path $copilotHome 'project-memory'
if (Test-Path $pmTarget) {
    Write-Host "  skip (exists): project-memory" -ForegroundColor DarkYellow
} else {
    Copy-Item -Recurse -Force (Join-Path $repoRoot 'project-memory') $pmTarget
    Write-Host "  installed: project-memory (empty scaffold)" -ForegroundColor Green
}

$sbTarget = Join-Path $copilotHome 'shared-brain'
if (-not (Test-Path -LiteralPath $sbTarget)) {
    Copy-Item -Recurse -Force (Join-Path $repoRoot 'shared-brain') $sbTarget
    Write-Host "  installed: shared-brain (starter scaffold)" -ForegroundColor Green
} else {
    Write-Host "  preserving: shared-brain knowledge and index"
    foreach ($section in @('workflows', 'templates')) {
        Copy-TemplateFiles -SourceDir (Join-Path (Join-Path $repoRoot 'shared-brain') $section) `
            -TargetDir (Join-Path $sbTarget $section) -Label "shared-brain\$section"
    }
}

Write-Host ""
if (Test-Path -LiteralPath $backupRoot) {
    Write-Host "Updated files backed up to: $backupRoot" -ForegroundColor Cyan
}
Write-Host "Done. Reload/restart your Copilot agent session to pick up the new agent and skills." -ForegroundColor Cyan
