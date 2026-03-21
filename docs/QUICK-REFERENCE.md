# Telegram TTS 快速参考

## 常用命令

```bash
# 发送语音（默认晓艺）
tts-send.sh "你好"

# 指定声音
tts-send.sh -v zh-CN-XiaoxiaoNeural -t "用晓晓"

# 调节语速
tts-send.sh -r +50% -t "加速"
tts-send.sh -r -30% -t "减速"

# 添加标题
tts-send.sh -c "标题" -t "内容"

# 查看帮助
tts-send.sh --help

# 重新配置
~/bin/tts-config.sh

# 查看所有声音
edge-tts --list-voices | grep zh-CN
```

## 常用声音

| 代码 | 名称 | 风格 |
|-----|------|------|
| zh-CN-XiaoyiNeural | 晓艺 | 活泼 ⭐ |
| zh-CN-XiaoxiaoNeural | 晓晓 | 温暖 |
| zh-CN-YunjianNeural | 云健 | 激情 |

## 文件位置

```
配置: ~/.tts-config
脚本: ~/bin/tts-send.sh
Skill: ~/.openclaw/workspace/skills/telegram-tts/
```

## 故障排查

```bash
# 检查依赖
which edge-tts ffmpeg jq curl

# 测试 API
curl -s "https://api.telegram.org/bot<TOKEN>/getMe"

# 查看日志
tts-send.sh "测试" 2>&1 | tee /tmp/tts.log
```

## 在 AI 助手中使用

用户说："读给我听"、"转语音"、"朗读"

AI 调用：
```bash
~/bin/tts-send.sh "要朗读的内容"
```

## 快速迁移

```bash
# 原设备
cd ~/.openclaw/workspace/skills/telegram-tts
./pack.sh

# 新设备
tar -xzf telegram-tts.tar.gz
cd telegram-tts
./install.sh
~/bin/tts-config.sh
```
