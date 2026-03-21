# 快速入门（5分钟）

从零开始，5 分钟内让 AI 助手为你朗读内容并发送到 Telegram。

## 📋 准备工作

确保你有：
- ✅ macOS / Linux / WSL
- ✅ Telegram 账号
- ✅ 5 分钟时间

## 🚀 安装步骤

### 步骤 1：安装依赖（2分钟）

**macOS:**
```bash
brew install ffmpeg jq git
pipx install edge-tts
```

**Linux:**
```bash
sudo apt install ffmpeg jq git curl
pip install edge-tts
```

### 步骤 2：创建 Telegram Bot（1分钟）

1. Telegram 搜索 **@BotFather**
2. 发送 `/newbot`
3. 按提示命名（如：`MyTTSBot`）
4. **复制返回的 Token**

### 步骤 3：获取 Chat ID（30秒）

1. Telegram 搜索 **@userinfobot**
2. 发送任意消息
3. **复制返回的 Chat ID**

### 步骤 4：安装并配置（1分钟）

```bash
# 克隆并安装
git clone https://github.com/HYweb3/telegram-tts.git
cd telegram-tts
./install.sh

# 配置（粘贴 Token 和 Chat ID）
~/bin/tts-config.sh
```

### 步骤 5：测试（30秒）

```bash
tts-send.sh "你好，我是你的语音助手！"
```

在 Telegram 中应该收到语音消息！

---

## ✅ 完成！

现在你可以：

**命令行使用：**
```bash
tts-send.sh "要朗读的内容"
```

**AI 助手集成：**

在你的 AI 助手中安装 skill 后，直接说：
- "读给我听"
- "转语音"
- "用 TTS 朗读这段话"

---

## 🎯 下一步

- 📖 [阅读完整文档](https://github.com/HYweb3/telegram-tts#readme)
- 🎭 [尝试不同声音](https://github.com/HYweb3/telegram-tts#-可用声音)
- 🤖 [集成到 AI 助手](https://github.com/HYweb3/telegram-tts#-ai-助手集成)
- 🐛 [遇到问题？](https://github.com/HYweb3/telegram-tts#-故障排查)

---

**需要帮助？** [提交 Issue](https://github.com/HYweb3/telegram-tts/issues)
