# Шаг 5. Статусная строка

Что даёт: внизу окна Claude Code появится строка с полезной информацией — текущая папка, git-ветка, время. Маленькое удобство, но дисциплинирует.

## Установка

Открой `~/.claude/settings.json` (Mac) или `%USERPROFILE%\.claude\settings.json` (Windows). Если файла нет — создай.

Если файл пустой:
```json
{
  "statusLine": {
    "type": "command",
    "command": "echo \"$(pwd) | $(date +%H:%M)\""
  }
}
```

Если в файле уже есть `mcpServers` или другие настройки — добавь `statusLine` как соседний ключ:
```json
{
  "mcpServers": { ... },
  "statusLine": {
    "type": "command",
    "command": "echo \"$(pwd) | $(date +%H:%M)\""
  }
}
```

> JSON чувствителен к запятым. Если ставишь второй ключ — поставь запятую после `}` предыдущего блока. Если редактор подсветил красным — перепроверь скобки и запятые.

Перезапусти Claude (выйди из CLI, запусти `claude` снова). Внизу окна появится строка типа:
```
/Users/asus/Documents | 14:25
```

## Расширенный вариант с git-веткой

Если работаешь в папках с git-репозиториями:

```json
{
  "statusLine": {
    "type": "command",
    "command": "echo \"$(pwd) | $(git branch --show-current 2>/dev/null || echo no-git) | $(date +%H:%M)\""
  }
}
```

Покажет: `/Users/asus/altairika-franchise | main | 14:25`

## Windows-вариант

В Windows другой синтаксис shell. Если у тебя установлен Git for Windows (Шаг 1) — используй bash-команду как на Mac:

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash -c \"echo \\\"$(pwd) | $(date +%H:%M)\\\"\""
  }
}
```

Или нативно через PowerShell:
```json
{
  "statusLine": {
    "type": "command",
    "command": "powershell -Command \"Write-Host '$($PWD.Path) | ' -NoNewline; Get-Date -Format 'HH:mm'\""
  }
}
```

## Что дальше

Шаг 6 — Wispr Flow (голосовой ввод).
