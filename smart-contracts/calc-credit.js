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
    directory = "./templates/credit-line"
} else {
    directory = "./" + directory
}

var show_line = function(i) {
    var note = "";
    if (i.note != undefined) {
	note = i.note;
    }
    if (i.event == "Note" ||
       i.event == "Terminate" ||
       i.event == "Action") {
	console.log(i.event,
		    i.on.toDateString(),
		    note);
	return;
    }

    if (i.event ===  "Transfer" ||
       i.event === "Obligation") {
	var actual = i.actual;
	if (actual === undefined) {
	    actual = i.on;
	}
	var item = i.item;
	if (item === undefined) {
	    item = i.item;
	}
	console.log(i.event,
		    i.on.toDateString(),
		    i.from,
		    i.to,
		    Number(i.amount).toFixed(2),
		    i.item,
		    note,
		   actual.toDateString());
	return;

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
}

var Calculator = require("./Calculator.js");
var TermSheet = require(directory + "/TermSheet.js");

var calculator = new Calculator();
calculator.test_wrapper()

console.log("No draws")
var my_term_sheet = new TermSheet();
var calculator = new Calculator()
calculator.set_events(my_term_sheet, {
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



console.log("Credit 1")
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
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

console.log("Credit 2");
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "credit_request":[
    {"on": "2015-08-15",
     "amount": "15000"}
    ]});
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log()

console.log("Credit 3 - Test limit");
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "credit_request":[
    {"on": "2015-08-15",
     "amount": "100000000"}
    ]});
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});
show_apr(calculator, payment_schedule);
console.log();

console.log("Credit 3");
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "payment_arrival" : [
	{"on" : "2015-09-30",
	 "actual" : "2015-11-20"}
    ],
    "credit_request":[
    {"on": "2015-08-15",
     "amount": "15000"},
    {"on": "2015-11-15",
     "amount": "15000"}
    ]});
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});

console.log("Credit 4");
my_term_sheet = new TermSheet();
calculator = new Calculator();
calculator.set_events(my_term_sheet, {
    "late_payment" : [
	{"on" : "2015-11-14",
	 "amount" : "2500"
	}
    ],
    "credit_request":[
    {"on": "2015-08-15",
     "amount": "15000"},
    {"on": "2015-11-15",
     "amount": "15000"}
    ]});
var payment_schedule = calculator.calculate(my_term_sheet);
payment_schedule.forEach(function(i) {
    my_term_sheet.process_payment(i);
    show_line(i)
});

show_apr(calculator, payment_schedule);
console.log()

