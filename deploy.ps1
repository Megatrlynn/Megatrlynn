# deploy.ps1 - Automated Deployment Script for Megatrlynn GitHub Profile README
param (
    [string]$CommitMessage = "feat: launch futuristic cyber welcome profile README & telemetry"
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 🚀 MEGATRLYNN GITHUB PROFILE DEPLOYMENT ASSISTANT" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan

# Check if git is available
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed or not in PATH."
    exit 1
}

# Initialize repository if needed
if (-not (Test-Path ".git")) {
    Write-Host "[+] Initializing new Git repository..." -ForegroundColor Yellow
    git init -b main
} else {
    Write-Host "[+] Existing git repository found." -ForegroundColor Yellow
}

# Ensure the branch is explicitly named 'main'
git branch -M main

# Ensure remote origin is configured
$remoteUrl = "https://github.com/Megatrlynn/Megatrlynn.git"
$existingOrigin = git remote get-url origin 2>$null
if (-not $existingOrigin) {
    Write-Host "[+] Setting remote origin to $remoteUrl..." -ForegroundColor Yellow
    git remote add origin $remoteUrl
} elseif ($existingOrigin -ne $remoteUrl) {
    Write-Host "[+] Updating remote origin to $remoteUrl..." -ForegroundColor Yellow
    git remote set-url origin $remoteUrl
}

# Stage all files
Write-Host "[+] Staging files (README.md, .github/workflows, assets)..." -ForegroundColor Yellow
git add .

# Commit changes if there are staged changes
$status = git status --porcelain
if ($status) {
    Write-Host "[+] Committing changes..." -ForegroundColor Yellow
    git commit -m "$CommitMessage"
} else {
    Write-Host "[+] Working tree clean, nothing new to commit." -ForegroundColor Green
}

# Push instructions
Write-Host ""
Write-Host "Current branch: main -> Origin: $remoteUrl" -ForegroundColor Cyan
Write-Host "Ready to push. Attempting push to origin main..." -ForegroundColor Green

git push -u origin main
