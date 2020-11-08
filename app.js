const fs = require('fs');
const express = require('express')
const app = express()
const port = 3000

app.get('/metrics', (req, res) => {
  let metrics = fs.readFileSync('result.txt');
  res.send(metrics)
})

app.listen(port, () => {
  console.log(`Active monitoring exporter listening on port ${port}`)
})