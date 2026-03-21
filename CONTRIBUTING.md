# 贡献指南

感谢你考虑为 Telegram TTS Skill 做贡献！

## 🤝 如何贡献

### 提交 Bug 报告

如果你发现了 bug，请[创建 Issue](https://github.com/HYweb3/telegram-tts/issues/new)并包含：

1. **操作系统和版本**
   - macOS / Linux / WSL
   - 版本号

2. **复现步骤**
   - 详细描述如何重现问题

3. **期望行为**
   - 你期望发生什么

4. **实际行为**
   - 实际发生了什么

5. **日志输出**
   ```bash
   tts-send.sh "测试" 2>&1 | tee /tmp/tts-debug.log
   ```
   粘贴相关日志

### 提出新功能

如果你有新功能建议：

1. [创建 Issue](https://github.com/HYweb3/telegram-tts/issues/new)
2. 描述功能和用例
3. 说明为什么这个功能有用

### 改进文档

文档改进是最容易的贡献方式：

- 修正错别字
- 改进说明
- 添加示例
- 翻译文档

### 提交代码

1. **Fork 仓库**
   ```bash
   git clone https://github.com/你的用户名/telegram-tts.git
   cd telegram-tts
   ```

2. **创建分支**
   ```bash
   git checkout -b feature/你的功能名称
   ```

3. **修改代码**
   - 遵循现有代码风格
   - 添加注释
   - 测试你的修改

4. **提交**
   ```bash
   git add .
   git commit -m "描述你的修改"
   ```

5. **推送**
   ```bash
   git push origin feature/你的功能名称
   ```

6. **创建 Pull Request**
   - 在 GitHub 上创建 PR
   - 描述你的修改
   - 关联相关 Issue

## 📝 代码规范

### Shell 脚本

- 使用 `#!/bin/bash` shebang
- 使用 `set -e` 在错误时退出
- 添加注释说明函数用途
- 使用有意义的变量名
- 错误消息使用 `❌` 前缀
- 成功消息使用 `✅` 前缀

### Markdown

- 使用标准 Markdown 格式
- 代码块指定语言
- 表格对齐
- 使用 emoji 增强可读性

## 🧪 测试

在提交 PR 前，请测试：

```bash
# 1. 测试基本功能
tts-send.sh "测试语音"

# 2. 测试自定义声音
tts-send.sh -v zh-CN-XiaoxiaoNeural -t "测试"

# 3. 测试语速调节
tts-send.sh -r +50% -t "测试"

# 4. 测试标题
tts-send.sh -c "标题" -t "测试"
```

## 📋 检查清单

提交 PR 前，确认：

- [ ] 代码遵循项目规范
- [ ] 已测试修改
- [ ] 更新了相关文档
- [ ] 提交信息清晰
- [ ] PR 描述完整

## 💬 联系方式

- GitHub Issues: https://github.com/HYweb3/telegram-tts/issues
- GitHub Discussions: https://github.com/HYweb3/telegram-tts/discussions

---

再次感谢你的贡献！🎉
