const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('https://pinterest.com');
  await page.screenshot({ path: 'screenshot.png' });
  await browser.close();
})();
