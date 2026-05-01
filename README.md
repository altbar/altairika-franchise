# Altairika Franchise — Claude Code Kit

Стартовый кит для франчайзи Altairika: настройка Claude Code с фирменным контекстом, тоном бренда и шаблонами под типичные задачи (соцсети, родители, школы, ДР, отзывы).

## Что внутри

- `templates/CLAUDE.md` — основной файл с контекстом, тоном бренда, безопасностью и техническими заметками
- (далее) `install.sh` / `install.ps1` — скрипты установки на Mac/Windows
- (далее) `altairika-update` — скрипт обновления кита
- (далее) `skills/` — навыки Claude (онбординг, посты, ответы, скрипты)
- (далее) `prompts/` — готовые шаблоны промптов
- (далее) `vault/` — markdown-инструкции от УК (расписания акций, новые программы, отчёты)

## Как франчайзи установит (черновик инструкции, для отправки партнёру)

### Mac

```bash
git clone https://github.com/altbar/altairika-franchise.git ~/altairika-franchise
cp ~/altairika-franchise/templates/CLAUDE.md ~/.claude/CLAUDE.md
# Открой ~/.claude/CLAUDE.md и поправь "Кто я" под себя
```

### Windows (PowerShell)

```powershell
git clone https://github.com/altbar/altairika-franchise.git $env:USERPROFILE\altairika-franchise
mkdir $env:USERPROFILE\.claude -ErrorAction SilentlyContinue
copy $env:USERPROFILE\altairika-franchise\templates\CLAUDE.md $env:USERPROFILE\.claude\CLAUDE.md
# Открой %USERPROFILE%\.claude\CLAUDE.md в Notepad и поправь "Кто я" под себя
```

После — запусти `claude` в любой папке. В первом сообщении напиши "проверь, что прочитал мой CLAUDE.md и расскажи кратко что ты обо мне знаешь" — убедись что контекст подхватился.

## Доступ

Репо приватный. Чтобы партнёр получил доступ:
1. Партнёр регистрируется на github.com (если ещё нет)
2. Присылает свой GitHub username Константину (TG @altbar)
3. Константин добавляет его как Collaborator с ролью Read

## Roadmap

- [x] CLAUDE.md template (этот файл)
- [ ] install.sh (Mac)
- [ ] install.ps1 (Windows)
- [ ] altairika-update script
- [ ] Skills: post-writer, parent-reply, school-script, birthday-script, review-response
- [ ] Prompt templates (5-7 готовых)
- [ ] Vault structure для контента от УК
- [ ] GitHub repo `altbar/altairika-franchise` создан и запушен
