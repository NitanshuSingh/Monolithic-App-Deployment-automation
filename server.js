const express = require('express');
const path = require('path');

const app = express();

app.use(express.static(__dirname));

app.get('*', (_, res) =>
  res.sendFile(path.join(__dirname, 'build'))
);

app.listen(process.env.PORT || 3000);
