#!/usr/bin/env bash
# Altairika Franchise Claude Code Kit — Mac/Linux installer
# Usage: curl -fsSL https://raw.githubusercontent.com/altbar/altairika-franchise/main/install.sh | bash

set -euo pipefail

REPO_URL="https://github.com/altbar/altairika-franchise.git"
INSTALL_DIR="$HOME/altairika-franchise"
CLAUDE_DIR="$HOME/.claude"
BIN_DIR="$HOME/bin"

echo "═══════════════════════════════════════════════"
echo "  Altairika Franchise — Claude Code Kit"
echo "═══════════════════════════════════════════════"
echo ""

# Check git
if ! command -v git &>/dev/null; then
    echo "ОШИБКА: git не найден. Поставь его сначала:"
    echo "  Mac: xcode-select --install"
    echo "  или: brew install git"
    exit 1
fi

# Check claude
if ! command -v claude &>/dev/null; then
    echo "ВНИМАНИЕ: команда 'claude' не найдена в PATH."
    echo "Сначала пройди шаги 1-3 (см. репо), потом запусти install.sh снова."
    echo "Продолжить установку кита всё равно? [y/N]"
    read -r answer
    [[ "$answer" =~ ^[yY]$ ]] || exit 1
fi

# Clone or update repo
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "Репо уже существует в $INSTALL_DIR — обновляю..."
    cd "$INSTALL_DIR" && git pull --ff-only
else
    echo "Клонирую репо в $INSTALL_DIR..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Ensure ~/.claude exists
mkdir -p "$CLAUDE_DIR"

# Copy CLAUDE.md with backup
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    BACKUP="$CLAUDE_DIR/CLAUDE.md.backup-$(date +%Y%m%d-%H%M%S)"
    cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
    echo "Существующий CLAUDE.md сохранён: $BACKUP"
fi

cp "$INSTALL_DIR/templates/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "Установлен: $CLAUDE_DIR/CLAUDE.md"

# Set up altairika-update command
mkdir -p "$BIN_DIR"
chmod +x "$INSTALL_DIR/scripts/altairika-update.sh"
ln -sf "$INSTALL_DIR/scripts/altairika-update.sh" "$BIN_DIR/altairika-update"
echo "Команда altairika-update -> $BIN_DIR/altairika-update"

# Add ~/bin to PATH if not there
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    SHELL_RC=""
    if [ -n "${ZSH_VERSION:-}" ] || [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    fi
    if [ -n "$SHELL_RC" ]; then
        echo '' >> "$SHELL_RC"
        echo '# Added by altairika-franchise install.sh' >> "$SHELL_RC"
        echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_RC"
        echo "Добавил ~/bin в PATH через $SHELL_RC"
        echo "Перезапусти терминал ИЛИ выполни: source $SHELL_RC"
    fi
fi

echo ""
echo "═══════════════════════════════════════════════"
echo "  Установка завершена."
echo "═══════════════════════════════════════════════"
echo ""
echo "Что дальше:"
echo "  1. Открой $CLAUDE_DIR/CLAUDE.md и поправь секцию 'Кто я' под себя"
echo "  2. Запусти 'claude' — напиши 'прочитай мой CLAUDE.md'"
echo "  3. Иди по шагам: $INSTALL_DIR/steps/"
echo "  4. Для обновлений: altairika-update"
echo ""
