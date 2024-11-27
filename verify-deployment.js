const puppeteer = require('puppeteer');

async function run() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  const url = process.env.APP_URL;

  await page.goto(url);

  const content = await page.content();

  if (
    !content.includes('Welcome to the portfolio assignment') ||
    !content.includes('This is a simple React setup to use delivery pipeline for the portfolio assignment in IDATA2502') ||
    !content.includes('by Daniel Eikås')
  ) {
    console.error('Application response does not contain the expected content. Deployment verification failed.');
    process.exit(1);
  }

  console.log('Deployment verification successful! The application is running and serving the expected content.');

  await browser.close();
}

run().catch(error => {
  console.error(error);
  process.exit(1);
});
