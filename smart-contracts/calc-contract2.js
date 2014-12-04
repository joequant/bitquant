#!/usr/bin/node
var LoanCalculator = require("./LoanCalculator.js");
var TermSheet = require("./TermSheet.js");
var moment = require("moment");
var Decimal = require("decimal");

function money(a, b) {
    return {"amount": new Decimal(a), "ccy" : b};
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
	{"on" : moment("2015-05-15"),
	 "amount" : money("800000", "HKD")}
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
    {"on" : moment("2015-06-15"),
     "amount" : money("800000", "HKD")},
    {"on" : moment("2015-09-15"), 
     "amount" : money("800000", "HKD")}
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
    {"on" : moment("2015-06-15"),
     "amount" : money("800000", "HKD")},
    {"on" : moment("2015-09-15"),
     "amount" : money("800000", "HKD")}
    ],
    "early_payments":[
    {"on": moment("2015-04-15"),
     "amount": money("5000", "HKD")}
    ],
    "credit_draws":[
    {"on": moment("2015-09-15"),
     "amount": money(15000, "HKD")}
    ]})
calculator = new LoanCalculator.LoanCalculator();
calculator.calculate(my_term_sheet);
console.log()
console.log("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws.  Skip payment on 2015-09-01");
my_term_sheet = new TermSheet.TermSheet();
my_term_sheet.set_events({
    "revenues": [
    {"on" : moment("2015-06-15"),
     "amount" : money("800000", "HKD")},
    {"on" : moment("2015-09-15"),
     "amount" : money("800000", "HKD")}
    ],
    "early_payments":[
    {"on": moment("2015-04-15"),
     "amount": money(5000, "HKD")}
    ],
    "credit_draws":[
    {"on": moment('2015-08-15'),
     "amount": money(15000, "HKD")}
    ],
    "skip_payments": [ moment('2015-09-01')]});
calculator = new LoanCalculator.LoanCalculator();
calculator.calculate(my_term_sheet);
