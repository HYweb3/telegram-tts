#!/usr/bin/env node

/**
 * OpenClaw TTS Auto-Trigger Service
 * 自动监听消息并触发 TTS
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

// 配置
const CONFIG = {
  logFile: '/tmp/openclaw/openclaw-' + new Date().toISOString().split('T')[0] + '.log',
  triggers: [
    '读给我听', '转语音', '朗读', 'tts', '读一下',
    '读一读', '念给我听', '故事', '听力', '语音',
    '讲一个', '念一下', '读书', '读出来', '讲个',
    '背一', '讲一', '读一', '读个', '背首'
  ],
  ttsScript: process.env.HOME + '/bin/tts-send.sh'
};

console.log('═══════════════════════════════════════════');
console.log('   OpenClaw TTS Auto-Trigger Service');
console.log('═══════════════════════════════════════════');
console.log('');
console.log('🎯 触发关键词:', CONFIG.triggers.length + '个');
console.log('🔧 TTS 脚本:', CONFIG.ttsScript);
console.log('📝 日志文件:', CONFIG.logFile);
console.log('');

// 检查文件是否存在
if (!fs.existsSync(CONFIG.ttsScript)) {
  console.error('❌ TTS 脚本不存在:', CONFIG.ttsScript);
  console.error('   请先运行: ~/bin/tts-config.sh');
  process.exit(1);
}

// 检查是否应该触发
function shouldTrigger(message) {
  const lowerMessage = message.toLowerCase();
  return CONFIG.triggers.some(trigger =>
    lowerMessage.includes(trigger.toLowerCase())
  );
}

// 提取要朗读的文字
function extractText(message) {
  let text = message;

  // 移除触发关键词
  for (const trigger of CONFIG.triggers) {
    const regex = new RegExp(trigger, 'gi');
    text = text.replace(regex, '');
  }

  // 清理
  text = text.trim();

  return text;
}

// 调用 TTS 脚本
async function callTTS(text) {
  return new Promise((resolve, reject) => {
    console.log(`\n🎙️ 触发 TTS: "${text.substring(0, 50)}..."`);

    const proc = spawn(CONFIG.ttsScript, [text]);

    proc.on('close', (code) => {
      if (code === 0) {
        console.log('✅ TTS 发送成功');
        resolve();
      } else {
        console.error('❌ TTS 发送失败:', code);
        reject(new Error(`TTS failed with code ${code}`));
      }
    });

    proc.on('error', (err) => {
      console.error('❌ TTS 错误:', err);
      reject(err);
    });
  });
}

// 使用 tail -F 监听日志文件
console.log('👀 开始监听消息...\n');

const tail = spawn('tail', ['-F', '-n', '0', CONFIG.logFile]);

tail.stdout.on('data', (data) => {
  const lines = data.toString().split('\n');

  for (const line of lines) {
    if (!line.trim()) continue;

    try {
      // 尝试从日志中提取消息内容
      const match = line.match(/"content":"([^"]+)"/);
      if (match && shouldTrigger(match[1])) {
        console.log('🔔 检测到触发消息:', match[1].substring(0, 100));

        const text = extractText(match[1]);
        if (text) {
          callTTS(text).catch(err => {
            console.error('TTS 调用失败:', err);
          });
        }
      }
    } catch (error) {
      // 忽略解析错误
    }
  }
});

tail.stderr.on('data', (data) => {
  console.error('tail 错误:', data.toString());
});

tail.on('close', (code) => {
  console.log('tail 进程退出，重启中...');
  setTimeout(() => process.exit(0), 5000);
});

// 处理退出
process.on('SIGINT', () => {
  console.log('\n👋 停止监听');
  tail.kill();
  process.exit(0);
});

process.on('SIGTERM', () => {
  console.log('\n👋 停止监听');
  tail.kill();
  process.exit(0);
});

console.log('═══════════════════════════════════════════');
console.log('   ✅ 自动触发服务已就绪');
console.log('═══════════════════════════════════════════');
console.log('');
console.log('🎯 触发关键词:');
CONFIG.triggers.forEach((trigger, i) => {
  console.log(`   ${(i+1).toString().padStart(2)}. ${trigger}`);
});
console.log('');
console.log('💡 使用方法:');
console.log('   发送包含关键词的消息，自动触发 TTS');
console.log('');
console.log('📋 日志: /tmp/tts-auto.log');
console.log('');
