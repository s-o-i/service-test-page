# One-time: GitHub Pages for this folder (run in PowerShell from this directory)
param(
  [string]$RepoName = "service-test-page"
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Write-Host "Install GitHub CLI: https://cli.github.com/"
  exit 1
}

$auth = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
  Write-Host "Log in first:"
  Write-Host "  gh auth login -h github.com -p https -w"
  exit 1
}

if (-not (Test-Path .git)) {
  git init -b main
  git add index.html .gitignore README.md
  git commit -m "Add GitHub Pages test page"
}

$remotes = git remote 2>$null
if ($remotes -notcontains "origin") {
  gh repo create $RepoName --public --source=. --remote=origin --push
} else {
  git push -u origin main
}

$owner = gh api user -q .login
Write-Host "Enabling GitHub Pages on main / ..."
gh api -X POST "repos/$owner/$RepoName/pages" `
  -f build_type=legacy `
  -f "source[branch]=main" `
  -f "source[path]=/" 2>$null
if ($LASTEXITCODE -ne 0) {
  gh api -X PUT "repos/$owner/$RepoName/pages" `
    -f build_type=legacy `
    -f "source[branch]=main" `
    -f "source[path]=/"
}

Start-Sleep -Seconds 3
$url = gh api "repos/$owner/$RepoName/pages" -q .html_url 2>$null
Write-Host ""
Write-Host "Repo:  https://github.com/$owner/$RepoName"
if ($url) { Write-Host "Site:  $url" }
else { Write-Host "Site:  https://$owner.github.io/$RepoName/ (may take 1-2 min)" }
