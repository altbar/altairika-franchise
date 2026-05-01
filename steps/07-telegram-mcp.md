# Шаг 7. Telegram MCP

Что даёт: Claude может читать твои Telegram-чаты, отправлять сообщения, искать по истории, реагировать на сообщения. Полезно для: ответа родителям прямо из Claude, поиска по переписке "что я обещал заказчику в апреле", автоматизации рутинных ответов.

## Что использовать

`telethon-mcp` — MCP-сервер на базе Telethon, работает через **твой личный Telegram-аккаунт** (не бот). 46 инструментов, полный доступ ко всему, что видишь ты в приложении.

> Важно: это работает через твой **личный аккаунт**. Делает всё, что делаешь ты руками. Спам или массовую рассылку Telegram банит — не используй для холодных рассылок.

## Установка

### Шаг 1 — поставь uv (универсальный Python-runtime)

uv — это быстрая замена pip, умеет запускать Python-пакеты без установки в систему. MCP-серверы на Python принято запускать через `uvx`.

**Mac:**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```
После установки **закрой и открой терминал**.

**Windows (PowerShell):**
```powershell
irm https://astral.sh/uv/install.ps1 | iex
```
После установки **закрой и открой PowerShell**.

Проверь:
```bash
uvx --version
```

### Шаг 2 — получи api_id и api_hash

1. Зайди на https://my.telegram.org/auth (через VPN)
2. Введи свой номер телефона, который привязан к Telegram → получи код в Telegram
3. Войди → "API development tools"
4. Заполни форму (App title: `claude-mcp`, short name: `claude_mcp`, platform: Desktop)
5. Скопируй `api_id` (число) и `api_hash` (строка) — сохрани сразу, потом не покажут полностью

### Шаг 3 — сгенерируй SESSION_STRING

Telegram-сессия должна быть закодирована в строку (так MCP не нужно держать session-файл). Делается одноразово через Python-скрипт:

```bash
uvx --from telethon python -c "
from telethon.sync import TelegramClient
from telethon.sessions import StringSession
api_id = int(input('api_id: '))
api_hash = input('api_hash: ')
with TelegramClient(StringSession(), api_id, api_hash) as client:
    print('SESSION_STRING:', client.session.save())
"
```

Введёт api_id, api_hash, попросит код из Telegram (придёт в твой основной аккаунт), потом, возможно, пароль 2FA. В конце напечатает строку — скопируй её, это `TELEGRAM_SESSION_STRING`.

### Шаг 4 — пропиши в Claude config

Открой `~/.claude/settings.json` (Mac) или `%USERPROFILE%\.claude\settings.json` (Windows). Если файла нет — создай. Добавь:

```json
{
  "mcpServers": {
    "telegram": {
      "command": "uvx",
      "args": ["telethon-mcp"],
      "env": {
        "TELEGRAM_API_ID": "12345678",
        "TELEGRAM_API_HASH": "abc123def456...",
        "TELEGRAM_SESSION_STRING": "1AbCd...очень_длинная_строка..."
      }
    }
  }
}
```

Перезапусти Claude (выйди из CLI, запусти `claude` снова).

## Проверка

В Claude:
> Покажи мои последние 5 чатов в Telegram.

или:
> Найди в моих чатах сообщения от руководителя за последний месяц.

Должен ответить с реальными данными.

## Безопасность

- `TELEGRAM_SESSION_STRING` даёт **полный** доступ к твоему Telegram. Не коммить `settings.json` в git если он содержит этот ключ.
- Если потерял ноут — сразу зайди в Telegram → Settings → Devices → терминируй сессию `claude-mcp`. Это инвалидирует SESSION_STRING.
- Не давай Claude задач "массовая рассылка по списку" — Telegram забанит.
- Первая авторизация Telegram (на шаге 3) **должна** идти через твой обычный IP / VPN с твоей географией. Если попробовать с непривычной страны — может прилететь flood-ban на 24 часа.

## Что дальше

Шаг 8 — Figma MCP.
