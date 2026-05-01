# Altairika Franchise Claude Code Kit — Windows installer
# Usage: irm https://raw.githubusercontent.com/altbar/altairika-franchise/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$RepoUrl = "https://github.com/altbar/altairika-franchise.git"
$InstallDir = Join-Path $env:USERPROFILE "altairika-franchise"
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$BinDir = Join-Path $env:USERPROFILE "bin"

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "  Altairika Franchise - Claude Code Kit" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# Check git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "ОШИБКА: git не найден." -ForegroundColor Red
    Write-Host "Поставь Git for Windows: https://git-scm.com/downloads/win"
    Write-Host "На странице 'Adjusting your PATH environment' — оставь средний пункт (default)."
    exit 1
}

# Check claude
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "ВНИМАНИЕ: команда 'claude' не найдена в PATH." -ForegroundColor Yellow
    Write-Host "Сначала пройди шаги 1-3 (см. репо), потом запусти install.ps1 снова."
    $answer = Read-Host "Продолжить установку кита всё равно? [y/N]"
    if ($answer -ne "y" -and $answer -ne "Y") { exit 1 }
}

# Clone or update repo
if (Test-Path (Join-Path $InstallDir ".git")) {
    Write-Host "Репо уже существует в $InstallDir — обновляю..."
    Push-Location $InstallDir
    git pull --ff-only
    Pop-Location
} else {
    Write-Host "Клонирую репо в $InstallDir..."
    git clone $RepoUrl $InstallDir
}

# Ensure .claude exists
New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null

# Backup existing CLAUDE.md
$ClaudeMd = Join-Path $ClaudeDir "CLAUDE.md"
if (Test-Path $ClaudeMd) {
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backup = "$ClaudeMd.backup-$stamp"
    Copy-Item $ClaudeMd $backup
    Write-Host "Существующий CLAUDE.md сохранён: $backup"
}

# Copy CLAUDE.md
Copy-Item (Join-Path $InstallDir "templates\CLAUDE.md") $ClaudeMd -Force
Write-Host "Установлен: $ClaudeMd"

# Copy skills
$SkillsDir = Join-Path $ClaudeDir "skills"
New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
$srcSkills = Join-Path $InstallDir "skills"
$skillsCount = 0
if (Test-Path $srcSkills) {
    Get-ChildItem -Path $srcSkills -Filter "*.md" | ForEach-Object {
        Copy-Item $_.FullName $SkillsDir -Force
        $skillsCount++
    }
}
Write-Host "Установлено скиллов: $skillsCount (в $SkillsDir\)"

# Create altairika-update.cmd shim
New-Item -ItemType Directory -Path $BinDir -Force | Out-Null
$UpdateBat = Join-Path $BinDir "altairika-update.cmd"
$UpdateScript = Join-Path $InstallDir "scripts\altairika-update.ps1"
@"
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "$UpdateScript" %*
"@ | Out-File -FilePath $UpdateBat -Encoding ASCII -Force
Write-Host "Команда altairika-update -> $UpdateBat"

# Add ~/bin to User PATH if not there
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$BinDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$BinDir", "User")
    $env:Path += ";$BinDir"
    Write-Host "Добавил $BinDir в User PATH"
    Write-Host "Перезапусти PowerShell чтобы 'altairika-update' заработал в новых сессиях"
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "  Установка завершена." -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Что дальше:"
Write-Host "  1. Открой $ClaudeMd и поправь секцию 'Кто я' под себя"
Write-Host "     notepad $ClaudeMd"
Write-Host "  2. Запусти 'claude' — напиши 'прочитай мой CLAUDE.md'"
Write-Host "  3. Иди по шагам: $InstallDir\steps\"
Write-Host "  4. Для обновлений: altairika-update"
Write-Host ""
