<#
.SYNOPSIS
  Installs this Development Orchestrator template into your local ~/.copilot/ setup.

.DESCRIPTION
  Copies agents/, skills/, and prompts/ from this repo into $env:USERPROFILE\.copilot\.
  Creates project-memory/ and shared-brain/ under $env:USERPROFILE\.copilot\ ONLY if they
  don't already exist there — this script never overwrites your existing personal data
  (registered projects, real Shared Brain entries, custom skills/agents you've already added).

  Use -Force to overwrite existing agents/skills/prompts files that came from this template
  (still never touches project-memory/ or shared-brain/ once they exist).

.PARAMETER Force
  Overwrite existing agent/skill/prompt files with the versions from this repo.

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

Write-Host "Development Orchestrator template installer" -ForegroundColor Cyan
Write-Host "  Source: $repoRoot"
Write-Host "  Target: $copilotHome"
Write-Host ""

function Copy-TemplateTree {
    param(
        [string]$SourceDir,
        [string]$TargetDir,
        [string]$Label
    )
    if (-not (Test-Path $SourceDir)) { return }
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    Get-ChildItem -Path $SourceDir | ForEach-Object {
        $targetPath = Join-Path $TargetDir $_.Name
        if ((Test-Path $targetPath) -and -not $Force) {
            Write-Host "  skip (exists): $Label/$($_.Name)" -ForegroundColor DarkYellow
            return
        }
        if ($_.PSIsContainer) {
            Copy-Item -Recurse -Force $_.FullName $targetPath
        } else {
            Copy-Item -Force $_.FullName $targetPath
        }
        Write-Host "  installed: $Label/$($_.Name)" -ForegroundColor Green
    }
}

Copy-TemplateTree -SourceDir (Join-Path $repoRoot 'agents')  -TargetDir (Join-Path $copilotHome 'agents')  -Label 'agents'
Copy-TemplateTree -SourceDir (Join-Path $repoRoot 'skills')  -TargetDir (Join-Path $copilotHome 'skills')  -Label 'skills'
Copy-TemplateTree -SourceDir (Join-Path $repoRoot 'prompts') -TargetDir (Join-Path $copilotHome 'prompts') -Label 'prompts'

Write-Host ""
Write-Host "Project Memory and Shared Brain (created only if missing, never overwritten):" -ForegroundColor Cyan

$pmTarget = Join-Path $copilotHome 'project-memory'
if (Test-Path $pmTarget) {
    Write-Host "  skip (exists): project-memory" -ForegroundColor DarkYellow
} else {
    Copy-Item -Recurse -Force (Join-Path $repoRoot 'project-memory') $pmTarget
    Write-Host "  installed: project-memory (empty scaffold)" -ForegroundColor Green
}

$sbTarget = Join-Path $copilotHome 'shared-brain'
if (Test-Path $sbTarget) {
    Write-Host "  skip (exists): shared-brain" -ForegroundColor DarkYellow
} else {
    Copy-Item -Recurse -Force (Join-Path $repoRoot 'shared-brain') $sbTarget
    Write-Host "  installed: shared-brain (starter scaffold)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done. Reload/restart your Copilot agent session to pick up the new agent and skills." -ForegroundColor Cyan
