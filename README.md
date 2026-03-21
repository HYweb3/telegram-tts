# Telegram TTS Skill

AI 助手的文字转语音技能，自动将内容朗读并通过 Telegram 语音消息发送。

## ✨ 功能特性

- 🎙️ 高质量神经网络语音（微软 Edge TTS）
- 📱 直接发送到 Telegram，点击即播
- 🌍 支持中文、英文等多语言
- ⚡ 可调语速、音调
- 🎭 多种声音可选（晓艺、晓晓、云健等）

## 📦 一键安装

```bash
# 克隆或下载后
cd telegram-tts
./install.sh
```

按提示配置 Telegram Bot Token 和 Chat ID 即可。

## 🚀 使用方法

**命令行：**
```bash
tts-send.sh "你好，这是测试语音"
```

**AI 助手集成：**

在你的 AI 助手配置中添加此 skill，当用户说"读给我听"、"转语音"时，AI 会自动调用：

```bash
~/bin/tts-send.sh "要朗读的内容"
```

## 🎭 可用声音

| 声音代码 | 名称 | 性别 | 风格 |
|---------|------|------|------|
| zh-CN-XiaoyiNeural | 晓艺 | 女 | 活泼 ⭐ 默认 |
| zh-CN-XiaoxiaoNeural | 晓晓 | 女 | 温暖 |
| zh-CN-YunjianNeural | 云健 | 男 | 激情 |
| zh-CN-liaoning-XiaobeiNeural | 小北 | 女 | 东北话 |
| zh-CN-shaanxi-XiaoniNeural | 小妮 | 女 | 陕西话 |

查看所有声音：
```bash
edge-tts --list-voices
```

## ⚙️ 配置

配置文件：`~/.tts-config`

```bash
TELEGRAM_TOKEN="123456789:ABC..."
CHAT_ID="123456789"
DEFAULT_VOICE="zh-CN-XiaoyiNeural"
```

重新配置：
```bash
~/bin/tts-config.sh
```

## 📋 依赖

- `edge-tts` - 微软 Edge TTS
- `ffmpeg` - 音频转换
- `jq` - JSON 解析
- `curl` - HTTP 请求

安装依赖：
```bash
# macOS
brew install ffmpeg jq
pipx install edge-tts

# Linux (Ubuntu/Debian)
sudo apt install ffmpeg jq
pip install edge-tts
```

## 🔧 高级用法

**自定义声音：**
```bash
tts-send.sh -v zh-CN-XiaoxiaoNeural -t "用晓晓的声音读"
```

**调节语速：**
```bash
tts-send.sh -r +50% -t "加速朗读"
tts-send.sh -r -30% -t "减速朗读"
```

**添加标题：**
```bash
tts-send.sh -c "每日新闻" -t "新闻内容..."
```

## 🌐 跨平台

- ✅ macOS
- ✅ Linux
- ✅ WSL (Windows Subsystem for Linux)

## 📄 许可证

MIT

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！
