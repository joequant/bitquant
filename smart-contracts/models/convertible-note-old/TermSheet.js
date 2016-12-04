// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

var contract_template = (function () {/*
{{header_text}}

This AGREEMENT is dated {{initial_date_string}}

BETWEEN

{{parties_formatted}}

The borrower for the amount of 1,700,000 HKD, hereby promises to pay to the order of ________, a Hong Kong corporation, in lawful currency of Hong Kong.  

1. Definitions
--------------
For purposes of this Note, the following terms shall be defined as follows:  
“Common Stock” means the Company’s commotock  
“Discounted Price Percentage” means seventy percent (80%).
“Fully Diluted Shares” means the number of shares of Common Stock outstanding on a fully diluted basis, assuming the conversion or exchange of all outstanding securities convertible into or exchangeable for Common Stock and assuming exercise of all outstanding options and warrants to purchase Common Stock (or securities convertible into or exchangeable for Common Stock).  
“Price Cap” means $2,500,000.
“Qualified Financing” means the issuance, in a single arms-length transaction or in a series of related arms-length transactions, of shares of Common Stock, or other equity securities of the Company convertible into or exercisable for Common Stock, for an aggregate consideration valued at $250,000 or more, excluding the balance of this Note and any other convertible promissory notes that convert in such transaction.  
“Qualified Financing Investor(s)” means a person, business entity, or group of persons or business entities acting in concert, that purchase shares of Common Stock, or other equity securities of the Company convertible into or exercisable for Common Stock, in a Qualified Financing.  
“Qualified Financing Securities” means the securities that are purchased by the Qualified Financing Investor(s) in the Qualified Financing.
“$” means United States Dollars.
“Underlying Securities” means the shares of Common Stock, or the Qualified Financing Securities into which this Note is converted.
“Maturity Date” means 12 months ahead.

2. Conversion
-------------
(a) If, at any time, a Qualified Financing occurs, note shall be converted into Common Stock, at a conversion price equal to the lessor of (A) the lowest per share purchase price paid by the Qualified Financing Investor(s) multiplied by the Discounted Price Percentage, and (B) the Price Cap divided by the number of Fully Diluted Shares as of immediately prior to the Qualified Financing (including any equity incentive pool to the same transaction documents as the Qualified Financing Investor(s).  
(b) Conversion at Option of Holder at or After Maturity.  If neither a Qualified Financing nor an Extraordinary Event occurs prior to the Maturity Date, the Holder may, at the Holder’s sole discretion and at any time after the Maturity Date, convert all or any part of the principal nd accrued interest outstanding under this Note into (i) shares of Common Stock at a conversion price equal to (A) the product of (x) seventy percent (70%) multiplied by (y) the Price Cap, divided by (B) the number of Fully Diluted Shares as of the conversion date (excluding the shares issuable upon conversion of this Note and any other convertible promissory notes).
(c) Mechanics of Conversion
Before the Holder shall be entitled to receive evidence of the Underlying Securities into which this Note has been converted, the Holder shall surrender this Note duly endorsed, at the office of the Company, and shall give notice stating therein the name or names in which the certificate or certificates for the Underlying Securities are to be issued.  The Company shall, promptly thereafter, issue and deliver to the Holder at the address specified by the Holder, or to the nominee or nominees of the Holder, a certificate or certificates for the Underlying Securities to which the Holder shall be entitled.  Such conversion shall be deemed to have been made immediately prior to the close of business on the date of such notice, and the person or persons entitled to receive the Underlying Securities issuable upon such conversion shall be treated for all purposes as the record holder of such Underlying Securities as of such date.  In connection with any conversion, (i) if applicable, the Holder shall become a party to and shall execute all related Qualified Financing customary documentation, and (ii) the securities issued in connection with such conversion will have legends thereon, and be subject to the restrictions on transfer, set forth in such documentation.

3. Financial Reports
--------------------
For so long as any principal or interest due under this Note remains outstanding, the Company shall furnish to the Holder:
(i)at least thirty (30) days prior to the end of each fiscal year of the Company, a budget for the upcoming fiscal year, together with related projections of income and cash flow;
(ii)within fifteen (15) days after the end of each calendar month, a balance sheet of the Company as of the end of such month, together with a related statement of income and cash flow;
(iii)Within forty-five (45) days after the end of each fiscal quarter of the Company, a quarterly balance sheet of the Company as of the end of such quarterly period, together with a related statement of income and cash flow;
(iv)within ninety (90) days after the end of each fiscal year of the Company, an annual balance sheet of the Company as of the end of such fiscal year, together with a related statement of income and cash flow (financial statements provided pursuant to this Section 7 shall be unaudited and prepared by the Company, except that they shall be review level and prepared by an independent certified public accountant for any year in which the Company has gross revenues of at least $250,000); and
(v)Such other information relating to the Company or any of its subsidiaries or their condition or operations (financial or otherwise) as the Holder may reasonably request from time to time

4. No Impairment
----------------
The Company will not, by amendment of its Certificate of Incorporation or through reorganization, consolidation, merger, dissolution, sale of assets or another voluntary action, avoid or seek to avoid the observance or performance of any of the terms of this Note, but will at all times in good faith assist in the carrying out of all such terms and in the taking of all such action as may be necessary or appropriate in order to protect the rights of the Holder against impairment.

5. Governing Law
----------------
This Note will be governed by and construed under the internal laws of the State of Delaware as applied to agreements among Delaware residents entered into and to be performed entirely within Delaware, without reference to principles of conflict of laws or choice of laws.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];



define(["./Parties"], function(parties) {

function Contract_Text(obj) {
    obj.contract_text = contract_template;
    obj.header_text = (function () {/*
DRAFT FOR REFERENCE ONLY.  DO NOT EXECUTE.

Copyright (c) 2015 Bitquant Research Laboratories (Asia) Ltd.  
Legal text prepared by CryptoLaw (http://crypto-law.com/)

Released under terms of the Simplified BSD License.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    obj.additional_provisions = (function () {/*
					       */}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    parties.set(obj);
};

