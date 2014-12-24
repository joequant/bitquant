#!/usr/bin/node

var requirejs = require('requirejs');

requirejs.config({
    //Pass the top-level main.js/index.js require
    //function to requirejs so that node modules
    //are loaded relative to the top-level JS file.
    nodeRequire: require
});

var show_line = function(i) {
    var note = "";
    if (i.note != undefined) {
	note = i.note;
    }
    console.log(i.event,
		i.on.toDateString(),
		Number(i.principal).toFixed(2),
		Number(i.interest_accrued).toFixed(2),
		Number(i.balance).toFixed(2),
		Number(i.balance_payment).toFixed(2),
		Number(i.interest_payment).toFixed(2),
		note);
};

var LoanCalculator = require("./LoanCalculator.js");
var TermSheet = require("./TermSheet.js");

var calculator = new LoanCalculator();
calculator.test_wrapper()

console.log("Standard Payments")
my_term_sheet = new TermSheet();
calculator = new LoanCalculator()
calculator.set_events(my_term_sheet, {
    "revenues":[],
    "early_payments":[],
    "credit_draws":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
console.log("event", "date",
	    "principal", "interest",
	    "balance",
	    "balance payment",
	    "interest payment",
	    "note");
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
console.log()

console.log("Assume revenue hit on 2015-05-15")
my_term_sheet =  new TermSheet();
calculator = new LoanCalculator()
calculator.set_events(my_term_sheet, {
    "revenues": [
	{"on" : "2015-05-15",
	 "amount" : "800000"}
    ],
    "early_payments":[],
    "credit_draws":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15")
my_term_sheet = new TermSheet()
calculator = new LoanCalculator()
calculator.set_events(my_term_sheet, {
    "revenues": [
    {"on" : "2015-06-15",
     "amount" : "800000"},
    {"on" : "2015-08-15", 
     "amount" : "800000"}
    ],
    "early_payments":[],
    "credit_draws":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws")
my_term_sheet = new TermSheet();
calculator = new LoanCalculator();
calculator.set_events(my_term_sheet, {
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
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
console.log()
console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws.  Skip payment on 2015-09-01");
my_term_sheet = new TermSheet();
calculator = new LoanCalculator();
calculator.set_events(my_term_sheet, {
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
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});

