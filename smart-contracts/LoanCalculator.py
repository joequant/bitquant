from datetime import date
from money import Money
from dateutil.relativedelta import relativedelta
from decimal import Decimal
import findates

class LoanCalculator(object):
    def __init__(self):
        self.principal = None
        self.interest = None
    def calculate(self, contract):
        self.currency = contract.currency
        self.principal = Money(0.0, self.currency)
        self.interest = Money(0.0, self.currency)
        self.prev_event_date = None
        self.contract = contract
        contract.payments(self)
    def show_payments(self, contract):
        self.calculate(contract)
    def fund(self, on, amount,
             payment_type=None):
        if callable(amount):
            payment = amount()
        else:
            payment = amount
        if self.prev_event_date != None:
            self.interest = self.interest + \
                 self.contract.interest(self.prev_event_date,
                                   on,
                                   (self.principal + self.interest))
        self.prev_event_date = on
        self.principal = self.principal + payment
        print "Funding"
        print on, payment, self.principal, self.interest
    def payment(self, on,
                amount,
                payment_type=["principal"],
                settlement_ccy=None,
                optional=False):
        if callable(amount):
            payment = amount()
        else:
            payment = amount
        if self.prev_event_date != None:
            self.interest = self.interest + \
                 self.contract.interest(self.prev_event_date,
                                   on,
                                   (self.principal + self.interest))
        self.prev_event_date = on
        if "principal" in payment_type:
            self.principal = self.principal - payment
        if "interest" in payment_type:
            self.interest = self.interest - payment
        print "Payment"
        print on, payment, self.principal, self.interest

    def remaining_principal(self, d2):
        return lambda : self.principal
    def accrued_interest(self, d1):
        return lambda : self.interest

