# Altairika Franchise — Claude Code Kit

Стартовый кит для франчайзи Altairika: пошаговая настройка Claude Code с фирменным контекстом, тоном бренда, MCP-инструментами и шаблонами под типичные задачи.

## Как пользоваться китом

Иди по шагам по порядку. Каждый шаг — отдельный файл с инструкцией. Не перепрыгивай — следующие шаги опираются на предыдущие.

## Шаги онбординга

| № | Шаг | Файл | Статус |
|---|-----|------|--------|
| 1 | Pre-install: VPN, Git for Windows | `steps/01-pre-install.md` | ⏳ скоро |
| 2 | Установка Claude Code (Mac/Windows) | `steps/02-install-claude.md` | ⏳ скоро |
| 3 | Авторизация Claude (подписка) | `steps/03-auth.md` | ⏳ скоро |
| 4 | Личный CLAUDE.md (бренд + идентичность) | `templates/CLAUDE.md` | ✅ готов |
| 5 | Статусная строка | `steps/05-status-line.md` | ⏳ скоро |
| 6 | Wispr Flow — голосовой ввод | `steps/06-wispr-flow.md` | ⏳ скоро |
| 7 | **Telegram MCP** | `steps/07-telegram-mcp.md` | ✅ готов |
| 8 | **Figma MCP** (доступ к промо-материалам) | `steps/08-figma-mcp.md` | ✅ готов |
| 9 | **Chromium с debug-портом** | `steps/09-chromium-setup.md` | ✅ готов |
| 10 | **Google Workspace MCP** (через Chromium) | `steps/10-google-mcp.md` | ✅ готов |
| 11 | **Exa MCP** — web search | `steps/11-exa-mcp.md` | ✅ готов |
| 12 | Cmux/tmux session restore (Mac, опционально) | `steps/12-cmux-restore.md` | ⏳ скоро |

> Пока шаги 1-3, 5-6 не готовы — отдельные инструкции по установке Claude Code и Wispr Flow есть прямо внутри `templates/CLAUDE.md` (раздел "Технические заметки"). Начни оттуда, потом возвращайся к остальным шагам.

## Быстрый старт

1. Установи Claude Code на свою ОС (см. секцию в `templates/CLAUDE.md` или подожди шаги 1-3)
2. Скачай `templates/CLAUDE.md` сырым файлом:
   - Mac: `curl -fsSL https://raw.githubusercontent.com/altbar/altairika-franchise/main/templates/CLAUDE.md -o ~/.claude/CLAUDE.md`
   - Windows PowerShell: `iwr https://raw.githubusercontent.com/altbar/altairika-franchise/main/templates/CLAUDE.md -OutFile $env:USERPROFILE\.claude\CLAUDE.md`
3. Открой этот файл, поправь секцию "Кто я" под себя
4. Запусти `claude`, напиши "прочитай мой CLAUDE.md, расскажи кратко что обо мне знаешь" — проверь что подхватилось
5. Иди по шагам 7-11 чтобы подключить MCP-инструменты (Telegram, Figma, Chromium+Google, Exa)

## Доступ к корпоративным ресурсам

После установки попроси у УК (TG @altbar) доступ к:
- **Figma пространству Altairika** — пришли свой email из Figma
- **Vault'у с инструкциями для франчайзи** (если есть/появится) — пришли GitHub username
- **Telegram-каналу для франчайзи** — пришли свой @username

## Поддержка

- Что-то не работает: TG @altbar или почта k.urvantcev@gmail.com со скриншотом
- Идея для нового скилла: создай Issue в этом репо
- Хочешь поделиться промптом, который тебе зашёл: PR в `prompts/`

## Roadmap

- [x] CLAUDE.md template
- [x] Telegram MCP step
- [x] Figma MCP step
- [x] Chromium setup step
- [x] Google Workspace MCP step
- [x] Exa MCP step
- [ ] Pre-install / Install / Auth steps (1-3) — вынести из CLAUDE.md в отдельные файлы
- [ ] Status-line / Wispr Flow steps (5-6) — то же
- [ ] Cmux step (12, Mac only)
- [ ] `install.sh` / `install.ps1` — автоматическая раскатка кита
- [ ] `altairika-update` — скрипт обновления
- [ ] Skills: post-writer, parent-reply, school-script, birthday-script, review-response
- [ ] Prompt templates (5-7 готовых)
