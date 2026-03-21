#!/bin/bash

# ============================================
# Telegram TTS 使用示例
# ============================================

echo "═══════════════════════════════════════════"
echo "   Telegram TTS 使用示例"
echo "═══════════════════════════════════════════"
echo ""

# 示例 1：基本使用
echo "📝 示例 1：基本使用"
echo "命令: tts-send.sh \"你好，这是测试语音\""
echo ""

# 示例 2：自定义声音
echo "🎭 示例 2：自定义声音"
echo "晓晓（温暖）: tts-send.sh -v zh-CN-XiaoxiaoNeural -t \"用晓晓的声音\""
echo "云健（激情）: tts-send.sh -v zh-CN-YunjianNeural -t \"用云健的声音\""
echo "英文: tts-send.sh -v en-US-JennyNeural -t \"Hello world\""
echo ""

# 示例 3：调节语速
echo "⚡ 示例 3：调节语速"
echo "加速: tts-send.sh -r +50% -t \"加速朗读\""
echo "减速: tts-send.sh -r -30% -t \"减速朗读\""
echo ""

# 示例 4：添加标题
echo "📌 示例 4：添加标题"
echo "命令: tts-send.sh -c \"每日新闻\" -t \"今天的新闻内容...\""
echo ""

# 示例 5：组合使用
echo "🔧 示例 5：组合使用"
echo "命令: tts-send.sh -v zh-CN-XiaoxiaoNeural -r +30% -c \"故事时间\" -t \"从前有座山...\""
echo ""

# 示例 6：长文本
echo "📖 示例 6：长文本（从文件读取）"
echo "命令: tts-send.sh \"\$(cat /path/to/article.txt)\" -c \"文章朗读\""
echo ""

echo "═══════════════════════════════════════════"
echo "   查看完整文档: tts-send.sh --help"
echo "═══════════════════════════════════════════"
