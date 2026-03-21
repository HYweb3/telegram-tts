# 迁移指南

将 Telegram TTS Skill 迁移到新设备的完整步骤。

## 方法一：使用打包文件（推荐）

### 在原设备上

```bash
# 1. 打包
cd ~/.openclaw/workspace/skills/telegram-tts
./pack.sh

# 2. 文件会保存到桌面：~/Desktop/telegram-tts.tar.gz

# 3. 通过 AirDrop/U盘/网盘 传输到新设备
```

### 在新设备上

```bash
# 1. 安装依赖
# macOS:
brew install ffmpeg jq
pipx install edge-tts

# Linux:
sudo apt install ffmpeg jq
pip install edge-tts

# 2. 解压
cd ~
tar -xzf ~/Desktop/telegram-tts.tar.gz

# 3. 安装
cd telegram-tts
./install.sh

# 4. 配置
~/bin/tts-config.sh
```

---

## 方法二：通过 GitHub

### 在原设备上

```bash
# 1. 创建 GitHub 仓库
cd ~/.openclaw/workspace/skills/telegram-tts
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/HYweb3/telegram-tts.git
git push -u origin main
```

### 在新设备上

```bash
# 1. 克隆
git clone https://github.com/HYweb3/telegram-tts.git
cd telegram-tts

# 2. 安装依赖
# macOS:
brew install ffmpeg jq
pipx install edge-tts

# 3. 安装
./install.sh

# 4. 配置
~/bin/tts-config.sh
```

---

## 方法三：手动复制

### 需要复制的文件

```
telegram-tts/
├── SKILL.md
├── README.md
├── skill.json
├── install.sh
├── pack.sh
├── quick-deploy.sh
└── scripts/
    ├── tts-send.sh
    └── tts-config.sh
```

### 需要复制的配置（可选）

如果在新设备上使用相同的 Bot，可以复制：

```bash
# 配置文件（包含 Token）
~/.tts-config

# 如果使用 OpenClaw，还需要复制 skill 目录
~/.openclaw/workspace/skills/telegram-tts/
```

⚠️ **注意：** `.tts-config` 包含敏感信息（Bot Token），传输时注意安全。

---

## 新设备检查清单

- [ ] 已安装 `edge-tts`
- [ ] 已安装 `ffmpeg`
- [ ] 已安装 `jq`
- [ ] 已安装 `curl`（通常系统自带）
- [ ] 已运行 `./install.sh`
- [ ] 已运行 `~/bin/tts-config.sh`
- [ ] 已测试：`~/bin/tts-send.sh "测试语音"`
- [ ] Telegram 收到语音消息并能播放

---

## 常见问题

### Q: edge-tts 安装失败？

**macOS:**
```bash
brew install pipx
pipx install edge-tts
```

**Linux:**
```bash
pip3 install edge-tts --user
# 或使用虚拟环境
python3 -m venv ~/.tts-venv
source ~/.tts-venv/bin/activate
pip install edge-tts
```

### Q: ffmpeg 安装失败？

**macOS:**
```bash
brew install ffmpeg
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install ffmpeg
```

### Q: 提示找不到 tts-send.sh？

检查 PATH：
```bash
echo $PATH | grep -o "$HOME/bin"
```

如果为空，添加到 shell 配置：
```bash
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Q: Bot Token 无效？

1. 确认从 @BotFather 复制完整 Token
2. Token 格式：`数字:字母数字混合`
3. 重新运行配置：`~/bin/tts-config.sh`

### Q: Chat ID 错误？

1. 先给 Bot 发一条消息
2. 访问：`https://api.telegram.org/bot<TOKEN>/getUpdates`
3. 找到 `"chat":{"id":123456789}` 中的数字

---

## 自动化部署（高级）

如果你有多台设备，可以创建自动化脚本：

```bash
#!/bin/bash
# auto-deploy.sh

# 检查依赖
command -v edge-tts >/dev/null 2>&1 || { pipx install edge-tts; }
command -v ffmpeg >/dev/null 2>&1 || { brew install ffmpeg; }
command -v jq >/dev/null 2>&1 || { brew install jq; }

# 下载并安装
curl -sL https://github.com/你的用户名/telegram-tts/archive/main.tar.gz | tar xz
cd telegram-tts-main
./install.sh

# 使用环境变量配置（如果已设置）
if [ -n "$TELEGRAM_TOKEN" ] && [ -n "$CHAT_ID" ]; then
    cat > ~/.tts-config << EOF
TELEGRAM_TOKEN="$TELEGRAM_TOKEN"
CHAT_ID="$CHAT_ID"
DEFAULT_VOICE="zh-CN-XiaoyiNeural"
EOF
    chmod 600 ~/.tts-config
fi
```

使用：
```bash
export TELEGRAM_TOKEN="你的Token"
export CHAT_ID="你的ChatID"
curl -sL https://你的脚本地址/auto-deploy.sh | bash
```
