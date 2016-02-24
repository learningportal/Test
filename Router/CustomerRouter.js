var express = require('express');
var router = express.Router();

// middleware that is specific to this router
router.use(function timeLog(req, res, next) {
  console.log('Time: ', Date.now());
  next();
});

// define the home page route
router.get('/Customer', function(req, res) { 
  var msgGETSucess = "GET operation done successfully";
  // res.setHeader("X-RequestId", req.requestId);
  res.setHeader("X-TescoMessage", msgGETSucess);
  res.status(200).send('Customer home page');
});

router.post('/Customer',function(req,res){
	try{
		var msgGETSucess = "Post operation done successfully";
   
    res.setHeader("X-TescoMessage", msgGETSucess);
	res.status(200).send(req.body);
	}
	catch(err){
		res.setHeader("X-TescoMessage", err);
		res.status(500).send("Error posting data")
	}
	
});

// define the about route
router.get('/about', function(req, res) {
  res.send('About birds');
});

module.exports = router;