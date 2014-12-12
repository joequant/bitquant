// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define(function() {
function TermSheet() {
// The interest will be 10 percent per annum compounded monthly.
    this.annual_interest_rate = 10.0 / 100.0;
    this.compound_per_year = 12;
// This term sheet will use the 30/360 US day count convention.
    this.day_count_convention = "30/360US";
    this.initial_loan_date = new_date(2014, 12, 20);
    this.currency = 'HKD';
    this.initial_loan_amount = money(50000.00, "HKD");
    this.initial_line_of_credit = money(50000.00, "HKD");
    this.revenue_targets =
	[
	    { "revenue" : money(750000.00, "HKD"), "multiplier" : 0.5},
	    { "revenue" : money(1500000.00, "HKD"), "multiplier" : 1.0},
	];
    this.loan_duration = [ 1, 'year'];
}

TermSheet.prototype.set_events = function(events) {
    this.revenues = events['revenues'];
    this.early_payments = events['early_payments'];
    this.credit_draws = events['credit_draws'];
    if ("skip_principal" in events) {
	this.skip_principal = events['skip_principal'];
    } else {
	this.skip_principal = [];
    }
}

// Any principal amounts in this loan will be paid in Hong Kong
// dollars.  Any accured interest shall be paid in the form of
// Bitcoin with the interest rate calculated in Hong Kong dollars.

TermSheet.prototype.process_payment = function(calc, i) {
    calc.show_payment(i);
    var payment = i.payment;
    var balance_payment = 0.0;
    var interest_payment = 0.0;
    if (i.payment > i.interest_accrued) {
	interest_payment = i.interest_accrued;
	balance_payment = i.payment - i.interest_accrued;
    } else {
	interest_payment = i.payment;
	balance_payment = 0.0;
    }
    console.log("    Pay HKD ", balance_payment);
    console.log("    Pay HKD ", interest_payment, " as XBT");
    
}

TermSheet.prototype.payments = function(calc) {

    // The lender agrees to provide the borrower the initial loan
    // amount on the initial date 
    calc.fund({"on" : this.initial_loan_date,
               "amount" : this.initial_loan_amount,
               "note" : "Initial funding"});

    // The lender agrees to provide up the the line of credit amount
    // for the duration of the loan.
    this.credit_draws.forEach(function (i) {
        calc.fund(i);
    });

    // The borrower agrees to pay back the any remaining principal
    // and accrued interest on the first of the month following the
    // after one year of the date of the loan.
    var final_payment_date =
	following_1st_of_month(calc.add_duration(this.initial_loan_date,
			  [1, 'year']));
    calc.payment({"on":final_payment_date,
                  "amount":calc.remaining_balance(),
                  "note":"Required final payment"});

    // The borrower make early payments at any time.
    this.early_payments.forEach(function(i) {
        calc.payment(i);
    });

    // Standard payments - The borrower intends to pay back the loan
    // over as 8 equal installments and completed in 8 months.  The
    // payback will begin in the 5th month.  

    // However, the borrower is obligated to pay back only the accrued
    // interest with each standard payment

    var payment_function = function(calc, params) {
	var payment = calc.extract_payment(params);
	var principal = calc.principal;
	var interest_accrued = calc.balance - calc.principal;
	if (payment > calc.balance) {
            payment = calc.balance;
	}

	var interest_payment = 0.0;
	var principal_payment = 0.0;

	if (payment > interest_accrued) {
	    interest_payment = interest_accrued;
	    principal_payment = payment - interest_accrued;

	} else {
	    interest_payment = payment;
	    principal_payment = 0.0;
	}

	if (contains(calc.term_sheet.skip_principal, params.on)) {
	    payment = interest_payment;
	    principal_payment = 0.0;
	    params.note = "Principal payment skipped";
	}

	if (payment >  interest_accrued) {
            calc.principal = calc.principal - 
		(payment - calc.balance + calc.principal);
	}
	calc.balance = calc.balance - payment;
	if (payment > 0) {
            return {"event":"Payment",
                    "on":params.on,
                    "payment":payment,
                    "principal":principal,
                    "interest_accrued": interest_accrued,
                    "balance":calc.balance,
                    "note":params.note}
	}

    }
    
    var start_payment_date = 
	following_1st_of_month(
	    calc.add_duration(this.initial_loan_date, [4, "months"]));

    calc.amortize({"on":start_payment_date,
                   "amount": calc.remaining_balance(),
                   "payments" : 8,
                   "interval" : [1, "month"],
		   "payment_func" : payment_function});

    if (this.revenues == undefined) {
	return;
    }

    // Accelerated payment - If the total revenues from the product
    // exceeds the revenue target, the borrower will be required to
    // pay a specified fraction of the outstanding balance in addition
    // to a specified fraction of the interest had the balance been
    // carried to the end of the contract.  This payment will be done
    // within one month after the date the revenue target is reached.

    var i = 0;
    var obj = this;
    this.getTargetHitDates().forEach(function(target_hit_date) {
        if (target_hit_date == undefined) {
            return;
	}
        var multiplier = obj.revenue_targets[i].multiplier;
        var payment_date = 
	    calc.add_duration(target_hit_date, [1, "month"]);
        if (payment_date > final_payment_date) {
            payment_date = final_payment_date;
	}
        calc.add_to_balance(
	    {"on": payment_date,
	     "amount" : 
	     calc.multiply(calc.interest(target_hit_date,
					 final_payment_date,
					 calc.remaining_balance()), 
			   multiplier),
             "note" : "Accelerated interest " + (i+1).toString()}
	);
        calc.payment(
	    {"on" : payment_date,
             "amount" : calc.multiply(calc.remaining_balance(),
				      multiplier),
	     "note" : ("Required payment " + (i+1).toString())});
	i++;
    });
}

// This routine returns the dates at which the targets are hit.

TermSheet.prototype.getTargetHitDates = function () {
    var target_hit_dates = [];
    var total_revenue = 0.0;
    var revenue_idx = 0;
    var obj = this;
    this.revenues.forEach(function(i) {
	if (revenue_idx > obj.revenue_targets.length) {
	    return;
	}
	total_revenue += i.amount.amount;
	if (total_revenue >= obj.revenue_targets[revenue_idx].revenue.amount) {
	    target_hit_dates.push(i['on']);
	}
        revenue_idx = revenue_idx + 1;
    });
    return target_hit_dates;
}

function money(a, b) {
    return {"amount": a, "ccy" : b};
}

function contains(a, obj) {
    for (var i = 0; i < a.length; i++) {
	console.log(a[i], obj, a[i] == obj);
        if (a[i] >= obj && a[i] <= obj) {
            return true;
        }
    }
    return false;
}

function following_1st_of_month(a) {
    if (a.getDate() == 1) {
	return a;
    };
    if (a.getMonth() == 12) {
	return new Date(a.getFullYear() + 1, 0, 1);
    } 
    var retval = new Date(a.getFullYear(), a.getMonth() + 1, 1);
    return retval;
}

function new_date(year, month, day) {
    return new Date(year, month-1, day);
}
return {"TermSheet": TermSheet};
});
