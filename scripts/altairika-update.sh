#!/usr/bin/env bash
# Altairika Franchise Kit — update script (Mac/Linux)

set -euo pipefail

INSTALL_DIR="$HOME/altairika-franchise"
CLAUDE_DIR="$HOME/.claude"
TEMPLATE_MD="$INSTALL_DIR/templates/CLAUDE.md"
USER_MD="$CLAUDE_DIR/CLAUDE.md"

if [ ! -d "$INSTALL_DIR/.git" ]; then
    echo "ОШИБКА: $INSTALL_DIR не git-репо. Запусти install.sh заново."
    exit 1
fi

cd "$INSTALL_DIR"
echo "Обновляю репо..."
BEFORE=$(git rev-parse HEAD)
git pull --ff-only
AFTER=$(git rev-parse HEAD)

if [ "$BEFORE" = "$AFTER" ]; then
    echo "Уже актуально. Ничего нового."
    exit 0
fi

echo ""
echo "Изменения с прошлой версии:"
git log --oneline "$BEFORE..$AFTER"
echo ""

# Check CLAUDE.md template change
if [ -f "$USER_MD" ] && ! diff -q "$TEMPLATE_MD" "$USER_MD" >/dev/null 2>&1; then
    echo "⚠ Шаблон CLAUDE.md изменился, но твой $USER_MD отличается от шаблона."
    echo "  (вероятно, ты редактировал секцию 'Кто я' — это нормально)"
    echo ""
    echo "Что делать:"
    echo "  1. Посмотри diff:        diff $USER_MD $TEMPLATE_MD"
    echo "  2. Если хочешь заменить (потеряв правки):"
    echo "     cp $USER_MD $USER_MD.backup-\$(date +%Y%m%d-%H%M%S)"
    echo "     cp $TEMPLATE_MD $USER_MD"
    echo "  3. Если хочешь смерджить вручную — открой оба в редакторе"
fi

# Sync skills (overwrite — skills shouldn't be edited locally)
SKILLS_DIR="$CLAUDE_DIR/skills"
mkdir -p "$SKILLS_DIR"
SKILLS_UPDATED=0
for skill_file in "$INSTALL_DIR/skills"/*.md; do
    [ -f "$skill_file" ] || continue
    name=$(basename "$skill_file")
    if [ ! -f "$SKILLS_DIR/$name" ] || ! diff -q "$skill_file" "$SKILLS_DIR/$name" >/dev/null 2>&1; then
        cp "$skill_file" "$SKILLS_DIR/$name"
        SKILLS_UPDATED=$((SKILLS_UPDATED + 1))
    fi
done
if [ "$SKILLS_UPDATED" -gt 0 ]; then
    echo "Обновлено скиллов: $SKILLS_UPDATED"
fi

echo ""
echo "Обновление завершено."
echo "Новые шаги/файлы — в $INSTALL_DIR/steps/"
