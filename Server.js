var express = require('express');
var bodyParser = require('body-parser');


var router = express.Router();

var app = express();

// parse application/x-www-form-urlencoded 
app.use(bodyParser.urlencoded({ extended: false })) 
// parse application/json 
app.use(bodyParser.json())



var customer = require('./Router/CustomerRouter');
app.use('/', customer);


app.use('/',function(req,res){
	res.send("Welcome to Node API");
});


app.listen(1000,function(req,res){
	console.log("Server runing");
});