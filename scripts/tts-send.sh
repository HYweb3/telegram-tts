#!/bin/bash

# ============================================
# Telegram TTS Sender - 语音消息发送脚本
# ============================================

set -e

# 配置文件路径
CONFIG_FILE="$HOME/.tts-config"

# 默认值
DEFAULT_VOICE="zh-CN-XiaoyiNeural"
DEFAULT_RATE="+0%"
TEMP_DIR="/tmp"

# 加载配置
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "❌ 错误：未找到配置文件"
    echo "请先运行: ~/bin/tts-config.sh"
    exit 1
fi

# 检查必需变量
if [ -z "$TELEGRAM_TOKEN" ] || [ -z "$CHAT_ID" ]; then
    echo "❌ 错误：配置不完整"
    echo "请检查 $CONFIG_FILE"
    exit 1
fi

# 帮助信息
show_help() {
    cat << EOF
用法: tts-send.sh [选项] -t "文字内容"
    或: tts-send.sh "文字内容"

选项:
    -t, --text TEXT      要朗读的文字（必需）
    -v, --voice VOICE    声音（默认：zh-CN-XiaoyiNeural）
    -r, --rate RATE      语速（如 +50%, -20%，默认：+0%）
    -c, --caption TEXT   语音消息标题
    -h, --help           显示帮助

示例:
    tts-send.sh -t "你好，这是测试"
    tts-send.sh -v zh-CN-XiaoxiaoNeural -t "用晓晓的声音"
    tts-send.sh -r +50% -t "加速朗读"

常用声音:
    zh-CN-XiaoyiNeural    晓艺（女，活泼）⭐
    zh-CN-XiaoxiaoNeural  晓晓（女，温暖）
    zh-CN-YunjianNeural   云健（男，激情）
EOF
}

# 解析参数
TEXT=""
VOICE="$DEFAULT_VOICE"
RATE="$DEFAULT_RATE"
CAPTION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--text)
            TEXT="$2"
            shift 2
            ;;
        -v|--voice)
            VOICE="$2"
            shift 2
            ;;
        -r|--rate)
            RATE="$2"
            shift 2
            ;;
        -c|--caption)
            CAPTION="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            echo "❌ 未知选项: $1"
            show_help
            exit 1
            ;;
        *)
            # 如果没有 -t 标志，第一个参数就是文字
            if [ -z "$TEXT" ]; then
                TEXT="$1"
            fi
            shift
            ;;
    esac
done

# 检查文字参数
if [ -z "$TEXT" ]; then
    echo "❌ 错误：缺少文字内容"
    show_help
    exit 1
fi

# 生成唯一文件名
TIMESTAMP=$(date +%s)
MP3_FILE="${TEMP_DIR}/tts_${TIMESTAMP}.mp3"
OGG_FILE="${TEMP_DIR}/tts_${TIMESTAMP}.ogg"

# 清理函数
cleanup() {
    rm -f "$MP3_FILE" "$OGG_FILE"
}
trap cleanup EXIT

# 1. 生成语音
echo "🎙️ 生成语音..."
if ! edge-tts --text "$TEXT" --voice "$VOICE" --rate="$RATE" --write-media "$MP3_FILE" 2>/dev/null; then
    echo "❌ 语音生成失败"
    exit 1
fi

# 2. 转换格式
echo "🔄 转换格式..."
if ! ffmpeg -i "$MP3_FILE" -c:a libopus -b:a 64k -y "$OGG_FILE" 2>/dev/null; then
    echo "❌ 格式转换失败"
    exit 1
fi

# 3. 发送到 Telegram
echo "📤 发送到 Telegram..."

CAPTION_ARG=""
if [ -n "$CAPTION" ]; then
    CAPTION_ARG="-F caption=\"$CAPTION\""
fi

RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendVoice" \
    -F chat_id="$CHAT_ID" \
    -F voice=@"$OGG_FILE" \
    $CAPTION_ARG)

# 检查结果
if echo "$RESPONSE" | jq -e '.ok' > /dev/null 2>&1; then
    echo "✅ 语音已发送"
else
    echo "❌ 发送失败"
    echo "$RESPONSE" | jq -r '.description' 2>/dev/null || echo "$RESPONSE"
    exit 1
fi
