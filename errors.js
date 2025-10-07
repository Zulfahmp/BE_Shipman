const express = require('express');
const router = express.Router();
const path = require('path');

router.get('/400', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'errors/400.html'));
});
router.get('/401', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'errors/401.html'));
});
router.get('/402', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'errors/402.html'));
});
router.get('/403', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'errors/403.html'));
});
// router.get('/404', (req, res) => {
//     res.sendFile(path.join(__dirname, 'public', 'errors/4as04.html'));
// });
router.get('/500', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'errors/500.html'));
});

module.exports = router