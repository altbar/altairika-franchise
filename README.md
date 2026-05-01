# Altairika Franchise — Claude Code Kit

Стартовый кит для франчайзи Altairika: пошаговая настройка Claude Code с фирменным контекстом, тоном бренда, MCP-инструментами и шаблонами под типичные задачи.

## Как пользоваться китом

Иди по шагам по порядку. Каждый шаг — отдельный файл с инструкцией. Не перепрыгивай — следующие шаги опираются на предыдущие.

## Шаги онбординга

| № | Шаг | Файл |
|---|-----|------|
| 1 | Pre-install: VPN, Git for Windows, проверка сети | [`steps/01-pre-install.md`](steps/01-pre-install.md) |
| 2 | Установка Claude Code (Mac/Windows) | [`steps/02-install-claude.md`](steps/02-install-claude.md) |
| 3 | Авторизация Claude (подписка) | [`steps/03-auth.md`](steps/03-auth.md) |
| 4 | Личный CLAUDE.md (бренд + идентичность) | [`templates/CLAUDE.md`](templates/CLAUDE.md) |
| 5 | Статусная строка | [`steps/05-status-line.md`](steps/05-status-line.md) |
| 6 | Wispr Flow — голосовой ввод | [`steps/06-wispr-flow.md`](steps/06-wispr-flow.md) |
| 7 | Telegram MCP | [`steps/07-telegram-mcp.md`](steps/07-telegram-mcp.md) |
| 8 | Figma MCP (доступ к промо-материалам Altairika) | [`steps/08-figma-mcp.md`](steps/08-figma-mcp.md) |
| 9 | Chromium с debug-портом | [`steps/09-chromium-setup.md`](steps/09-chromium-setup.md) |
| 10 | Google Workspace через Chromium | [`steps/10-google-mcp.md`](steps/10-google-mcp.md) |
| 11 | Exa MCP — web search | [`steps/11-exa-mcp.md`](steps/11-exa-mcp.md) |
| 12 | Cmux session restore (Mac, опционально) | [`steps/12-cmux-restore.md`](steps/12-cmux-restore.md) |

## Быстрый старт

1. Шаг 1 — VPN и Git for Windows (если Windows)
2. Шаг 2-3 — установи Claude Code и авторизуйся
3. Шаг 4 — скачай `templates/CLAUDE.md` сырым:
   - Mac: `curl -fsSL https://raw.githubusercontent.com/altbar/altairika-franchise/main/templates/CLAUDE.md -o ~/.claude/CLAUDE.md`
   - Windows: `iwr https://raw.githubusercontent.com/altbar/altairika-franchise/main/templates/CLAUDE.md -OutFile $env:USERPROFILE\.claude\CLAUDE.md`
4. Открой этот файл, поправь секцию "Кто я" под себя
5. Запусти `claude`, напиши "прочитай мой CLAUDE.md, расскажи что обо мне знаешь" — проверь что подхватилось
6. Шаги 5-11 — подключи нужные тебе инструменты (минимум: 6 голос, 7 Telegram, 9-10 Chromium+Google, 11 Exa)

## Доступ к корпоративным ресурсам

После установки попроси у УК (TG @altbar) доступ к:
- **Figma пространству Altairika** — пришли свой email, под которым залогинена в Figma
- **Telegram-каналу для франчайзи** — пришли свой @username

## Поддержка

- Что-то не работает: TG @altbar или почта k.urvantcev@gmail.com со скриншотом
- Идея для нового скилла: создай Issue в этом репо
- Хочешь поделиться промптом, который зашёл: PR в `prompts/`

## Roadmap

- [x] CLAUDE.md template (бренд, тон, безопасность)
- [x] Шаги 1-12 — все step-файлы готовы
- [ ] `install.sh` / `install.ps1` — автоматическая раскатка кита (вместо ручного копирования)
- [ ] `altairika-update` — скрипт обновления (`git pull` + подкладка обновлений в `~/.claude/`)
- [ ] Skills: post-writer, parent-reply, school-script, birthday-script, review-response
- [ ] Prompt templates (5-7 готовых под повседневные задачи)
- [ ] Vault — внутренние инструкции от УК (расписания акций, новые программы)
