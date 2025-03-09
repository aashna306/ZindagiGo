const express = require('express');
const cors = require('cors');
const mongoose = require("mongoose");
require('dotenv').config();
const bodyParser = require("body-parser");
const admin = require("firebase-admin");
const userRoutes = require("./routes/userRoute");
const chatRoutes = require('./routes/chatRoute');
//const reminderRoutes = require('./routes/reminder');
const app = express();


const serviceAccount = require("./config/serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

mongoose.connect(process.env.MONGO_URI);

app.use(cors({ origin: '*' }));
app.use(bodyParser.json());
app.use(express.json());

app.use('/api', chatRoutes);
//app.use('/api', reminderRoutes);
app.use("/api/users", userRoutes);

module.exports = app;