const express = require("express");
const router = express.Router();
const { saveReminder } = require("../controllers/reminderController");

router.post('/reminders', saveReminder);

module.exports = router;
