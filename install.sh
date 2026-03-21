#!/bin/bash

# ============================================
# Telegram TTS 一键安装脚本
# ============================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/bin"

echo "═══════════════════════════════════════════"
echo "   Telegram TTS 一键安装"
echo "═══════════════════════════════════════════"
echo ""

# 创建 bin 目录
mkdir -p "$BIN_DIR"

# 复制脚本
echo "📦 复制脚本..."
cp "$SCRIPT_DIR/scripts/tts-send.sh" "$BIN_DIR/"
cp "$SCRIPT_DIR/scripts/tts-config.sh" "$BIN_DIR/"

# 设置执行权限
chmod +x "$BIN_DIR/tts-send.sh"
chmod +x "$BIN_DIR/tts-config.sh"

echo "✅ 脚本已安装到 $BIN_DIR/"

# 检查 PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo ""
    echo "⚠️  $BIN_DIR 不在 PATH 中"
    echo "建议添加到 shell 配置："
    echo ""
    echo "  echo 'export PATH=\"\$HOME/bin:\$PATH\"' >> ~/.zshrc"
    echo "  source ~/.zshrc"
    echo ""
fi

# 运行配置
echo ""
read -p "是否立即配置 Telegram Bot？(y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    "$BIN_DIR/tts-config.sh"
else
    echo ""
    echo "稍后配置请运行："
    echo "  ~/bin/tts-config.sh"
    echo ""
fi

echo "═══════════════════════════════════════════"
echo "   安装完成！"
echo "═══════════════════════════════════════════"
