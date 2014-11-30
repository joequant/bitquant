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

def event_table(func):
    def func_wrapper(*args, **kwargs):
        self = args[0]
        if "on" in kwargs:
            on = kwargs["on"]
        else:
            on = args[1]
        if on not in self.events:
            self.events[on] = []
        self.events[on].append(lambda: func(*args, **kwargs))
    return func_wrapper



class LoanCalculator(object):
    def __init__(self):
        self.events = {}
    def test_wrapper(self):
        self.test(date(2014, 12, 1))
        print("running events")
        self.run_events()
    @event_table
    def test(self, on):
        print("test result")
        return 2+2;
    
    def calculate(self, contract):
        self.currency = contract.currency
        self.principal = Money(0.0, self.currency)
        self.balance = Money(0.0, self.currency)
        self.prev_event_date = None
        self.contract = contract
        self.events = {}
        contract.payments(self)
        self.run_events()
    def run_events(self):
        for k, v in iter(sorted(self.events.iteritems())):
            for i in v:
                i()
    @event_table
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
    @event_table
    def payment(self, *args, **kwargs):
        self._payment(*args, **kwargs)
    def _payment(self, on,
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
    @event_table
    def add_to_balance(self, on, amount):
        def add_balance():
            if isinstance(amount, collections.Callable):
                payment = amount()
            else:
                payment = amount
            self.balance = self.balance + payment
        return add_balance
    @event_table
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
            self._payment(on+interval * i,
                                payment)
    def remaining_principal(self, d2):
        return lambda : self.principal
    def accrued_interest(self, d1):
        return lambda : self.balance - self.principal
    def interest(self, start, end, amount):
        return lambda : self.contract.interest(self, start, end, amount)
    def remaining_balance(self):
        return lambda : self.balance
    def convert_to_ccy(self, a, ccy):
        if isinstance(a, collections.Callable):
            return lambda: a().to(ccy)
        else:
            return a.to(ccy)

