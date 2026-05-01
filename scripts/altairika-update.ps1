# Altairika Franchise Kit — update script (Windows)

$ErrorActionPreference = "Stop"

$InstallDir = Join-Path $env:USERPROFILE "altairika-franchise"
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$TemplateMd = Join-Path $InstallDir "templates\CLAUDE.md"
$UserMd = Join-Path $ClaudeDir "CLAUDE.md"

if (-not (Test-Path (Join-Path $InstallDir ".git"))) {
    Write-Host "ОШИБКА: $InstallDir не git-репо. Запусти install.ps1 заново." -ForegroundColor Red
    exit 1
}

Push-Location $InstallDir
Write-Host "Обновляю репо..."
$before = git rev-parse HEAD
git pull --ff-only
$after = git rev-parse HEAD
Pop-Location

if ($before -eq $after) {
    Write-Host "Уже актуально. Ничего нового." -ForegroundColor Green
    exit 0
}

Write-Host ""
Write-Host "Изменения с прошлой версии:" -ForegroundColor Cyan
Push-Location $InstallDir
git log --oneline "$before..$after"
Pop-Location
Write-Host ""

# Check CLAUDE.md template change
if (Test-Path $UserMd) {
    $diff = Compare-Object (Get-Content $UserMd) (Get-Content $TemplateMd) -ErrorAction SilentlyContinue
    if ($diff) {
        Write-Host "⚠ Шаблон CLAUDE.md изменился, но твой $UserMd отличается от шаблона." -ForegroundColor Yellow
        Write-Host "  (вероятно, ты редактировал секцию 'Кто я' — это нормально)"
        Write-Host ""
        Write-Host "Что делать:"
        Write-Host "  1. Посмотри различия:"
        Write-Host "     Compare-Object (Get-Content '$UserMd') (Get-Content '$TemplateMd')"
        Write-Host "  2. Если хочешь заменить (потеряв правки):"
        $stamp = "yyyyMMdd-HHmmss"
        Write-Host "     Copy-Item '$UserMd' '$UserMd.backup-`$(Get-Date -Format $stamp)'"
        Write-Host "     Copy-Item '$TemplateMd' '$UserMd' -Force"
    }
}

Write-Host ""
Write-Host "Обновление завершено." -ForegroundColor Green
Write-Host "Новые шаги/файлы — в $InstallDir\steps\"
