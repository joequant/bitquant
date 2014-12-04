var SortedArrayMap = require("collections/sorted-array-map");

function LoanCalculator() {
    this.events = new SortedArrayMap();
}

LoanCalculator.prototype.test_wrapper = function() {
    console.log("Hello world");
};

module.exports.LoanCalculator = LoanCalculator;

LoanCalculator.prototype.add_to_event_table = function(func) {
    var o = this;
    return function(param) {
	on = param["on"];
	if (!(on  in o.events)) {
	    o.events.set(on, []);
	}
	o.events.get(on).push(function() { func(param); });
    };
}

LoanCalculator.prototype.prepend_to_event_table = function(func) {
    var o = this;
    return function(param) {
	on = param["on"];
	if (!(on in o.events)) {
	    o.events.set(on, []);
	}
	o.events.get(on).unshift(function() { func(param); });
    };
}

LoanCalculator.prototype.run_events = function(term_sheet) {
    payment_schedule = [];
    this.currency = term_sheet.currency;
    this.principal = 0.0;
    this.balance = 0.0;
    prev_date = undefined;
    this.events.forEach (function(i) {
        if (prev_date !== undefined) {
            interest = term_sheet.interest(prev_date,
                                           i) * this.balance;
            this.balance = this.balance + interest;
            for (var j in this.events[i]) {
                payment = j();
                if (payment != undefined) {
                    payment_schedule.push(payment);
		}
	    }
            prev_date = i;
	}
    });
    return payment_schedule;
}

LoanCalculator.prototype.show_payments = function(payment_schedule) {
    console.log("type", "payment", "beginning principal",
		"interest", "end_balance");
    payment_schedule.forEach (function(i) {
        console.log(i["event"], i["on"], i["payment"],
                   i["principal"], i["interest_accrued"],
                    i["balance"]);
        if(i['note'] != undefined) {
            console.log("  ", i['note']);
	}
    }
    );
}


LoanCalculator.prototype.calculate = function(term_sheet) {
    this.term_sheet = term_sheet;
    term_sheet.payments(this);
    payment_schedule = this.run_events(term_sheet);
    this.show_payments(payment_schedule);
}

LoanCalculator.prototype.fund = function(params) {
    var _fund = function(params) {
	if (is_callable(params['amount'])) {
	    payment = amount();
	} else {
	    payment = amount;
	}
	principal = self.principal;
	interest_accrued = self.balance - self.principal;    
    }
    this.add_to_event_table(_fund)(params);
}

LoanCalculator.prototype.payment = function(params) {
    var _payment = function(params) {
	if (is_callable(params['amount'])) {
	    payment = amount();
	} else {
	    payment = amount;
	}
	principal = self.principal;
	interest_accrued = self.balance - self.principal;    
    }
    this.add_to_event_table(_payment)(params);
}

LoanCalculator.prototype.amortize = function(params) {
    var _payment = function(params) {
	if (is_callable(params['amount'])) {
	    payment = amount();
	} else {
	    payment = amount;
	}
	principal = self.principal;
	interest_accrued = self.balance - self.principal;    
    }
    this.add_to_event_table(_payment)(params);
}

LoanCalculator.prototype.remaining_principal = function() {
    o = this;
    return function() { o.principal; }
}

LoanCalculator.prototype.accrued_interest = function() {
    o = this;
    return function() { o.balance - o.principal; }
}

LoanCalculator.prototype.remaining_balance = function() {
    o = this;
    return function() { o.balance; }
}


/*
    def accrued_interest(self):
        return lambda : self.balance - self.principal
    def interest(self, start, end, amount):
        return lambda : self.contract.interest(start, end) * amount()
    def multiply(self, a, b):
        return lambda: a() * Decimal(b)
    def remaining_balance(self):
        return lambda : self.balance
*/

/*from __future__ import print_function
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
        prev_event = None
        total_year_frac = Decimal(0.0)
        total_interest = Decimal(0.0)
        for i in payment_schedule:
            if prev_event != None and i['principal'].amount > 0.0:
                year_frac = self.contract.year_frac(prev_event, i['on'])
                interest = Decimal(i['interest_accrued'].amount) / i['principal'].amount
                total_year_frac = total_year_frac + Decimal(year_frac)
                total_interest = total_interest + interest
            prev_event = i['on']
        print("Return %.3f %% " %(total_interest / total_year_frac * Decimal(100.0)))
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
                "interest_accrued": self.balance-self.balance,
                "balance": self.balance,
                "note": note}

    @event_table
    def amortize(self, on,
                 amount,
                 payments,
                 interval,
                 note=None,
                 skip=[]):
        if isinstance(amount, collections.Callable):
            p = amount()
        else:
            p = amount

        payment = self.contract.interest(on,
              on + interval) / \
              Decimal(Decimal(1.0) - (1 + self.contract.interest(on,
                     on+interval)) ** (Decimal(-payments))) * p
        for i in range(1, payments+1):
            if on+interval*i not in skip:
                self.payment_prepend(on+interval * i,
                                     payment, note=note)

*/
