const express = require('express');
const { loginUser, registerUser, modifyUser } = require('../controllers/userController');

const router = express.Router();

router.post('/login', loginUser);
router.post('/register', registerUser);
router.post('/modify', modifyUser);

module.exports = router;