var express = require('express');
var router = express.Router();



router.get('/', function(req, res, next) {
  res.render('samples', { title: 'Smart Contracts', page_name: 'samples' });
});

router.get('/contract-sample/:name', function(req, res, next) {
	analyzer = require('../models/templates/'+req.params.name+'/TermSheet');
	data = require('../models/templates/'+req.params.name+'/Data');
	contract = new analyzer();
	contract.data = data;
	res.render('contract-'+req.params.name,{title: 'Smart Contracts', 
		page_name: 'samples', contract: contract});
});

module.exports = router;
