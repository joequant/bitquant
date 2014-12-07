#!/usr/bin/node
// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License */

var moment = require("moment");

function money(a, b) {
    return {"amount": a, "ccy" : b};
}

function TermSheet() {
/* The interest will be 10 percent per annum compounded monthly */
    this.annual_interest_rate = 10.0 / 100.0;
    this.compound_per_year = 12;
/* This contract will use the 30/360 US day count convention. */
    this.day_count_convention = "30/360US";
    this.initial_loan_date = new Date(2014, 12, 1);
    this.currency = 'HKD';
    this.initial_loan_amount = money(50000.00, "HKD");
    this.initial_line_of_credit = money(50000.00, "HKD");
    this.accelerated_payment_targets =
	[
	    money(750000.00, "HKD"),
	    money(1500000.00, "HKD")
	];
    this.accelerated_payment_multipliers =
	[0.5, 1.0];
    this.final_payment_date = 
	moment(this.initial_loan_date).add(1, 'year').toDate();
}

TermSheet.prototype.set_events = function(events) {
    this.revenues = events['revenues'];
    this.early_payments = events['early_payments'];
    this.credit_draws = events['credit_draws'];
    if ("skip_payments" in events) {
	this.skip_payments = events['skip_payments'];
    } else {
	this.skip_payments = [];
    }
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
    this.credit_draws.forEach(function (i) {
        loan.fund(i);
    });
    /* The borrower agrees to pay back the any remaining principal
       and accrued interest one year after the loan is issued.*/
    loan.payment({"on":this.final_payment_date,
                  "amount":loan.remaining_balance(),
                  "note":"Required final payment"});

    /* The borrower make early payments at any time. */
    this.early_payments.forEach(function(i) {
        loan.payment(i);
    });

    /* Standard payments - The borrower intends to payback period will
       be separated into 8 installments and completed in 8 months.
       The payback will begin in the 5th month.  However, unless the
       special conditions are triggered, the borrower is required to
       only pay the interest on the loan until the final payment
       date. */
    var start_payment_date = 
	moment(this.initial_loan_date).add(4, "months").toDate();
    loan.amortize({"on":start_payment_date,
                   "amount": loan.remaining_balance(),
                   "payments" : 8,
                   "interval" : moment.duration(1, "month"),
                   "note" : "Optional payment",
                   "skip" : this.skip_payments});

    if (this.revenues == undefined) {
	return;
    }
    /* Accelerated payment - If the total revenues from the product
       exceeds the revenue target, the borrower will be required to
       pay a specified fraction of the outstanding balance in addition
       to a specified fraction of the interest had the balance been
       carried to the end of the contract.  This payment will be done
       within one month after the date the revenue target is
       reached */
    i = 0;
    r = this.getTargetHitDates();
    obj = this;
	r.forEach(function(target_hit_date) {
        if (target_hit_date == undefined) {
            return;
	}
        multiplier = obj.accelerated_payment_multipliers[i];
        payment_date = 
	    moment(target_hit_date).add(1, "month").toDate();
        if (payment_date > obj.final_payment_date) {
            payment_date = obj.final_payment_date;
	}
        loan.add_to_balance({"on": payment_date,
			     "amount" : 
	  loan.multiply(loan.interest_func(target_hit_date,
					   obj.final_payment_date,
					   loan.remaining_balance()), 
			multiplier),
                             "note" : "Accelerated interest " + (i+1).toString()});
        loan.payment({"on" : payment_date,
                      "amount" : loan.multiply(loan.remaining_balance(),
                                               multiplier),
		      "note" : ("Required payment " + (i+1).toString())});
	i++;
    });
}

/* This routine returns the dates at which the targets are hit.*/

TermSheet.prototype.getTargetHitDates = function () {
    target_hit_dates = 
	Array.apply(null, 
		    new Array(this.accelerated_payment_targets)).map(function(){return undefined});
    total_revenue = 0.0;
    revenue_idx = 0;
    obj = this;
    this.revenues.forEach(function(i) {
	if (revenue_idx > obj.accelerated_payment_targets.length) {
	    return;
	}
	date = i['on'];
	total_revenue += i.amount.amount;
	if (total_revenue >= obj.accelerated_payment_targets[revenue_idx].amount) {
	    target_hit_dates[revenue_idx] = i['on'];
	}
        revenue_idx = revenue_idx + 1;
    });
    return target_hit_dates;
}

module.exports.TermSheet = TermSheet;

