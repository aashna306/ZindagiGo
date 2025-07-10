const express = require("express");
const router = express.Router();
const { saveUser,changeCaretaker,login } = require("../controllers/userController");

router.post('/saveUser', saveUser);
router.post('/changeCaretaker', changeCaretaker);
router.post('/login', login);


module.exports = router;
