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
    git remote add origin https://github.com/Megatrlynn/Megatrlynn.git
} else {
    Write-Host "[+] Existing git repository found." -ForegroundColor Yellow
}

# Stage all files
Write-Host "[+] Staging files (README.md, .github/workflows)..." -ForegroundColor Yellow
git add .

# Commit changes
Write-Host "[+] Committing changes..." -ForegroundColor Yellow
git commit -m "$CommitMessage"

# Push instructions
Write-Host ""
Write-Host "To push your changes to GitHub, execute:" -ForegroundColor Green
Write-Host "  git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "Would you like to attempt pushing to origin main right now? (y/n)" -ForegroundColor Cyan
$response = Read-Host
if ($response -eq 'y' -or $response -eq 'Y') {
    git push -u origin main
}

