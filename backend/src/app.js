const express = require('express');
const cors = require('cors');
require('dotenv').config();
const chatRoutes = require('./routes/chatRoute');
const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors({ origin: '*' }));
app.use(express.json());


app.use('/api', chatRoutes);

app.listen(PORT,'0.0.0.0', () => console.log(`Server running on http://localhost:${PORT}`));

