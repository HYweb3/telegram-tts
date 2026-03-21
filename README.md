# Telegram TTS Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20WSL-blue)](https://github.com/HYweb3/telegram-tts)
[![GitHub Stars](https://img.shields.io/github/stars/HYweb3/telegram-tts?style=social)](https://github.com/HYweb3/telegram-tts)
[![Release](https://img.shields.io/github/v/release/HYweb3/telegram-tts)](https://github.com/HYweb3/telegram-tts/releases)

AI 助手的文字转语音技能，自动将内容朗读并通过 Telegram 语音消息发送。

## ✨ 功能特性

- 🎙️ **高质量语音** - 微软 Edge 神经网络 TTS，接近真人发音
- 📱 **即点即播** - 直接发送到 Telegram，无需下载
- 🎭 **多种声音** - 晓艺、晓晓、云健等多种中文声音
- ⚡ **可调语速** - 支持加速、减速朗读
- 🌍 **多语言支持** - 中文、英文、日文等
- 🔧 **零配置** - 一键安装，交互式配置
- 📦 **跨平台** - macOS、Linux、WSL

## 🎬 工作原理

```
用户说："读给我听" 或 "转语音"
         ↓
AI 生成文字回复（用户先看到）
         ↓
调用 tts-send.sh 脚本
         ↓
edge-tts 生成 MP3 音频
         ↓
ffmpeg 转换为 OGG (Telegram 语音格式)
         ↓
通过 Telegram Bot API 发送
         ↓
用户在 Telegram 中点击播放 🎧
```

**优势：**
- ✅ 文字和语音**分离发送**，用户可以先看后听
- ✅ 语音直接在 Telegram 内播放，**无需下载**
- ✅ 支持**长文本**（不受 Telegram 文字长度限制）
- ✅ **免费使用**，无需 API Key

---

## 📦 安装指南

### 前置要求

在安装前，请确保已安装以下依赖：

| 依赖 | 用途 | macOS 安装 | Linux 安装 |
|------|------|-----------|-----------|
| `edge-tts` | 语音生成 | `pipx install edge-tts` | `pip install edge-tts` |
| `ffmpeg` | 音频转换 | `brew install ffmpeg` | `sudo apt install ffmpeg` |
| `jq` | JSON 解析 | `brew install jq` | `sudo apt install jq` |
| `curl` | HTTP 请求 | 系统自带 | `sudo apt install curl` |
| `git` | 克隆仓库 | `brew install git` | `sudo apt install git` |

### 方式一：从 GitHub 安装（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/HYweb3/telegram-tts.git
cd telegram-tts

# 2. 运行安装脚本
./install.sh

# 3. 配置 Telegram Bot（按提示操作）
~/bin/tts-config.sh

# 4. 测试
tts-send.sh "你好，这是测试语音"
```

### 方式二：从 Release 下载

```bash
# 1. 下载最新版本
curl -L https://github.com/HYweb3/telegram-tts/archive/refs/tags/v1.0.0.tar.gz -o telegram-tts.tar.gz

# 2. 解压
tar -xzf telegram-tts.tar.gz
cd telegram-tts-1.0.0

# 3. 安装
./install.sh

# 4. 配置
~/bin/tts-config.sh
```

### 方式三：手动安装

```bash
# 1. 创建目录
mkdir -p ~/bin

# 2. 下载脚本
curl -o ~/bin/tts-send.sh https://raw.githubusercontent.com/HYweb3/telegram-tts/main/scripts/tts-send.sh
curl -o ~/bin/tts-config.sh https://raw.githubusercontent.com/HYweb3/telegram-tts/main/scripts/tts-config.sh

# 3. 设置权限
chmod +x ~/bin/tts-send.sh ~/bin/tts-config.sh

# 4. 配置
~/bin/tts-config.sh
```

---

## 🔑 获取 Telegram Bot Token 和 Chat ID

### 步骤 1：创建 Telegram Bot

1. 在 Telegram 搜索 **@BotFather**
2. 发送 `/newbot`
3. 按提示输入 Bot 名称（如：`MyTTSBot`）
4. 按提示输入 Bot 用户名（如：`my_tts_bot`，必须以 `bot` 结尾）
5. **复制返回的 Token**（格式：`123456789:ABCdefGHIjklMNOpqrsTUVwxyz`）

```
Done! Congratulations on your new bot...
Use this token to access the HTTP API:
123456789:ABCdefGHIjklMNOpqrsTUVwxyz  ← 复制这个
```

### 步骤 2：获取 Chat ID

**方法一：使用 @userinfobot（最简单）**

1. 在 Telegram 搜索 **@userinfobot**
2. 发送任意消息
3. 它会返回你的 Chat ID（如：`123456789`）

**方法二：通过 API 查询**

1. 先给你的 Bot 发一条消息
2. 访问（替换 `<TOKEN>` 为你的 Token）：
   ```
   https://api.telegram.org/bot<TOKEN>/getUpdates
   ```
3. 找到 `"chat":{"id":123456789}` 中的数字

### 步骤 3：运行配置脚本

```bash
~/bin/tts-config.sh
```

按提示粘贴 Token 和 Chat ID，配置脚本会自动验证并保存。

---

## 🚀 使用方法

### 基本使用

```bash
# 发送语音（默认晓艺声音）
tts-send.sh "你好，这是测试语音"

# 或显式指定文字
tts-send.sh -t "你好，这是测试语音"
```

### 自定义声音

```bash
# 晓晓（温暖女声）
tts-send.sh -v zh-CN-XiaoxiaoNeural -t "用晓晓的声音读"

# 云健（激情男声）
tts-send.sh -v zh-CN-YunjianNeural -t "用云健的声音读"

# 英文声音
tts-send.sh -v en-US-JennyNeural -t "Hello, this is Jenny"
```

### 调节语速

```bash
# 加速 50%
tts-send.sh -r +50% -t "这是加速朗读"

# 减速 30%
tts-send.sh -r -30% -t "这是减速朗读"
```

### 添加标题

```bash
tts-send.sh -c "每日新闻摘要" -t "今天的新闻内容..."
```

### 组合使用

```bash
# 自定义声音 + 语速 + 标题
tts-send.sh -v zh-CN-XiaoxiaoNeural -r +30% -c "故事时间" -t "从前有座山..."
```

---

## 🤖 AI 助手集成

### OpenClaw / Claude Code / Cursor

1. 将 `SKILL.md` 复制到技能目录：

```bash
# OpenClaw
mkdir -p ~/.openclaw/workspace/skills/telegram-tts
cp SKILL.md ~/.openclaw/workspace/skills/telegram-tts/

# Claude Code
mkdir -p ~/.claude/skills/telegram-tts
cp SKILL.md ~/.claude/skills/telegram-tts/

# Cursor
mkdir -p ~/.cursor/skills/telegram-tts
cp SKILL.md ~/.cursor/skills/telegram-tts/
```

2. 重启 AI 助手

3. 使用时说：
   - "读给我听"
   - "转语音"
   - "用 TTS 朗读这段话"

AI 会自动调用 `~/bin/tts-send.sh` 并发送语音。

---

## 🎭 可用声音

### 中文声音

| 代码 | 名称 | 性别 | 风格 | 推荐场景 |
|------|------|------|------|---------|
| `zh-CN-XiaoyiNeural` | 晓艺 | 女 | 活泼 | 日常对话、故事 ⭐ |
| `zh-CN-XiaoxiaoNeural` | 晓晓 | 女 | 温暖 | 新闻、小说 |
| `zh-CN-YunjianNeural` | 云健 | 男 | 激情 | 体育、小说 |
| `zh-CN-liaoning-XiaobeiNeural` | 小北 | 女 | 东北话 | 方言内容 |
| `zh-CN-shaanxi-XiaoniNeural` | 小妮 | 女 | 陕西话 | 方言内容 |

### 英文声音

| 代码 | 名称 | 性别 | 风格 |
|------|------|------|------|
| `en-US-JennyNeural` | Jenny | 女 | 友好舒适 ⭐ |
| `en-US-GuyNeural` | Guy | 男 | 充满激情 |
| `en-GB-SoniaNeural` | Sonia | 女 | 英式口音 |

### 查看所有声音

```bash
# 查看所有中文声音
edge-tts --list-voices | grep zh-CN

# 查看所有英文声音
edge-tts --list-voices | grep en-US

# 查看所有声音
edge-tts --list-voices
```

---

## ⚙️ 配置

### 配置文件位置

```
~/.tts-config
```

### 配置文件格式

```bash
# Telegram TTS 配置文件
# 生成时间: 2026-03-21 14:30:00

TELEGRAM_TOKEN="123456789:ABCdef..."
CHAT_ID="123456789"
DEFAULT_VOICE="zh-CN-XiaoyiNeural"
```

### 修改配置

**方式一：重新配置**
```bash
~/bin/tts-config.sh
```

**方式二：手动编辑**
```bash
nano ~/.tts-config
# 修改后保存
```

### 环境变量（高级）

也可以通过环境变量配置（适合 Docker/CI）：

```bash
export TELEGRAM_TOKEN="你的Token"
export CHAT_ID="你的ChatID"
```

---

## 🔧 故障排查

### 问题：提示找不到命令

```bash
❌ 错误：未找到配置文件
```

**解决：**
```bash
# 检查脚本是否存在
ls -la ~/bin/tts-*.sh

# 如果不存在，重新安装
cd telegram-tts && ./install.sh
```

### 问题：Token 无效

```bash
❌ Token 无效
```

**解决：**
1. 确认从 @BotFather 复制完整 Token
2. Token 格式：`数字:字母数字混合`
3. 重新运行配置：`~/bin/tts-config.sh`

### 问题：Chat ID 错误

```bash
❌ Chat ID 无效或 Bot 未启动
```

**解决：**
1. **先给 Bot 发一条消息**（重要！）
2. 重新获取 Chat ID：
   ```bash
   curl -s "https://api.telegram.org/bot<TOKEN>/getUpdates" | jq '.result[-1].message.chat.id'
   ```
3. 重新配置：`~/bin/tts-config.sh`

### 问题：edge-tts 未安装

```bash
❌ 缺少: edge-tts
```

**解决：**

```bash
# macOS
brew install pipx
pipx install edge-tts

# Linux
pip install edge-tts --user

# 或使用虚拟环境
python3 -m venv ~/.tts-venv
source ~/.tts-venv/bin/activate
pip install edge-tts
```

### 问题：ffmpeg 未安装

```bash
❌ 缺少: ffmpeg
```

**解决：**

```bash
# macOS
brew install ffmpeg

# Ubuntu/Debian
sudo apt update && sudo apt install ffmpeg

# CentOS/RHEL
sudo yum install ffmpeg
```

### 问题：发送失败

```bash
❌ 发送失败
```

**调试步骤：**

1. 测试 Bot Token：
   ```bash
   curl "https://api.telegram.org/bot<TOKEN>/getMe"
   ```

2. 测试发送消息：
   ```bash
   curl -X POST "https://api.telegram.org/bot<TOKEN>/sendMessage" \
     -d chat_id="<CHAT_ID>" \
     -d text="测试消息"
   ```

3. 查看详细错误：
   ```bash
   tts-send.sh "测试" 2>&1 | tee /tmp/tts-debug.log
   ```

---

## 📖 使用场景

### 1. 听文章/书籍

```bash
# 保存文章到文件
echo "长文章内容..." > /tmp/article.txt

# 转成语音
tts-send.sh "$(cat /tmp/article.txt)" -c "文章朗读"
```

### 2. 语言学习

```bash
# 中英文对照
tts-send.sh "Hello, how are you? 你好，你好吗？"
```

### 3. 每日提醒

```bash
# 添加到 crontab
0 9 * * * /home/user/bin/tts-send.sh "早上好！该起床了"
```

### 4. AI 助手语音输出

集成到 AI 助手后，用户说：
- "给我讲个笑话，然后读给我听"
- "总结这篇文章，转成语音"

AI 会先生成文字，再自动发送语音。

---

## 🌐 跨平台支持

| 平台 | 支持状态 | 备注 |
|------|---------|------|
| macOS | ✅ 完全支持 | 使用 Homebrew 安装依赖 |
| Linux | ✅ 完全支持 | Ubuntu/Debian/CentOS |
| WSL | ✅ 完全支持 | Windows Subsystem for Linux |
| Windows | ❌ 暂不支持 | 可通过 WSL 使用 |

---

## 🗺️ 路线图

- [ ] 支持发送到群组
- [ ] 支持批量转换
- [ ] Web UI 界面
- [ ] 支持更多 TTS 引擎（Google、Amazon）
- [ ] Docker 镜像
- [ ] Windows 原生支持

---

## 🤝 贡献

欢迎贡献！请查看 [贡献指南](CONTRIBUTING.md)。

### 贡献方式

- 🐛 提交 Bug 报告
- 💡 提出新功能建议
- 📝 改进文档
- 🔧 提交代码改进

---

## 📄 许可证

[MIT License](LICENSE) © 2026

---

## 💬 常见问题（FAQ）

### Q: 为什么是 OGG 格式？

**A:** Telegram 的语音消息要求 OGG/Opus 格式，MP3 不能直接作为语音发送。

### Q: 可以发送给群组吗？

**A:** 可以！将 `CHAT_ID` 改为群组 ID（负数），并确保 Bot 在群组中。

### Q: 有字数限制吗？

**A:** edge-tts 本身没有限制，但建议单次不超过 5000 字，以免生成时间过长。

### Q: 支持离线使用吗？

**A:** 不支持，edge-tts 需要联网访问微软服务器。

### Q: 完全免费吗？

**A:** 是的，edge-tts 和 Telegram Bot API 都是免费的。

---

## 📞 支持

- 📖 [完整文档](https://github.com/HYweb3/telegram-tts#readme)
- 🐛 [提交 Issue](https://github.com/HYweb3/telegram-tts/issues)
- 💬 [讨论区](https://github.com/HYweb3/telegram-tts/discussions)

---

**如果这个项目对你有帮助，请给一个 ⭐ Star！**
