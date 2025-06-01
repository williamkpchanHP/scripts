const puppeteer = require('puppeteer');
const readline = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
const { exec } = require('child_process');
const fs = require('fs').promises;

async function extractAnchors(url) {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();
  
  try {
    await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 120000 });
    
    const anchors = await page.$$eval('a', anchors => {
      return anchors.map(anchor => {
        const href = anchor.getAttribute('href') || '';
        const text = anchor.textContent.trim();
        const absoluteHref = new URL(href, window.location.href).href;
        
        return {
          text,
          href: absoluteHref,
          isEmpty: !text && !anchor.children.length
        };
      });
    });
    
    await browser.close();
    return anchors;
  } catch (error) {
    console.error('Error extracting anchors:', error);
    await browser.close();
    throw error;
  }
}

function generateHtmlLinks(anchors) {
  return anchors.map(anchor => {
    const safeText = escapeHtml(anchor.text) || '链接';
    const safeHref = escapeHtml(anchor.href);
    return `<a href="${safeHref}" target="_blank">${safeText}</a>`;
  }).join('\n');
}

function escapeHtml(text) {
  if (!text) return '';
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

function openFile(filePath) {
  return new Promise((resolve, reject) => {
    let command;
    
    if (process.platform === 'win32') {
      command = `start "" "${filePath}"`;
    } else if (process.platform === 'darwin') {
      command = `open "${filePath}"`;
    } else {
      command = `xdg-open "${filePath}"`;
    }
    
    exec(command, (error) => {
      if (error) {
        console.error(`无法自动打开文件: ${error.message}`);
        console.log(`请手动打开文件: ${filePath}`);
        reject(error);
      } else {
        console.log(`已在浏览器中打开结果文件: ${filePath}`);
        resolve();
      }
    });
  });
}

async function main() {
  try {
    const url = await new Promise(resolve => {
      readline.question('请输入要提取锚点的URL: ', resolve);
    });
    
    if (!url.startsWith('http')) {
      console.error('请输入有效的URL（需包含 http 或 https 协议）');
      readline.close();
      return;
    }
    
    console.log(`正在提取 ${url} 的锚点链接...`);
    const anchors = await extractAnchors(url);

htmlHeader = `
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://williamkpchan.github.io/maincss.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://williamkpchan.github.io/mainscript.js"></script>

<style>
body { 
  width:80%;
  margin-left:10%;
  background-color: black;
  color: gray;
  justify-content: center;
  align-content: center;
  font-size: 24px;
}
</style>
</head>

<body>
<pre>
`

    const htmlContent = generateHtmlLinks(anchors);

    // Regular expression pattern to match '<a.*?target="_blank">..<\/a>'
    const pattern = /<a.*?target="_blank">..<\/a>/g;
    // Filter the array to remove substrings matching the pattern
    const filteredTxt = htmlContent.replace(pattern, '')

    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const filename = `links-only-${timestamp}.html`;

    wholefile = htmlHeader + filteredTxt
    wholefile = wholefile.replace("(\n){2,}", '\n')
    await fs.writeFile(filename, wholefile);
    console.log(`纯链接HTML文件已保存到 ${filename}`);
    
    await openFile(filename);
  } catch (error) {
    console.error('程序执行出错:', error);
  } finally {
    readline.close();
  }
}

main();  

