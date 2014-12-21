#!/usr/bin/node

var requirejs = require('requirejs');

requirejs.config({
    //Pass the top-level main.js/index.js require
    //function to requirejs so that node modules
    //are loaded relative to the top-level JS file.
    nodeRequire: require
});

var LoanCalculator = require("./LoanCalculator.js");
var TermSheet = require("./TermSheet.js");

calculator = new LoanCalculator.LoanCalculator();
calculator.test_wrapper()

console.log("Standard Payments")
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues":[],
    "early_payments":[],
    "credit_draws":[]})
calculator = new LoanCalculator.LoanCalculator()
calculator.show_payments(my_term_sheet).forEach(function(i) {
    console.log.apply(console, i);
});
console.log()

console.log("Assume revenue hit on 2015-05-15")
my_term_sheet =  new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
	{"on" : "2015-05-15",
	 "amount" : "800000"}
    ],
    "early_payments":[],
    "credit_draws":[]})
calculator = new LoanCalculator.LoanCalculator()
calculator.show_payments(my_term_sheet).forEach(function(i) {
    console.log.apply(console, i);
});
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15")
my_term_sheet = new TermSheet.TermSheet()
my_term_sheet.set_events({
    "revenues": [
    {"on" : "2015-06-15",
     "amount" : "800000"},
    {"on" : "2015-08-15", 
     "amount" : "800000"}
    ],
    "early_payments":[],
    "credit_draws":[]})
calculator = new LoanCalculator.LoanCalculator()
calculator.show_payments(my_term_sheet).forEach(function(i) {
    console.log.apply(console, i);
});
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws")
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
    {"on" : "2015-06-15",
     "amount" : "800000"},
    {"on" : "2015-08-15",
     "amount" : "800000"}
    ],
    "early_payments":[
    {"on": "2015-04-15",
     "amount": "5000"}
    ],
    "credit_draws":[
    {"on": "2015-06-15",
     "amount": "15000"}
    ]})
calculator = new LoanCalculator.LoanCalculator();
calculator.show_payments(my_term_sheet).forEach(function(i) {
    console.log.apply(console, i);
});
console.log()
console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws.  Skip payment on 2015-09-01");
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
    {"on" : "2015-04-15",
     "amount" : "800000"},
    {"on" : "2015-09-15",
     "amount" : "800000"}
    ],
    "early_payments":[
    {"on": "2015-04-15",
     "amount": "5000"}
    ],
    "credit_draws":[
    {"on": "2015-08-15",
     "amount": "15000"}
    ],
    "skip_principal": [ "2015-09-01"]});
calculator = new LoanCalculator.LoanCalculator();
calculator.show_payments(my_term_sheet).forEach(function(i) {
    console.log.apply(console, i);
});

