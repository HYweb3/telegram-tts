---
name: telegram-tts
description: Text-to-speech with automatic Telegram voice message delivery. Use when user wants to hear content read aloud ("读给我听", "转语音", "tts", "朗读"). Converts text to speech using edge-tts and sends as playable voice message to Telegram.
metadata:
  openclaw:
    homepage: https://github.com/your-username/telegram-tts
---

# Telegram TTS - 语音消息自动发送

将文字转成语音并直接发送到 Telegram，用户可以点击播放。

## 快速使用

当用户说"读给我听"、"转语音"、"朗读"时，自动触发。

### 工作流程

1. **生成文字回复**（用户先看到内容）
2. **调用 TTS 脚本**：
```bash
~/bin/tts-send.sh "要朗读的文字内容"
```
3. **用户收到语音消息**（Telegram 内直接播放）

## 配置要求

首次使用需要配置：

```bash
# 运行配置脚本
~/bin/tts-config.sh
```

按提示输入：
- Telegram Bot Token（从 @BotFather 获取）
- Chat ID（从 @userinfobot 获取）

## 可选参数

**自定义声音：**
```bash
~/bin/tts-send.sh -v zh-CN-XiaoxiaoNeural -t "用晓晓的声音读"
```

**调节语速：**
```bash
~/bin/tts-send.sh -r +50% -t "加速朗读"
```

## 支持的声音

常用中文声音：
- `zh-CN-XiaoyiNeural` - 晓艺（女声，活泼）⭐ 默认
- `zh-CN-XiaoxiaoNeural` - 晓晓（女声，温暖）
- `zh-CN-YunjianNeural` - 云健（男声，激情）

查看所有声音：
```bash
edge-tts --list-voices | grep zh-CN
```

## 注意事项

- 需要先安装 `edge-tts` 和 `ffmpeg`
- Bot Token 和 Chat ID 存储在 `~/.tts-config`
- 临时文件自动清理

## 示例对话

**用户：** 讲个笑话，然后读给我听

**AI：** （讲笑话文字内容）

**AI：** （自动调用脚本发送语音）

**用户收到：** 🎙️ 语音消息（点击播放）
