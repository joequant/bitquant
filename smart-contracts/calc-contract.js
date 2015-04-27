#!/usr/bin/node

"use strict";
var requirejs = require('requirejs');

requirejs.config({
    //Pass the top-level main.js/index.js require
    //function to requirejs so that node modules
    //are loaded relative to the top-level JS file.
    nodeRequire: require
});

var directory = process.argv[2];
if (directory === undefined) {
    directory = "./templates/loan"
} else {
    directory = "./" + directory
}

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
		Number(i.late_balance).toFixed(2),
		Number(i.principal_payment).toFixed(2),
		Number(i.interest_payment).toFixed(2),
		note);
};

var show_apr = function(calculator, payments) {
    console.log("Annual interest rate: " + 
		calculator.apr(payments).toFixed(4) + " percent");
}

var Calculator = require("./Calculator.js");
var TermSheet = require(directory + "/TermSheet.js");

var calculator = new Calculator();
calculator.test_wrapper()

console.log("Standard Payments")
var my_term_sheet = new TermSheet();
var calculator = new Calculator()
calculator.set_events(my_term_sheet, {
    "revenues":[],
    "early_payment":[],
    "credit_request":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
console.log("event", "date",
	    "principal", 
	    "interest",
	    "balance",
	    "late balance",
	    "balance payment",
	    "interest payment",
	    "note");
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log();



console.log("Assume revenue hit on 2015-05-15")
my_term_sheet =  new TermSheet();
calculator = new Calculator()
calculator.set_events(my_term_sheet, {
    "revenues": [
	{"on" : "2015-05-15",
	 "amount" : "800000"}
    ],
    "early_payment":[],
    "credit_request":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15")
my_term_sheet = new TermSheet()
calculator = new Calculator()
calculator.set_events(my_term_sheet, {
    "revenues": [
    {"on" : "2015-06-15",
     "amount" : "800000"},
    {"on" : "2015-08-15", 
     "amount" : "800000"}
    ],
    "early_payment":[],
    "credit_request":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws")
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "revenues": [
    {"on" : "2015-06-15",
     "amount" : "800000"},
    {"on" : "2015-08-15",
     "amount" : "800000"}
    ],
    "early_payment":[
    {"on": "2015-04-15",
     "amount": "5000"}
    ],
    "credit_request":[
    {"on": "2015-06-15",
     "amount": "15000"}
    ]})
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws.  Skip payment on 2015-09-01");
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "revenues": [
    {"on" : "2015-04-15",
     "amount" : "800000"},
    {"on" : "2015-09-15",
     "amount" : "800000"}
    ],
    "early_payment":[
    {"on": "2015-04-15",
     "amount": "5000"}
    ],
    "credit_request":[
    {"on": "2015-08-15",
     "amount": "15000"}
    ],
    "skip_principal": [ 
	{"on": "2015-09-01"}
    ]});
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws.  Skip payment on 2015-09-01");
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "revenues": [
    {"on" : "2015-04-15",
     "amount" : "800000"},
    {"on" : "2015-09-15",
     "amount" : "800000"}
    ],
    "early_payment":[
    {"on": "2015-04-15",
     "amount": "5000"}
    ],
    "credit_request":[
    {"on": "2015-08-15",
     "amount": "100000000"}
    ],
    "skip_principal": [ 
	{"on" :"2015-09-01"}
    ]});
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log();

console.log("Late payment")
var my_term_sheet =  new TermSheet();
var calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "revenues":[],
    "early_payment" :[],
    "late_payment": [
	{"on": "2015-09-01",
	 "amount": "6500"}
    ],
    "credit_request":[]})
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log()

