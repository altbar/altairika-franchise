# Шаг 2. Установка Claude Code

> **Прежде чем начать:** убедись что Шаг 1 пройден — VPN включён, на Windows установлен Git for Windows.

## Mac

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Скрипт скачает ~250 МБ, установит Claude Code в `~/.local/bin/`. Дождись "Successful".

Закрой терминал, открой новый, проверь:
```bash
claude --version
```

Должен напечатать что-то вроде `2.1.x (Claude Code)`. Если команда не найдена — добавь в PATH:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Windows

Открой обычный PowerShell (не cmd, не админ).

### Шаг 1 — TLS 1.2 и установщик

Запускай **по одной строке**, не как многострочный блок (PowerShell 5.1 ломается на копипасте многострочников):

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

```powershell
irm https://claude.ai/install.ps1 | iex
```

Если PowerShell блокирует скрипт:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```
И повтори `irm`.

Установщик скачает ~250 МБ, положит `claude.exe` в `%USERPROFILE%\.local\bin\`. Жди "Successful" — может занять 30-60 секунд.

### Шаг 2 — проверка полным путём

Не доверяй `claude --version` сразу — PATH в текущей сессии может не подхватиться. Сначала проверь полным путём:

```powershell
& "$env:USERPROFILE\.local\bin\claude.exe" --version
```

Должен ответить версией. Если ответил — установка ОК, теперь чиним PATH.

### Шаг 3 — добавь в PATH постоянно

Одной строкой (не многострочным if/else):

```powershell
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path","User") + ";$env:USERPROFILE\.local\bin", "User")
```

Никакого вывода не будет — это нормально. Проверь:
```powershell
[Environment]::GetEnvironmentVariable("Path","User")
```
В конце вывода должно быть `...;C:\Users\<твоё-имя>\.local\bin`.

### Шаг 4 — подхвати в текущей сессии

```powershell
$env:Path += ";$env:USERPROFILE\.local\bin"
claude --version
```

Должен ответить версией. Если да — готово.

## Если установщик молча висит >60 секунд

Это значит, что TCP проходит, но TLS режется (типичная DPI-блокировка):
1. Нажми Ctrl+C
2. Проверь VPN активен: `Test-NetConnection claude.ai -Port 443 -InformationLevel Quick` (должен `True`)
3. Попробуй `curl.exe`:
   ```powershell
   curl.exe -fSL -o install.ps1 https://claude.ai/install.ps1
   .\install.ps1
   ```
4. Если и `curl.exe` висит — VPN не пропускает claude.ai, меняй VPN.

## Если установщик "Successful", а `claude` всё равно не находится

Возможно установился в другое место. Найди:

```powershell
# Windows
Get-ChildItem -Path $env:USERPROFILE -Filter "claude.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
```

```bash
# Mac
find $HOME -name "claude" -type f 2>/dev/null
```

Подкрути PATH под найденный путь.

## Что дальше

Шаг 3 — авторизация.
