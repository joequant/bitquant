#!/usr/bin/node

/*
Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var Decimal = require("./decimal.js");
var moment = require("./moment.js");

function TermSheet() {
    this.annual_interest_rate = 10.0 / 100.0;
    this.initial_loan_date = moment("2014-12-01");
    this.current = 'HKD';
    this.inital_loan_amount = 
	{"amount" : new Decimal("50000.00"), "ccy": "HKD"};
    this.inital_line_of_credit = 
	{"amount" : new Decimal("50000.00"), "ccy": "HKD"};
    this.accelerated_payment_targets =
	[
	    {"amount" : new Decimal("750000.00"), "ccy": "HKD"},
	    {"amount" : new Decimal("1500000.00"), "ccy" : "HKD"}
	];
    this.accelerated_payment_multipliers =
	[0.5, 1.0];
    this.final_payment_date = this.initial_loan_date.add(1, 'year');
}

TermSheet.prototype.setEvents = function(events) {
    this.revenues = events['revenues'];
    this.early_payments = events['early_payments'];
    this.credit_draws = events['credit_draws'];
    if ("skip_payments" in events) {
	this.skip_payments = events['skip_payments'];
    } else {
	this.skip_payments = [];
    }
}

/* The interest will be 10 percent per annum compounded monthly */
TermSheet.prototype.interest = function(from_date,
					to_date) {
    /* yearfrac = self.year_frac(from_date, to_date)
        months = yearfrac * 12
        return Decimal((1.0 + \
        self.annual_interest_rate / 12.0) ** months - 1.0) */
}

/* This contract will use the 30/360 US day count convention. */
TermSheet.prototype.year_frac = function(from_date,
					 to_date) {
/*         return findates.daycount.yearfrac(from_date,
                                          to_date,
                                          "30/360 US")
*/
}

TermSheet.prototype.payments = function(loan) {
    /* Any principal amounts in this loan will be paid in Hong Kong
       dollars.  Any accured interest shall be paid in the form of Bitcoin
       with the interest rate calculated in Hong Kong dollars */
    this.currency_interest = "XBT";
    /* The lender agrees to provide the borrower the initial loan
        amount on the initial date */
    loan.fund({"on" : this.initial_loan_date,
               "amount" : this.initial_loan_amount,
               "note" : "Initial funding"});

    /* The lender agrees to provide up the the line of credit amount
       for the duration of the loan. */
    for (i in this.credit_draws) {
        loan.fund(i);
    };
    /* The borrower agrees to pay back the any remaining principal
       and accrued interest one year after the loan is issued.*/
    loan.payment({"on":this.final_payment_date,
                  "amount":loan.remaining_balance(),
                  "note":"Required final payment"});

    /* The borrower make early payments at any time. */
    for (i in self.early_payments) {
        loan.payment(i);
    };

    /* Standard payments - The borrower intends to payback period will
       be separated into 8 installments and completed in 8 months.
       The payback will begin in the 5th month.  However, unless the
       special conditions are triggered, the borrower is required to
       only pay the interest on the loan until the final payment
       date. */
    start_payment_date = this.initial_loan_date; // + relativedelta(months=4)
    loan.amortize({"on":start_payment_date,
                   "amount": loan.remaining_balance(),
                   "payments" : 8,
                   "interval" : relativedelta(months=1),
                   "note" : "Optional payment",
                   "skip" : this.skip_payments});
    
    if (this.revenues == undef || this.bonus_targets == undef) {
	return;
    }
    /* Accelerated payment - If the total revenues from the product exceeds the
       bonus target, the borrower will be required to pay a
       specified fraction of the outstanding balance in addition to a
       specified fraction of the interest had the balance been
       carried to the end of the contract.  This payment will be done
       within one month after the date the bonus target is reached */
    i = 0;
    for (bonus_date in enumerate(self.getTargetHitDates())) {
        if (bonus_date == undef) {
            break;
	}
        multiplier = this.accelerated_payment_multiplers[i];
        payment_date = bonus_date.add(1, "month");
        if (payment_date > this.final_payment_date) {
            payment_date = this.final_payment_date;
	}
        loan.add_to_balance({"on": payment_date,
			     "amount" : 
			     loan.multiply(loan.interest(bonus_date,
							 this.final_payment_date,
							 loan.remaining_balance()), multiplier),
                             "note" : ("Required bonus payment %d" % (i+1))});
        loan.payment({"on" : payment_date,
                      "amount" : loan.multiply(loan.remaining_balance(),
                                               bonus_multiplier),
		      "note" : ("Required bonus payment %d" % (i+1))});
    }
}

/* This routine returns the dates at which the bonus
   targets are hit.*/

TermSheet.prototype.getTargetHitDates = function () {
    bonus_dates = 
	Array.apply(null, 
		    new Array(this.accelerated_payment_targets)).map(function(){return undef});
    total_revenue = 0.0;
    revenue_idx = 0;
    for (i in this.revenues) {
	if (revenue_idx > self.accelerated_payment_targets.length) {
	    break;
	}
	date = i['on'];
	total_revenue += i['amount']['amount'];
	if (total_revenue >= self.accelerated_targets[revenue_idx]) {
	    bonus_dates[revenue_idx] = i['on'];
            revenue_idx = revenue_idx + 1;
	}
        return bonus_dates;
    }
}

test = TermSheet();
