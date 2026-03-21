#!/bin/bash

# ============================================
# Telegram TTS 配置脚本
# ============================================

CONFIG_FILE="$HOME/.tts-config"
BIN_DIR="$HOME/bin"

echo "═══════════════════════════════════════════"
echo "   Telegram TTS 配置向导"
echo "═══════════════════════════════════════════"
echo ""

# 检查依赖
echo "🔍 检查依赖..."

check_command() {
    if ! command -v $1 &> /dev/null; then
        echo "❌ 缺少: $1"
        echo "   安装方法: $2"
        return 1
    else
        echo "✅ 已安装: $1"
        return 0
    fi
}

DEPS_OK=true

if ! check_command "edge-tts" "pipx install edge-tts 或 pip install edge-tts"; then
    DEPS_OK=false
fi

if ! check_command "ffmpeg" "brew install ffmpeg (macOS) 或 apt install ffmpeg (Linux)"; then
    DEPS_OK=false
fi

if ! check_command "jq" "brew install jq (macOS) 或 apt install jq (Linux)"; then
    DEPS_OK=false
fi

if ! check_command "curl" "系统自带"; then
    DEPS_OK=false
fi

if [ "$DEPS_OK" = false ]; then
    echo ""
    echo "❌ 请先安装缺失的依赖，然后重新运行此脚本"
    exit 1
fi

echo ""
echo "✅ 所有依赖已就绪"
echo ""

# 获取 Bot Token
echo "📱 第一步：创建 Telegram Bot"
echo ""
echo "1. 在 Telegram 搜索 @BotFather"
echo "2. 发送 /newbot"
echo "3. 按提示命名你的 Bot"
echo "4. 复制返回的 Token（格式：123456789:ABCdef...）"
echo ""
read -p "请粘贴 Bot Token: " BOT_TOKEN

if [ -z "$BOT_TOKEN" ]; then
    echo "❌ Token 不能为空"
    exit 1
fi

# 验证 Token
echo ""
echo "🔍 验证 Token..."
BOT_INFO=$(curl -s "https://api.telegram.org/bot${BOT_TOKEN}/getMe")

if ! echo "$BOT_INFO" | jq -e '.ok' > /dev/null 2>&1; then
    echo "❌ Token 无效"
    echo "$BOT_INFO" | jq -r '.description' 2>/dev/null
    exit 1
fi

BOT_NAME=$(echo "$BOT_INFO" | jq -r '.result.first_name')
echo "✅ Token 有效，Bot 名称: $BOT_NAME"

# 获取 Chat ID
echo ""
echo "📱 第二步：获取你的 Chat ID"
echo ""
echo "方法1："
echo "  1. 在 Telegram 搜索 @userinfobot"
echo "  2. 发送任意消息"
echo "  3. 它会返回你的 Chat ID"
echo ""
echo "方法2："
echo "  1. 给你的 Bot 发一条消息"
echo "  2. 访问: https://api.telegram.org/bot${BOT_TOKEN}/getUpdates"
echo "  3. 找到 'chat':{'id':数字} 部分"
echo ""
read -p "请输入你的 Chat ID: " CHAT_ID

if [ -z "$CHAT_ID" ]; then
    echo "❌ Chat ID 不能为空"
    exit 1
fi

# 验证 Chat ID
echo ""
echo "🔍 验证 Chat ID..."
TEST_MSG=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="✅ Telegram TTS 配置成功！")

if ! echo "$TEST_MSG" | jq -e '.ok' > /dev/null 2>&1; then
    echo "❌ Chat ID 无效或 Bot 未启动"
    echo "$TEST_MSG" | jq -r '.description' 2>/dev/null
    exit 1
fi

echo "✅ Chat ID 有效"

# 保存配置
echo ""
echo "💾 保存配置..."

cat > "$CONFIG_FILE" << EOF
# Telegram TTS 配置文件
# 生成时间: $(date)

TELEGRAM_TOKEN="${BOT_TOKEN}"
CHAT_ID="${CHAT_ID}"
DEFAULT_VOICE="zh-CN-XiaoyiNeural"
EOF

chmod 600 "$CONFIG_FILE"
echo "✅ 配置已保存到: $CONFIG_FILE"

# 安装脚本
echo ""
echo "📦 安装脚本..."

mkdir -p "$BIN_DIR"

# 复制脚本
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/tts-send.sh" "$BIN_DIR/tts-send.sh"
chmod +x "$BIN_DIR/tts-send.sh"

echo "✅ 脚本已安装到: $BIN_DIR/tts-send.sh"

# 测试
echo ""
echo "🧪 测试语音生成..."

if "$BIN_DIR/tts-send.sh" -t "配置成功！我是晓艺，很高兴为你服务。" -c "🎉 测试语音" > /dev/null 2>&1; then
    echo "✅ 测试成功！你应该在 Telegram 收到测试语音了"
else
    echo "⚠️  测试失败，请检查配置"
fi

# 完成
echo ""
echo "═══════════════════════════════════════════"
echo "   ✅ 配置完成！"
echo "═══════════════════════════════════════════"
echo ""
echo "使用方法:"
echo "  tts-send.sh \"要朗读的文字\""
echo "  tts-send.sh -v zh-CN-XiaoxiaoNeural -t \"用晓晓的声音\""
echo ""
echo "查看帮助:"
echo "  tts-send.sh --help"
echo ""
