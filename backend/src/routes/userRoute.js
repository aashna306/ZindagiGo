const express = require("express");
const router = express.Router();
const { saveUser,changeCaretaker } = require("../controllers/userController");

router.post('/saveUser', saveUser);
router.post('/changeCaretaker', changeCaretaker);

module.exports = router;
