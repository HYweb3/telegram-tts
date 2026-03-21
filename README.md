# Telegram TTS Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20WSL-blue)](https://github.com/HYweb3/telegram-tts)
[![GitHub Stars](https://img.shields.io/github/stars/HYweb3/telegram-tts?style=social)](https://github.com/HYweb3/telegram-tts)

AI 助手的文字转语音技能，自动将内容朗读并通过 Telegram 语音消息发送。

## ✨ 功能特性

- 🎙️ 高质量神经网络语音（微软 Edge TTS）
- 📱 直接发送到 Telegram，点击即播
- 🌍 支持中文、英文等多语言
- ⚡ 可调语速、音调
- 🎭 多种声音可选（晓艺、晓晓、云健等）

## 🎬 工作原理

```
用户说："读给我听"
      ↓
AI 生成文字回复（用户先看到）
      ↓
调用 tts-send.sh
      ↓
edge-tts 生成 MP3
      ↓
ffmpeg 转换为 OGG (Telegram 格式)
      ↓
通过 Telegram API 发送
      ↓
用户在 Telegram 中点击播放 🎧
```

## 📦 一键安装

```bash
# 克隆或下载后
cd telegram-tts
./install.sh
```

按提示配置 Telegram Bot Token 和 Chat ID 即可。

### 快速开始

```bash
# 1. 克隆仓库
git clone https://github.com/HYweb3/telegram-tts.git
cd telegram-tts

# 2. 安装
./install.sh

# 3. 配置（按提示输入 Bot Token 和 Chat ID）
~/bin/tts-config.sh

# 4. 测试
tts-send.sh "你好，这是测试语音"
```

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
