const express = require('express');
const cors = require('cors');
const mongoose = require("mongoose");
require('dotenv').config();
const bodyParser = require("body-parser");
const admin = require("firebase-admin");
const userRoutes = require("./routes/userRoute");
const chatRoutes = require('./routes/chatRoute');
const medicalRecordRoutes = require('./routes/medicalRecordRoute');
const locationRoutes = require('./routes/location');
const placesRoutes = require('./routes/places');
const routingRoutes = require('./routes/routing');
//const reminderRoutes = require('./routes/reminder');
const fitnessRoutes = require('./routes/fitnessRoute');
const app = express();

//const serviceAccount = require("./config/serviceAccountKey.json");
//admin.initializeApp({
//  credential: admin.credential.cert(serviceAccount),
//});

const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});


MONGO_URI=process.env.MONGO_URI
mongoose
  .connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.error("MongoDB connection error:", err));

app.use(cors({ origin: '*' }));
app.use(bodyParser.json());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Welcome to ZindagiGo API! 🎉');
});
app.use('/api', chatRoutes);
//app.use('/api', reminderRoutes);
app.use("/api/users", userRoutes);
app.use("/api/medical-records", medicalRecordRoutes);
app.use('/api/location', locationRoutes);
app.use('/api/places', placesRoutes);
app.use('/api/routing', routingRoutes);
app.use('/api/fitness', fitnessRoutes);


const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
