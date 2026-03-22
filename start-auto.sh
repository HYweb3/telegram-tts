#!/bin/bash

# ============================================
# 启动 TTS 自动触发服务
# ============================================

SCRIPT="/Users/www2/.openclaw/workspace/skills/telegram-tts/auto-trigger.js"

echo "═══════════════════════════════════════════"
echo "   启动 TTS 自动触发服务"
echo "═══════════════════════════════════════════"
echo ""

# 停止旧进程
ps aux | grep "auto-trigger.js" | grep -v grep | awk '{print $2}' | xargs kill 2>/dev/null
echo "✅ 已停止旧服务"
sleep 1

# 启动新服务
echo "🚀 启动服务..."
node "$SCRIPT" > /tmp/tts-auto.log 2>&1 &
PID=$!

sleep 2

# 检查是否启动成功
if ps -p $PID > /dev/null 2>&1; then
    echo "✅ 服务已启动 (PID: $PID)"
    echo ""
    echo "📋 日志位置: /tmp/tts-auto.log"
    echo ""
    echo "🎯 触发关键词 (20个):"
    echo "   读给我听、转语音、朗读、tts"
    echo "   读一下、读一读、念给我听、故事"
    echo "   听力、语音、讲一个、念一下"
    echo "   读书、读出来、讲个、背一"
    echo "   讲一、读一、读个、背首"
    echo ""
    echo "💡 测试: 发送消息 '背一首古诗'"
    echo ""
else
    echo "❌ 启动失败"
    echo ""
    echo "错误日志:"
    tail -20 /tmp/tts-auto.log
    echo ""
fi
