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

function money(a, b) {
    return {"amount": a, "ccy" : b};
}

function new_date(year, month, day) {
    return new Date(year, month-1, day);
}

calculator = new LoanCalculator.LoanCalculator();
calculator.test_wrapper()

console.log("Standard Payments")
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues":[],
    "early_payments":[],
    "credit_draws":[]})
calculator = new LoanCalculator.LoanCalculator()
calculator.calculate(my_term_sheet)
console.log()

console.log("Assume revenue hit on 2015-05-15")
my_term_sheet =  new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
	{"on" : new_date(2015, 5, 15),
	 "amount" : money(800000, "HKD")}
    ],
    "early_payments":[],
    "credit_draws":[]})
calculator = new LoanCalculator.LoanCalculator()
calculator.calculate(my_term_sheet)
console.log()

console.log("Assume revenue hit on 2015-06-15 and 2015-09-15")
my_term_sheet = new TermSheet.TermSheet()
my_term_sheet.set_events({
    "revenues": [
    {"on" : new_date(2015, 6, 15),
     "amount" : money(800000, "HKD")},
    {"on" : new_date(2015, 8, 15), 
     "amount" : money(800000, "HKD")}
    ],
    "early_payments":[],
    "credit_draws":[]})
calculator = new LoanCalculator.LoanCalculator()
calculator.calculate(my_term_sheet)
console.log()
console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws")
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
    {"on" : new_date(2015, 6, 15),
     "amount" : money(800000, "HKD")},
    {"on" : new_date(2015, 8, 15),
     "amount" : money(800000, "HKD")}
    ],
    "early_payments":[
    {"on": new_date(2015, 4, 15),
     "amount": money(5000, "HKD")}
    ],
    "credit_draws":[
    {"on": new_date(2015, 6, 15),
     "amount": money(15000, "HKD")}
    ]})
calculator = new LoanCalculator.LoanCalculator();
calculator.calculate(my_term_sheet);
console.log()
console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws.  Skip payment on 2015-09-01");
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
    {"on" : new_date(2015, 4, 15),
     "amount" : money(800000, "HKD")},
    {"on" : new_date(2015, 9, 15),
     "amount" : money(800000, "HKD")}
    ],
    "early_payments":[
    {"on": new_date(2015, 4, 15),
     "amount": money(5000, "HKD")}
    ],
    "credit_draws":[
    {"on": new_date(2015, 8, 15),
     "amount": money(15000, "HKD")}
    ],
    "skip_principal": [ new_date(2015, 9, 1)]});
calculator = new LoanCalculator.LoanCalculator();
calculator.calculate(my_term_sheet);

