exports.config = {
  tests: 'checks/*.js',
  output: './output',
  helpers: {
    Puppeteer: {
      url: process.env.BASE_URL,
      show: false,
      windowSize: '1200x900',
      chrome:{
        executablePath: process.env.CHROME_BIN || null,
        args: ['--no-sandbox', '--headless', '--disable-gpu', '--disable-dev-shm-usage']
      }
    }
  }
}