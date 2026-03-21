#!/bin/bash

# ============================================
# Telegram TTS 打包脚本（用于迁移）
# ============================================

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$HOME/Desktop/telegram-tts.tar.gz"

echo "📦 打包 Telegram TTS Skill..."

# 创建临时目录
TEMP_DIR=$(mktemp -d)
PACKAGE_DIR="$TEMP_DIR/telegram-tts"

# 复制文件
mkdir -p "$PACKAGE_DIR"
cp -r "$SKILL_DIR/scripts" "$PACKAGE_DIR/"
cp -r "$SKILL_DIR/docs" "$PACKAGE_DIR/" 2>/dev/null || true
cp "$SKILL_DIR/SKILL.md" "$PACKAGE_DIR/"
cp "$SKILL_DIR/README.md" "$PACKAGE_DIR/"
cp "$SKILL_DIR/skill.json" "$PACKAGE_DIR/"
cp "$SKILL_DIR/install.sh" "$PACKAGE_DIR/"

# 打包
cd "$TEMP_DIR"
tar -czf "$OUTPUT_FILE" telegram-tts

# 清理
rm -rf "$TEMP_DIR"

echo "✅ 打包完成！"
echo ""
echo "文件位置: $OUTPUT_FILE"
echo ""
echo "在新设备上解压安装："
echo "  tar -xzf ~/Desktop/telegram-tts.tar.gz"
echo "  cd telegram-tts"
echo "  ./install.sh"
echo ""
