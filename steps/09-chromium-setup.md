# Шаг 9. Chromium для браузерных MCP

Что даёт: отдельный браузер Chromium с remote-debugging портом, который Claude использует для работы с веб-сервисами (Google Workspace, парсинг страниц, просмотр сайтов). Не headless — это полноценное окно браузера, в которое ты сама заходишь и логинишься в нужные сервисы. Сессии и cookie сохраняются между запусками.

## Зачем не headless

Headless-браузеры (без окна) блокируются многими сервисами: Google требует интерактивного логина, Ozon и Маркет банят headless по фингерпринту, OAuth-флоу в headless ломается. Полноценный Chromium с твоим профилем — единственный надёжный способ.

## Установка

### Mac

```bash
brew install --cask chromium
```

Если Brew не установлен:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Windows

1. Скачай ungoogled-chromium с https://chromium.woolyss.com/ (вариант "Hibbiki" или "Marmaduke" — оба ок)
2. Запусти инсталлер, поставь по умолчанию

(Альтернатива: использовать обычный Google Chrome — пропусти этот шаг и в Шаге 10 запускай `chrome.exe` вместо `chromium.exe`. Но тогда твой основной браузер будет занят debug-портом — не очень удобно.)

## Запуск Chromium с debug-портом

Создай скрипт-запускалку, чтобы не вводить команды каждый раз.

### Mac

Создай файл `~/bin/start-chromium.sh`:
```bash
#!/bin/bash
/Applications/Chromium.app/Contents/MacOS/Chromium \
  --remote-debugging-port=9222 \
  --user-data-dir=$HOME/.chromium-claude \
  --no-first-run \
  --no-default-browser-check \
  --disable-default-apps \
  'about:blank' &>/dev/null &
echo "Chromium запущен на порту 9222"
```

Сделай исполняемым:
```bash
mkdir -p ~/bin
chmod +x ~/bin/start-chromium.sh
```

Запуск: `~/bin/start-chromium.sh`

### Windows

Создай файл `%USERPROFILE%\start-chromium.ps1`:
```powershell
$chromiumPath = "$env:LOCALAPPDATA\Chromium\Application\chrome.exe"
# Или путь, куда установился ungoogled-chromium
& $chromiumPath `
  --remote-debugging-port=9222 `
  --user-data-dir="$env:USERPROFILE\.chromium-claude" `
  --no-first-run `
  --no-default-browser-check `
  --disable-default-apps `
  about:blank
```

Запуск: правый клик по `start-chromium.ps1` → Run with PowerShell.

## Проверка

После запуска:
1. Открылось окно Chromium с пустой страницей
2. В терминале:
   ```bash
   curl -s http://127.0.0.1:9222/json/version
   ```
   Должен ответить JSON с версией Chrome.

Если ответил — порт работает, можно идти дальше.

## Подключение к Claude

В `~/.claude/settings.json` добавь в `mcpServers`:

```json
{
  "mcpServers": {
    "chrome-browser": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp", "--browserUrl", "http://127.0.0.1:9222"]
    }
  }
}
```

(имя пакета может отличаться — уточню в следующей итерации)

Перезапусти Claude.

## Использование

- **Перед запуском Claude** — запусти Chromium через скрипт. Иначе MCP не подключится.
- В Chromium залогинься в нужные сервисы (Google, Yandex, etc.) — сессии сохранятся в `~/.chromium-claude` и будут жить между перезапусками
- Не закрывай окно Chromium пока Claude с ним работает — закроешь, MCP потеряет соединение

## Что дальше

Шаг 10 — Google Workspace MCP, использует этот Chromium для авторизации.