// SCHEDULES

// SCHEDULE A

function Schedule_A(obj) {
    // S.1
    obj.annual_interest_rate = 10.0;
    obj.compound_per_year = 12;
    obj.day_count_convention = "30/360US";

    obj.initial_date = new_date(2015, 7, 1);
    obj.initial_date_string = obj.initial_date.toDateString();
    obj.interval = [1, "month"];
    obj.currency = 'HKD';
    obj.initial_amount = 97411.00;
    obj.number_payments = 24;
}

// SCHEDULE B

function Schedule_B(obj) {
    obj.late_additional_interest_rate = 5.0;
    obj.late_annual_interest_rate = 10.0 + obj.late_additional_interest_rate;
    obj.late_compound_per_year = 365;
    obj.late_day_count_convention = "30/360US";
}

// SCHEDULE C
function Schedule_C(obj) {
    obj.contract_parameters = [
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
	    name: "initial_date",
	    display: "Initial loan date",
	    type: "date",
	    scenario: true
	},
	{
	    name: "initial_amount",
	    display: "Initial loan amount",
	    type: "number",
	    scenario: true
	},
	{ 
	    name: "number_payments",
	    display: "Number of payments",
	    type: "number",
	    scenario: true
	},
	{ 
	    name: "interval",
	    display: "Interval",
	    type: "duration",
	    scenario: true
	},
	
	{ 
	    name: "currency",
	    display: "Currency",
	    type: "currency",
	    scenario: true
	}
    ];

    obj.event_spec = [
	{
	    name: "early_payment",
	    display : "Early Payments",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ],
	    unfilled_value : []
	},
	{
	    name: "late_payment",
	    display : "Late payment",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ],
	    unfilled_value : []
	}
    ];
    obj.event_spec.push(
	{
	    name: "header",
	    type: "note"
	}
    );
    obj.event_spec.push(
	{
	    name: "terms",
	    type: "note"
	}
    );
}


