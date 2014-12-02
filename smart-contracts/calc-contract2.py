#!/usr/bin/python
from __future__ import print_function
from datetime import date
from money import Money
from dateutil.relativedelta import relativedelta
from decimal import Decimal
import findates
from ContractRevenue import LoanContract
import LoanCalculator

calculator = LoanCalculator.LoanCalculator()
calculator.test_wrapper()
exit

print("Standard Payments")
my_contract = LoanContract()
my_contract.set_events({
    "revenues":[],
    "early_payments":[],
    "credit_draws":[]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()

print("Assume revenue hit on 2015-05-15")
my_contract = LoanContract()
my_contract.set_events({
    "revenues": [
    {"on" : date(2015, 5,15), "amount" : Money("800000", "HKD")}
    ],
    "early_payments":[],
    "credit_draws":[]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()
print("Assume revenue hit on 2015-06-15 and 2015-09-15")
my_contract = LoanContract()
my_contract.set_events({
    "revenues": [
    {"on" : date(2015, 6,15), "amount" : Money("800000", "HKD")},
    {"on" : date(2015, 9,15), "amount" : Money("800000", "HKD")}
    ],
    "early_payments":[],
    "credit_draws":[]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()
print("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws")
my_contract = LoanContract()
my_contract.set_events({
    "revenues": [
    {"on" : date(2015, 6,15), "amount" : Money("800000", "HKD")},
    {"on" : date(2015, 9,15), "amount" : Money("800000", "HKD")}
    ],
    "early_payments":[
    {"on": date(2015,4,15), "amount": Money(5000, "HKD")}
    ],
    "credit_draws":[
    {"on": date(2015,8,15), "amount": Money(15000, "HKD")}
    ]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()
