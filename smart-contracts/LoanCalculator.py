from __future__ import print_function
from datetime import date
from money import Money
from dateutil.relativedelta import relativedelta
from decimal import Decimal
import findates
from money import Money, xrates
import collections


xrates.install('money.exchange.SimpleBackend')
xrates.base = 'USD'
xrates.setrate('HKD', Decimal('1.0') / Decimal('7.75'))
xrates.setrate('XBT', Decimal('350'))


class LoanCalculator(object):
    def __init__(self):
        pass
    def calculate(self, contract):
        self.currency = contract.currency
        self.principal = Money(0.0, self.currency)
        self.balance = Money(0.0, self.currency)
        self.prev_event_date = None
        self.contract = contract
        contract.payments(self)
    def show_payments(self, contract):
        self.calculate(contract)
    def fund(self, on, amount,
             payment_type=None):
        interest = 0.0
        if self.prev_event_date != None:
            interest = self.contract.interest(self.prev_event_date,
                                   on, self.balance)
            self.balance = self.balance + interest
        if isinstance(amount, collections.Callable):
            payment = amount()
        else:
            payment = amount
        self.balance = self.balance + payment
        self.principal = self.principal + payment
        self.prev_event_date = on
        print("Funding")
        print(on, payment, self.principal, interest, self.balance)
    def payment(self, on,
                amount,
                settlement_ccy=None,
                optional=False):
        interest = 0.0
        if self.prev_event_date != None:
            interest = self.contract.interest(self.prev_event_date,
                                              on,
                                              self.balance)
            self.balance = self.balance + interest
        if isinstance(amount, collections.Callable):
            payment = amount()
        else:
            payment = amount
        if (payment >  (self.balance-self.principal)):
            self.principal = self.principal - (payment - self.balance + self.principal)

        self.balance = self.balance - payment
        self.prev_event_date = on
        print("Payment")
        print(on, payment, self.principal, interest, self.balance)
    def remaining_principal(self, d2):
        return lambda : self.principal
    def accrued_interest(self, d1):
        return lambda : self.balance - self.principal
    def interest(self, start, end, amount):
        return lambda : self.contract.interest(self, start, end, amount)
    def remaining_balance(self):
        return lambda : self.balance
    def add_to_balance(self, on, amount):
        def add_balance():
            if isinstance(amount, collections.Callable):
                payment = amount()
            else:
                payment = amount
            self.balance = self.balance + payment
        return add_balance
    def convert_to_ccy(self, a, ccy):
        if isinstance(a, collections.Callable):
            return lambda: a().to(ccy)
        else:
            return a.to(ccy)
    def amortize(self, on,
                 amount,
                 payments,
                 interval):
        payment = self.contract.interest(on,
                                         on + interval,
                                         self.balance) / \
                                         Decimal(Decimal(1.0) - (1 + self.contract.interest(on,
                                                                                            on+interval,
                                                                                            Decimal(1.0))) ** (Decimal(-payments)))

        for i in range(1, payments+1):
            self.payment(on+interval * i,
                                payment)

