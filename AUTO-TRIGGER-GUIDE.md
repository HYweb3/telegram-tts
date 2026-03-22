# TTS 自动触发服务使用指南

## ✅ 已完成

### 1. 自动触发服务已创建

**文件位置：**
- `~/.openclaw/workspace/skills/telegram-tts/auto-trigger.js`
- `~/bin/tts-auto-start.sh`

### 2. 触发关键词（16个）

1. 读给我听
2. 转语音
3. 朗读
4. tts
5. 读一下
6. 读一读
7. 念给我听
8. 故事
9. 听力
10. 语音
11. 讲一个
12. 念一下
13. 读书
14. 读出来
15. **讲个** ⭐ 新增

---

## 🚀 使用方法

### 方式 1：手动启动（测试）

```bash
node ~/.openclaw/workspace/skills/telegram-tts/auto-trigger.js
```

### 方式 2：后台运行

```bash
nohup node ~/.openclaw/workspace/skills/telegram-tts/auto-trigger.js > /tmp/tts-auto.log 2>&1 &
```

### 方式 3：开机自动启动（macOS）

```bash
launchctl load /tmp/com.openclaw.tts-auto.plist
```

---

## 🎯 工作原理

```
你发送消息
    ↓
OpenClaw 记录到日志
    ↓
auto-trigger.js 监听日志
    ↓
检测到关键词
    ↓
自动调用 tts-send.sh
    ↓
生成语音并发送到 Telegram
```

---

## 🧪 测试

**发送包含关键词的消息：**
- "讲个投资的笑话"
- "讲个故事"
- "读给我听"
- "转语音"

**预期结果：**
1. 服务检测到关键词
2. 自动生成语音
3. 发送到你的 Telegram

---

## 📋 日志

**日志位置：**
- `/tmp/tts-auto.log`

**查看日志：**
```bash
tail -f /tmp/tts-auto.log
```

---

## 🛠️ 故障排查

### 问题 1：服务未启动

**检查：**
```bash
ps aux | grep auto-trigger
```

**解决：**
```bash
node ~/.openclaw/workspace/skills/telegram-tts/auto-trigger.js
```

### 问题 2：未触发

**检查：**
1. 消息是否包含关键词
2. 日志是否有输出
3. TTS 脚本是否正常

### 问题 3：TTS 失败

**检查：**
```bash
~/bin/tts-send.sh "测试"
```

---

## 💡 建议

**推荐配置：**

1. **手动启动** - 需要时运行
2. **测试通过后** - 设置开机自启

**与 AI 调用配合使用：**
- 自动触发：关键词自动触发
- AI 调用：AI 判断需要语音时调用

两者可以共存！

---

## ✅ 总结

**现在有 3 种触发方式：**

| 方式 | 触发条件 | 状态 |
|------|---------|------|
| 自动触发 | 关键词 | ✅ 已实现 |
| AI 调用 | AI 判断 | ✅ 可用 |
| 手动调用 | 命令行 | ✅ 可用 |

---

**立即测试：发送消息 "讲个投资的笑话" 看是否自动触发！** 🎯
