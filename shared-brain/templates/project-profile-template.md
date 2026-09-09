---
project_key: <remote-owner>--<repository-name>
repository_name: <repo>
local_root: <normalized absolute repository root>
remote_url: <sanitized remote — no credentials>
default_branch: <branch>
verification_date: YYYY-MM-DD
confidence: high | medium | low
---

# Project Profile — <repository name>

> Verified repository evidence only. Do not infer unsupported architecture. Current source
> overrides this profile; re-verify when manifests change.

## Identity
- **Project key:** <key>
- **Repository name:** <repo>
- **Local root:** <path>
- **Sanitized remote:** <url>
- **Default branch:** <branch>

## Technology stack
- **Languages / frameworks / runtimes (with versions):** <...>
- **Monorepo?** <yes/no; list apps>

## Application modules
- <module — purpose>

## Locations
- **Backend:** <paths>
- **Frontend:** <paths>
- **Tests:** <paths, or "none detected">
- **Configuration:** <paths>
- **Deployment manifests:** <paths>

## Commands (verify before use)
- **Build:** <command(s)>
- **Test:** <command(s), or "no automated test project detected">
- **Lint:** <command(s)>

## Integration boundaries
- <external systems, auth, shared packages>

## Project-specific conventions
- <coding/architecture conventions confirmed from source>

## Evidence
- <files that establish the above>

## Invalidation conditions
- <manifest/framework/host changes that would require re-verification>