Schedule_C.prototype.process_payment = function(i) {
    if (i.event == "Payment") {
	var principal_payment = 0.0;
	var interest_payment = 0.0;
	if (i.payment > i.interest_accrued) {
	    interest_payment = i.interest_accrued;
	    principal_payment = i.payment - i.interest_accrued;
	} else {
	    interest_payment = i.payment;
	    principal_payment = 0.0;
	}
	i.principal_payment = principal_payment;
	i.interest_payment = interest_payment;
    } else {
	i.principal_payment = 0.0;
	i.interest_payment = 0.0;
    }
    return i;
}

Schedule_C.prototype.payments = function(calc) {
    // S.1
    calc.fund({"on" : this.initial_date,
               "amount" : this.initial_amount,
               "note" : "Initial funding"});

    // S.2
    this.early_payment.forEach(function(i) {
        calc.payment(i);
    });


    // S.3
    var payment_function = function(calc, params) {
	var payment = calc.extract_payment(params);

	var principal = calc.principal;
	var late_balance = calc.late_balance;
	var interest_accrued = calc.balance - calc.principal;

	if (payment > calc.balance) {
            payment = calc.balance;
	}
	payment = payment + late_balance;
	var required_payment = calc.extract_payment(params.required);
	if (required_payment === undefined) {
	    required_payment = payment;
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

	if (contains(calc.term_sheet.late_payment, params.on)) {
	    var late_payment = 
		contains(calc.term_sheet.late_payment, params.on).amount;
	    if (late_payment > payment) {
		payment = 0.0;
	    } else {
		payment = payment - late_payment;
	    }
	    params.note = "Late payment";
	}
	
	calc.balance = calc.balance - payment;

	if (payment >=  interest_accrued) {
	    calc.principal = calc.principal - payment + interest_accrued;
	}

	if (payment < late_balance) {
	    calc.late_balance = calc.late_balance - payment;
	} else {
	    calc.late_balance = 0.0;
	}

	if (payment < required_payment) {
	    calc.late_balance = calc.late_balance + required_payment - 
		payment;
	}
	if (payment > 0 || calc.late_balance > 0) {
            return {"event":"Payment",
                    "on":params.on,
                    "payment":payment,
                    "principal":principal,
                    "interest_accrued": interest_accrued,
                    "balance":calc.balance,
		    "late_balance" : calc.late_balance,
                    "note":params.note}
	}

    }

    // S.4
    var start_payment_date = this.initial_date;
    var first_payment_date =
	following_1st_of_month_exclusive(this.initial_date);

    calc.amortize({"on":start_payment_date,
		   "first_payment_date" : first_payment_date,
                   "amount": calc.remaining_balance(),
                   "payments" : this.number_payments,
                   "interval" : this.interval,
		   "payment_func" : payment_function});

    if (this.revenues == undefined) {
	return;
    }

}

function contains(a, obj) {
    for (var i = 0; i < a.length; i++) {
        if (a[i].on >= obj && a[i].on <= obj) {
            return a[i];
        }
    }
    return undefined;
}

function following_1st_of_month_exclusive(a) {
    if (a.getMonth() == 12) {
	return new Date(a.getFullYear() + 1, 0, 1);
    } 
    var retval = new Date(a.getFullYear(), a.getMonth() + 1, 1);
    return retval;
}

function new_date(year, month, day) {
    return new Date(year, month-1, day);
}

function TermSheet() {
    Contract_Text(this);
    Schedule_A(this);
    Schedule_B(this);
    Schedule_C(this);
}

["process_payment", "payments", "getTargetHitDates"].map(function(i) {
    TermSheet.prototype[i] = Schedule_C.prototype[i];
});

return TermSheet;
});
