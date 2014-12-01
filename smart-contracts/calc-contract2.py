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
my_contract.set_events({"revenue_event_date1":None,
                        "revenue_event_date2":None,
                        "early_payments":[],
                        "credit_draws":[]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()

print("Assume revenue hit on 2015-06-15")
my_contract = LoanContract()
my_contract.set_events({"revenue_event_date1":date(2015, 5,15),
                        "revenue_event_date2":None,
                        "early_payments":[],
                        "credit_draws":[]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()
print("Assume revenue hit on 2015-06-15 and 2015-09-15")
my_contract = LoanContract()
my_contract.set_events({"revenue_event_date1":date(2015, 5,15),
                        "revenue_event_date2":date(2015, 9,15),
                        "early_payments":[],
                        "credit_draws":[]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()
print("Assume revenue hit on 2015-06-15 and 2015-09-15 and credit draws")
my_contract = LoanContract()
my_contract.set_events({"revenue_event_date1":date(2015, 5,15),
                        "revenue_event_date2":date(2015, 9,15),
                        "early_payments":[{"on": date(2015,4,15),
                                           "amount": Money(5000, "HKD")}],
                        "credit_draws":[{"on": date(2015,8,15),
                                           "amount": Money(15000, "HKD")}]})
calculator = LoanCalculator.LoanCalculator()
calculator.calculate(my_contract)
print()
