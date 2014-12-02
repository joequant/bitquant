from __future__ import print_function
from datetime import date
from money import Money
from dateutil.relativedelta import relativedelta
from decimal import Decimal
import findates
from money import Money, xrates
import collections
import sortedcontainers


xrates.install('money.exchange.SimpleBackend')
xrates.base = 'USD'
xrates.setrate('HKD', Decimal('7.75'))
xrates.setrate('XBT', Decimal("1.0") / Decimal('350'))

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

def event_table_prepend(func):
    def func_wrapper(*args, **kwargs):
        self = args[0]
        if "on" in kwargs:
            on = kwargs["on"]
        else:
            on = args[1]
        if on not in self.events:
            self.events[on] = []
        self.events[on].insert(0, lambda: func(*args, **kwargs))
    return func_wrapper

class LoanCalculator(object):
    def __init__(self):
        self.events = {}
        self.process_payment_func = self.dump_payment_schedule
    def test_wrapper(self):
        self.test(date(2014, 12, 1))
        print("running events")
        self.run_events()
    def process_payment(self, func):
        self.process_payment_func = func
    @event_table
    def test(self, on):
        print("test result")
        return 2+2;
    def calculate(self, contract):
        self.contract = contract
        self.events = sortedcontainers.SortedDict()
        contract.payments(self)
        payment_schedule = self.run_events(contract)
        self.process_payment_func(payment_schedule)
    def dump_payment_schedule(self, payment_schedule):
        print("type", "payment", "beginning principal",
              "interest", "end_balance")
        for i in payment_schedule:
            print (i["event"], i["on"], i["payment"],
                   i["principal"], i["interest_accrued"],
                   i["balance"])
            if i['note'] != None:
                print ("  ", i['note'])
            if self.currency_interest != self.currency and \
                   i["event"] == "Payment":
                if i["payment"] > i["interest_accrued"]:
                    principal_payment = i['payment'] - i['interest_accrued']
                    interest_payment =  i['interest_accrued']
                else:
                    principal_payment = i['payment'] - i['payment']
                    interest_payment =  i['payment']
                print ("     Pay payment of ", principal_payment)
                print ("     Pay payment of ", interest_payment,
                       " as ", interest_payment.to("XBT"))
    def run_events(self, contract=None):
        payment_schedule = []
        if contract != None:
            self.currency = contract.currency
            if hasattr(contract, "currency_interest"):
                self.currency_interest = contract.currency_interest
            else:
                self.currency_interest = contract.currency
            self.principal = Money(0.0, self.currency)
            self.balance = Money(0.0, self.currency)
        else:
            self.principal = 0.0
            self.balance = 0.0
        prev_date = None
        for k, v in self.events.iteritems():
            if prev_date != None:
                interest = self.contract.interest(prev_date,
                                                  k) * self.balance
                self.balance = self.balance + interest
            for i in v:
                payment = i()
                if payment != None:
                    payment_schedule.append(payment)
            prev_date = k
        return payment_schedule
    @event_table
    def fund(self, on, amount, note=None):
        if isinstance(amount, collections.Callable):
            payment = amount()
        else:
            payment = amount
        principal = self.principal
        interest_accrued = self.balance - self.principal

        self.balance = self.balance + payment
        self.principal = self.principal + payment
        return {"event":"Funding",
                "on":on,
                "payment":payment,
                "principal":principal,
                "interest_accrued": interest_accrued,
                "balance":self.balance,
                "note":note}
    @event_table
    def payment(self, *args, **kwargs):
        return self._payment(*args, **kwargs)
    @event_table_prepend
    def payment_prepend(self, *args, **kwargs):
        return self._payment(*args, **kwargs)
    def _payment(self, on, amount, note=None):
        if isinstance(amount, collections.Callable):
            payment = amount()
        else:
            payment = amount
        principal = self.principal
        interest_accrued = self.balance - self.principal
        if (payment > self.balance):
            payment = self.balance
        if (payment >  (self.balance-self.principal)):
            self.principal = self.principal - (payment - self.balance + self.principal)

        self.balance = self.balance - payment
        if payment > 0:
            return {"event":"Payment",
                    "on":on,
                    "payment":payment,
                    "principal":principal,
                    "interest_accrued": interest_accrued,
                    "balance":self.balance,
                    "note":note}
    @event_table
    def add_to_balance(self, on, amount,
                       note=None):
        if isinstance(amount, collections.Callable):
            payment = amount()
        else:
            payment = amount
        self.balance = self.balance + payment
        return {"event": "Balance add",
                "on": on,
                "payment": payment,
                "principal": self.principal,
                "interest_accrued": 0.0,
                "balance": self.balance,
                "note": note}

    @event_table
    def amortize(self, on,
                 amount,
                 payments,
                 interval,
                 note=None):
        if isinstance(amount, collections.Callable):
            p = amount()
        else:
            p = amount

        payment = self.contract.interest(on,
              on + interval) / \
              Decimal(Decimal(1.0) - (1 + self.contract.interest(on,
                     on+interval)) ** (Decimal(-payments))) * p

        for i in range(1, payments+1):
            self.payment_prepend(on+interval * i,
                                payment, note=note)
    def remaining_principal(self):
        return lambda : self.principal
    def accrued_interest(self):
        return lambda : self.balance - self.principal
    def interest(self, start, end, amount):
        return lambda : self.contract.interest(start, end) * amount()
    def multiply(self, a, b):
        return lambda: a() * Decimal(b)
    def remaining_balance(self):
        return lambda : self.balance

