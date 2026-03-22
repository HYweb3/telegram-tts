#!/bin/bash

# ============================================
# TTS Auto-Trigger Service 安装脚本
# ============================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_FILE="/tmp/com.openclaw.tts-auto.plist"

echo "═══════════════════════════════════════════"
echo "   TTS Auto-Trigger Service 安装"
echo "═══════════════════════════════════════════"
echo ""

# 检查依赖
if ! command -v node &> /dev/null; then
    echo "❌ 需要 Node.js"
    exit 1
fi

# 检查 TTS 脚本
if [ ! -f "$HOME/bin/tts-send.sh" ]; then
    echo "❌ TTS 脚本不存在"
    echo "   请先安装: https://github.com/HYweb3/telegram-tts"
    exit 1
fi

echo "✅ 依赖检查通过"

# 创建日志目录
mkdir -p /tmp/openclaw

# 设置权限
chmod +x "$SCRIPT_DIR/auto-trigger.js"

echo "✅ 权限设置完成"

# 创建启动脚本
cat > "$HOME/bin/tts-auto-start.sh" << 'STARTSCRIPT'
#!/bin/bash
cd ~/.openclaw/workspace/skills/telegram-tts
node auto-trigger.js
STARTSCRIPT

chmod +x "$HOME/bin/tts-auto-start.sh"

echo "✅ 启动脚本已创建: ~/bin/tts-auto-start.sh"

# macOS: 创建 launchd 服务
if [[ "$OSTYPE" == "darwin"* ]]; then
    cat > "$SERVICE_FILE" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.openclaw.tts-auto</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$HOME/bin/tts-auto-start.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/tts-auto.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/tts-auto.error.log</string>
</dict>
</plist>
EOF

    echo "✅ launchd 服务文件已创建"

    echo ""
    echo "═══════════════════════════════════════════"
    echo "   安装完成！"
    echo "═══════════════════════════════════════════"
    echo ""
    echo "启动方式："
    echo ""
    echo "  方式 1：手动启动（测试）"
    echo "  ~/bin/tts-auto-start.sh"
    echo ""
    echo "  方式 2：开机自动启动（macOS）"
    echo "  launchctl load $SERVICE_FILE"
    echo ""
    echo "  方式 3：停止服务"
    echo "  launchctl unload $SERVICE_FILE"
    echo ""
    echo "日志位置："
    echo "  /tmp/tts-auto.log"
    echo ""
else
    # Linux: 创建 systemd 服务
    SERVICE_FILE="/tmp/tts-auto.service"
    cat > "$SERVICE_FILE" << EOF
[Unit]
Description=OpenClaw TTS Auto-Trigger Service
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME/.openclaw/workspace/skills/telegram-tts
ExecStart=/bin/bash $HOME/bin/tts-auto-start.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    echo "✅ systemd 服务文件已创建: $SERVICE_FILE"
    echo ""
    echo "═══════════════════════════════════════════"
    echo "   安装完成！"
    echo "═══════════════════════════════════════════"
    echo ""
    echo "启动方式："
    echo ""
    echo "  方式 1：手动启动（测试）"
    echo "  ~/bin/tts-auto-start.sh"
    echo ""
    echo "  方式 2：开机自动启动（Linux）"
    echo "  sudo cp $SERVICE_FILE /etc/systemd/system/"
    echo "  sudo systemctl enable tts-auto"
    echo "  sudo systemctl start tts-auto"
    echo ""
    echo "  方式 3：停止服务"
    echo "  sudo systemctl stop tts-auto"
    echo ""
fi

echo "触发关键词："
echo "  讲个、故事、读给我听、转语音、朗读"
echo "  tts、读一下、念一下、读书、读出来等"
echo ""
