var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('login', { title: 'Smart Contracts', page_name: 'index' });
});

module.exports = router;