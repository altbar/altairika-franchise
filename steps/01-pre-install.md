# Шаг 1. Pre-install: VPN, Git, проверка сети

Без этого Claude Code в России не запустится. Этот шаг обязательный — если зависнешь на нём, все следующие шаги не пройдут.

## VPN — обязательно

Claude Code обращается к двум доменам:
- `claude.ai` — авторизация и логин
- `api.anthropic.com` — все API-вызовы

Оба заблокированы в РФ. Без VPN команды Claude будут молча висеть до таймаута.

**Что подходит:** любой VPN, который маршрутизирует трафик через не-РФ IP. Из проверенных: Outline, AmneziaVPN, коммерческие OpenVPN/WireGuard.

**Что НЕ подходит:** браузерные расширения (Browsec, ZenMate) — они работают только в браузере, Claude Code их не видит.

> Если у тебя пока нет VPN — напиши Константину (TG @altbar), скоординируем. Без VPN дальше не идти.

## Проверка VPN и доступа

После включения VPN:

### Mac

```bash
nc -zv -w 5 claude.ai 443
nc -zv -w 5 api.anthropic.com 443
```

### Windows (PowerShell)

```powershell
Test-NetConnection claude.ai -Port 443 -InformationLevel Quick
Test-NetConnection api.anthropic.com -Port 443 -InformationLevel Quick
```

Оба должны вернуть `succeeded` / `True`. Если `False` или висит >30 секунд — VPN не маршрутизирует трафик к этим доменам, нужно решать с провайдером VPN.

## Git for Windows (только Windows)

Claude Code на Windows требует `bash.exe` для внутренних операций. Без Git for Windows установщик молча отвалится, напечатав "Successful".

1. Скачай **64-bit Git for Windows Setup**: https://git-scm.com/downloads/win
2. Запусти инсталлер
3. На странице **"Adjusting your PATH environment"** — оставь **средний пункт** (по умолчанию): "Git from the command line and also from 3rd-party software"
4. Все остальные страницы — Next с дефолтами
5. После установки **закрой все окна терминалов**, открой PowerShell заново
6. Проверь:
   ```powershell
   git --version
   ```
   Должен ответить версией. Если "не найден" — переустанови с правильной галочкой PATH.

## Mac — Homebrew (опционально, но удобно)

Если планируешь ставить Wispr Flow / Chromium / Obsidian через `brew` — поставь Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

После установки следуй инструкциям в выводе — обычно нужно добавить brew в PATH.

## Что дальше

Шаг 2 — установка Claude Code.
