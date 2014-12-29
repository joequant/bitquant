// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

var contract_text = (function () {/*
DRAFT FOR REFERENCE ONLY.  DO NOT EXECUTE.

Contract text: Copyright (c) 2014 Cryptolaw Ltd.  
Javascript code: Copyright (c) 2014 Bitquant Research Laboratories (Asia) Ltd.

Released under terms of the Simplified BSD License.

This FACILITY AGREEMENT is dated ****  

BETWEEN

1) YOYODYNE PROPULSION SYSTEMS Ltd incorporated and registered in Hong
Kong with company number 1234552 whose registered office is at 1600
Pennsylvia Avenue (BORROWER)

2) The BANZAI INSTITUTE incorporated and registered in Hong Kong with
company number 2334455 whose registered office is at 221B Baker Street.
(Lender).

BACKGROUND

The Lender has agreed to provide the Borrower with an unsecured term loan facility of HK$[ ]

AGREED TERMS

1. Definitions
-----------
1.1 The following definitions apply in this Agreement:  
  * Availability Period: the period from and including the date of this Agreement to and including the Final Repayment Date.  
  * BTC Exchange Rate:  the 24-hour average price in USD/BTC as reported for by Quandl (https://www.quandl.com/c/markets/bitcoin-data) for the second business day before the Final Repayment Date converted to HKD with the closing price as reported by Bloomberg (http://www.bloomberg.com/quote/USDHKD:CUR) for the second business day before the Final Repayment Date. 
  * Business Day: a day other than a Saturday, Sunday or public holiday when banks in Hong Kong are open for business.  
  * Event of Default: any event or circumstance listed in clause 10.  
  * Facility: the term loan facility made available under this Agreement.  
  * Final Repayment Date: the date falling on the first annual anniversary of the Commencement Date.  
  * HK$: the lawful currency of Hong Kong.  
  * Hong Kong: the Hong Kong Special Administration Region of the People’s Republic of China.  
  * Loan: the principal amount of the loan made or to be made by the Lender to th**e Borrower under this Agreement or (as the context requires) the principal amount outstanding for the time being of that loan.  

2. Interpretation
--------------
2.1 In this Agreement:
2.1.1 unless the context otherwise requires, words in the singular shall include the plural and in the plural shall include the singular;  
2.1.2 unless the context otherwise requires, a reference to one gender shall include a reference to the other genders; 
2.1.3 a reference to a party shall include that party's successors, permitted assigns and permitted transferees;
2.1.4 a reference to a statute or statutory provision is a reference to it as amended, extended or re-enacted from time to time;
2.1.5 a reference to writing  or written includes mail, fax and e-mail; 
2.1.6 unless the context otherwise requires, a reference to a clause or Schedule is to a clause of, or Schedule to, this Agreement; and
2.1.7 any words following the terms including, include, in particular, for example  or any similar expression shall be construed as illustrative and shall not limit the sense of the words, description, definition, phrase or term preceding those terms.

2.2 The Schedules are written in the javascript, and shall form part of this Agreement and shall have effect as if set out in full in the body of this Agreement. Any reference to this Agreement includes the Schedules. 

2.3 In case of any inconsistency between the body of the Agreement and the Schedules, the body of the Agreement shall prevail, in which case the parties may amend the Schedules in good faith to reflect the body of the Agreement. 

3. Facility
--------
3.1 The Lender grants to the Borrower an unsecured term  loan facility subject to the conditions, of this Agreement.

4. Purpose
-------
4.1 The Borrower shall use all money borrowed under this Agreement for the sole purpose of expanding its business.  
4.2 The Lender is not obliged to monitor or verify how any amount advanced under this Agreement is used.

5. Commencement
------------
5.1 This Agreement shall be deemed to have commenced on the date of this Agreement.

6. Interest
--------

6.1 The Borrower shall pay interest on the Loan at the rate of [10]% per annum.
6.2 Interest (a) shall accrue daily, (b) shall be payable monthly, in arrear, in accordance with Schedule [A] of this Agreement, and (c) shall be paid in bitcoins based on the BTC Exchange Rate.   
6.3 If the Borrower fails to make any payment due under this Agreement on the due date for payment, interest on the unpaid amount shall accrue daily, from the date of non-payment to the date of actual payment (both before and after judgment), at 5% above the rate specified in clause 6.1 [as calculated in accordance with Schedule [C]]. 

7. Costs
-----
7.1 The Lender shall bear all costs and expenses (together with any value added tax on them) that the Lender incurs in connection with the negotiation and preservation and enforcement of the Loan and/or this Agreement.  
7.2 The Borrower shall pay any stamp, documentary and other similar duties and taxes (if any) to which this Agreement may be subject, or give rise and shall indemnify the Lender against any losses or liabilities that it may incur as a result of any delay or omission by the Borrower in paying any such duties or taxes.

8. Repayment
---------
8.1 The Borrower shall repay the Loan as specified in the attached Schedule [B].  
8.2 All payments made by the Borrower under this Agreement shall be made in full, without set-off, counterclaim or condition, and free and clear of, and without any deduction or withholding.

9. Representations, Warranties and Undertakings
--------------------------------------------
9.1 The Borrower represents, warrants and undertakes to the Lender on the date of this Agreement:  
(a) is a duly incorporated limited liability company validly existing under the laws of its jurisdiction of incorporation;  
(b) has the power to enter into, deliver and perform, and has taken all necessary action to authorise its entry into, delivery and performance of, this Agreement; and  
(c) has obtained all required authorisations to enable it to enter into, exercise its rights and comply with its obligations in this Agreement.  

9.2 The entry into and performance by it of, and the transactions contemplated by, this Agreement, do not and will not contravene or conflict with:
(a) its constitutional documents;  
(b) any agreement or instrument binding on it or its assets or constitute a default or termination event (however described) under any such agreement or instrument; or  
(c) any law or regulation or judicial or official order, applicable to it.

9.3 The information, in written or electronic format, supplied by, or on its behalf, to the Lender in connection with this Agreement (including but not limited to the documents set out in Schedule 1) was, at the time it was/will be supplied or at the date it was/will be stated to be given (as the case may be):  
(a) if it was factual information, complete, true and accurate in all material respects;  
(b) if it was a financial projection or forecast, prepared on the basis of recent historical information and on the basis of reasonable assumptions and was fair and made on reasonable grounds; and  
(c) if it was an opinion or intention, made after careful consideration and was fair and made on reasonable grounds; and  
(d) not misleading in any material respect, nor rendered misleading by a failure to disclose other information.

10. Events of Default
-----------------
10.1 Each of the events or circumstances set out in this clause is an Event of Default.  
(i) The Borrower fails to pay any sum payable by it under this Agreement.  
(ii) The Borrower fails (other than by failing to pay), to comply with any provision of this Agreement and (if the Lender considers, acting reasonably, that the default is capable of remedy), such default is not remedied within 7 Business Days of the earlier of:  
(a) the Lender notifying the Borrower of the default and the remedy required;  
(b) the Borrower becoming aware of the default.  
(iii) Any representation, warranty or statement made, repeated or deemed made by the Borrower in, or pursuant to, this Agreement is (or proves to have been) incomplete, untrue, incorrect or misleading when made or deemed made.  
(iv) The Borrower suspends or ceases to carry on (or threatens to suspend or cease to carry on) all or a substantial part of its business.  
(v) The passing of a resolution for the winding up of the Borrower; or the appointment of a receiver, administrator or administrative receiver over the whole or any part of the assets of the Borrower or the making of any arrangement with the creditors of the Borrower for the affairs, business and property of the Borrower to be managed by a supervisor.

11. Amendments, Waivers and Consents and Remedies
---------------------------------------------
11.1 No amendment of this Agreement shall be effective unless it is in writing and signed by, or on behalf of, each party to it (or its authorised representative).  
11.2 A waiver of any right or remedy under this Agreement or by law, or any consent given under this Agreement, is only effective if given in writing by the waiving or consenting party and shall not be deemed a waiver of any other breach or default. It only applies in the circumstances for which it is given and shall not prevent the party giving it from subsequently relying on the relevant provision.  
11.3 A failure or delay by a party to exercise any right or remedy provided under this Agreement or by law shall not constitute a waiver of that or any other right or remedy, prevent or restrict any further exercise of that or any other right or remedy or constitute an election to affirm this Agreement. No election to affirm this Agreement by the Lender shall be effective unless it is in writing. 
11.4 The rights and remedies provided under this Agreement are cumulative and are in addition to, and not exclusive of, any rights and remedies provided by law..  

12. Assignment and transfer
-----------------------
12.1 The Lender may assign any of its rights under this Agreement or transfer all its rights or obligations by novation.  
12.2 The Borrower may not assign any of its rights or transfer any of its rights or obligations under this Agreement.  

13. Counterparts
------------
13.1 This Agreement may be executed in any number of counterparts, each of which when executed shall constitute a duplicate original, but all the counterparts shall together constitute one agreement.  
13.2 No counterpart shall be effective until each party has executed at least one counterpart.  

14. Severance
---------
14.1 If any provision (or part of a provision) of this Agreement is or becomes invalid, illegal or unenforceable, it shall be deemed modified
to the minimum extent necessary to make it valid, legal and enforceable. If such modification is not possible, the relevant
provision (or part of a provision) shall be deemed deleted. Any modification to or deletion of a provision (or part of a provision)
under this clause shall not affect the legality, validity and enforceability of the rest of this Agreement.

15. Notices
-------
15.1 Any notice or other communication given to a party under or in connection with this Agreement shall be:
(a) in writing;
(b) delivered by hand, by pre-paid first-class post or other next working day delivery service or sent by fax; and
(c) sent to:
the Borrower at:
Address: Yoyodyne Propulsion Systems
Email: Bam@aexample.com
Attention:  John Bigboote

the Lender at:
Address:221B Baker Street
Email: drwatson@example.com
Attention:  Dr. Buckaroo Banzai

or to any other address or fax number as is notified in writing by one
party to the other from time to time.

15.2 Any notice or other communication that the Lender gives to the Borrower under or in connection with, this Agreement shall be deemed to have been received:

(a) if delivered by hand, at the time it is left at the relevant address;

(b) if posted by pre-paid first-class post or other next working day delivery service, on the second Business Day after posting; and

(c) if sent by fax or email, when received in legible form.

15.3 A notice or other communication given on a day that is not a Business Day, or after normal business hours, in the place it is received, shall be deemed to have been received on the next Business Day.

15.4 Any notice or other communication given to the Lender shall be deemed to have been received only on actual receipt.

16.Governing law and jurisdiction
------------------------------
16.1 This Agreement and any dispute or claim arising out of or in connection with it or its subject matter or formation (including non-contractual disputes or claims) shall be governed by and construed in accordance with the law of Hong Kong.  

16.2 Each party irrevocably agrees that, subject as provided below, the courts of Hong Kong shall have non-exclusive jurisdiction over any dispute or claim that arises out of, or in connection with this Agreement or its subject matter or formation (including non-contractual disputes or claims). Nothing in this clause shall limit the right of the Lender to take proceedings against the Borrower in any other court of competent jurisdiction, nor shall the taking of proceedings in any one or more jurisdictions preclude the taking of proceedings in any other jurisdictions, whether concurrently or not, to the extent permitted by the law of such other jurisdiction.

This Agreement has been entered into on the date stated at the beginning of it.

*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];

define(function() {
function TermSheet() {
//Contract text
    this.contract_text = contract_text;
// The interest will be 10 percent per annum compounded monthly.
    this.annual_interest_rate = 10.0;
    this.penalty_annual_interest_rate = 10.0 + 5.0;
    this.compound_per_year = 12;
    this.penalty_compound_per_year = 365;
// This term sheet will use the 30/360 US day count convention.
    this.day_count_convention = "30/360US";
    this.initial_loan_date = new_date(2015, 1, 5);
    this.currency = 'HKD';
    this.initial_loan_amount = 50000.00;
    this.additional_credit_limit = 50000.00;
    this.revenue_targets =
	[
	    { "revenue" : 750000.00, "multiplier" : 0.5},
	    { "revenue" : 1500000.00, "multiplier" : 1.0},
	];
    this.loan_duration = [ 1, 'year']

    this.contract_parameters = [
	{
	    name: "annual_interest_rate",
	    display: "Annual percentage rate (%)",
	    type: "number",
	    scenario: true
	},
	{
	    name: "compound_per_year",
	    display: "Compounding periods per year",
	    type: "number",
	    scenario: true
	},
	{
	    name: "day_count_convention",
	    display: "Date Count Convention",
	    type: "text"
	},
	{
	    name: "initial_loan_date",
	    display: "Initial loan date",
	    type: "date",
	    scenario: true
	},
	{
	    name: "initial_loan_amount",
	    display: "Initial loan amount",
	    type: "number"
	},
	{
	    name: "additional_credit_limit",
	    display: "Additional credit limit",
	    type: "number"
	},
	{
	    name: "loan_duration",
	    display: "Loan duration",
	    type: "duration"
	},
	{ 
	    name: "currency",
	    display: "Currency",
	    type: "currency"
	},
	{
	    name: "revenue_targets",
	    display: "Revenue targets",
	    type: "grid",
	    columns: [
		{ name: "revenue",
		  display: "Revenue",
		  type: "number"
		},
		{ name: "multiplier",
		  display: "Multiplier",
		  type: "number"
		}
	    ]
	}
    ];

    this.event_spec = [
	{
	    name: "header",
	    type: "note"
	},
	{
	    name: "standard_payment",
	    type: "note"
	},
	{
	    name: "accelerated_payment",
	    type: "note"
	},
	{
	    name : "revenues",
	    display : "Projected Revenues",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ]
	},
	{
	    name: "early_payments",
	    display : "Early Payments",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ]
	},
	{
	    name: "credit_request",
	    display : "Credit request",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ]
	},
	{
	    name: "skip_principal",
	    display : "Skip principal payment",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' }
	    ],
	    unfilled_value : []
	},
	{
	    name: "missing_payment",
	    display : "Missing payment",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' }
	    ],
	    unfilled_value : []
	}
    ];
}


// Any principal amounts in this loan will be paid in Hong Kong
// dollars.  Any accured interest shall be paid in the form of
// Bitcoin with the interest rate calculated in Hong Kong dollars.

TermSheet.prototype.process_payment = function(i) {
    if (i.event == "Payment") {
	var balance_payment = 0.0;
	var interest_payment = 0.0;
	if (i.payment > i.interest_accrued) {
	    interest_payment = i.interest_accrued;
	    balance_payment = i.payment - i.interest_accrued;
	} else {
	    interest_payment = i.payment;
	    balance_payment = 0.0;
	}
	i.balance_payment = balance_payment;
	i.interest_payment = interest_payment;
    } else {
	i.balance_payment = 0.0;
	i.interest_payment = 0.0;
    }
    return i;
}

TermSheet.prototype.payments = function(calc) {
    // The lender agrees to provide the borrower the initial loan
    // amount on the initial date 
    calc.fund({"on" : this.initial_loan_date,
               "amount" : this.initial_loan_amount,
               "note" : "Initial funding"});

    obj = this;
    this.credit_request.forEach(function (i) {
	i.amount = calc.limit_balance(i.amount, 
				      obj.initial_loan_amount + 
				      obj.additional_credit_limit);
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

    var i = 0;
    var obj = this;
    this.getTargetHitDates().forEach(function(target_hit_date) {
        if (target_hit_date == undefined) {
            return;
	}
        var multiplier = obj.revenue_targets[i].multiplier;
        var payment_date = 
	    following_1st_of_month(calc.add_duration(target_hit_date, [1, "month"]));
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

	total_revenue += i.amount;
	if(total_revenue < obj.revenue_targets[revenue_idx].revenue) {
	    revenue_idx = revenue_idx + 1;
	    return;
	}

	while(total_revenue >= obj.revenue_targets[revenue_idx].revenue) {
	    target_hit_dates.push(i['on']);
	    revenue_idx = revenue_idx + 1;
	    if (revenue_idx >= obj.revenue_targets.length) {
		return;
	    }
	}
    });
    return target_hit_dates;
}

function contains(a, obj) {
    for (var i = 0; i < a.length; i++) {
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
return TermSheet;
});
