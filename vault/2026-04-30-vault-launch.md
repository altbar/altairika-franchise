# Запуск Vault для франчайзи

**Категория:** новость
**Дата:** 2026-04-30

## Краткое содержание

Запустили Claude Code Kit для франчайзи Altairika. Все материалы — в репо https://github.com/altbar/altairika-franchise. Сюда (vault/) УК будет складывать актуальные для всей сети материалы: сезонные кампании, новые программы, методички, юридические шаблоны.

## Что делать франчайзи

1. Установи Claude Code (Шаги 1-3 из репо)
2. Раскатай кит командой:
   - Mac: `curl -fsSL https://raw.githubusercontent.com/altbar/altairika-franchise/main/install.sh | bash`
   - Windows: `irm https://raw.githubusercontent.com/altbar/altairika-franchise/main/install.ps1 | iex`
3. Поправь `~/.claude/CLAUDE.md` под себя (секция "Кто я")
4. Раз в неделю запускай `altairika-update` — подтянет новые материалы и скиллы

## Контакт

@altbar / k.urvantcev@gmail.com — вопросы, предложения, баги.
