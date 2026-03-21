#!/bin/bash

# ============================================
# Telegram TTS 快速部署脚本（远程安装）
# ============================================

echo "═══════════════════════════════════════════"
echo "   Telegram TTS 快速部署"
echo "═══════════════════════════════════════════"
echo ""

# 从 GitHub 安装
REPO_URL="https://github.com/your-username/telegram-tts"

# 或者从本地打包
TEMP_DIR=$(mktemp -d)
SKILL_DIR="$HOME/.openclaw/workspace/skills/telegram-tts"

if [ -d "$SKILL_DIR" ]; then
    echo "📦 从本地安装..."
    cd "$SKILL_DIR"
    ./install.sh
else
    echo "📦 从远程安装..."
    echo "请先上传到 GitHub，然后运行："
    echo ""
    echo "  git clone $REPO_URL ~/telegram-tts"
    echo "  cd ~/telegram-tts"
    echo "  ./install.sh"
    echo ""
fi

rm -rf "$TEMP_DIR"
