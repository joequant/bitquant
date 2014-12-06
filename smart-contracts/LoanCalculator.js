/*  Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
 Licensed under the Simplified BSD License */

var Decimal = require("decimal");
var moment = require("moment");
var YEARFRAC = require("./YEARFRAC.js");
"use strict";
function LoanCalculator() {
    this.events = {};
    this.event_list = [];
    this.current_event = 0;
}

LoanCalculator.prototype.test_wrapper = function() {
    console.log("Hello world");
};

module.exports.LoanCalculator = LoanCalculator;

LoanCalculator.prototype.add_to_event_table = function(func) {
    var o = this;
    return function(param) {
	on = param["on"];
	if (!(on in o.events)) {
	    if (o.event_list.length > 0 && 
		on < o.event_list[o.current_event]) {
		throw "Event already past";
	    }
	    o.event_list.push(on);
	    o.event_list = o.event_list.sort(function(a, b) {
		return new Date(a) - new Date(b);
	    });
	    o.events[on] = [];
	}
	o.events[on].push(function() { return func(param); });
    };
}

LoanCalculator.prototype.prepend_to_event_table = function(func) {
    var o = this;
    return function(param) {
	on = param["on"];
	if (!(on in o.events)) {
	    if (o.event_list.length > 0 && 
		on < o.event_list[o.current_event]) {
		throw "Event already past";
	    }
	    o.event_list.push(on);
	    o.event_list.sort(function(a, b) {
		return new Date(a) - new Date(b);
	    });
	    o.events[on] = [];
	}
	o.events[on].unshift(function() { return func(param); });
    };
}

LoanCalculator.prototype.run_events = function(term_sheet) {
    payment_schedule = [];
    this.currency = term_sheet.currency;
    this.principal = 0.0;
    this.balance = 0.0;
    this.current_event = 0;
    prev_date = undefined;
    while (this.current_event < this.event_list.length) {
	k = this.event_list[this.current_event];
	i = this.events[k];
        if (prev_date !== undefined) {
            interest = this.interest(prev_date,
                                     k) * this.balance;
            this.balance = this.balance + interest;
	    this.balance = Number(this.balance.toFixed("2"));
	}
        i.forEach(function(j){
            payment = j();
            if (payment != undefined) {
                payment_schedule.push(payment);
	    }
	});
        prev_date = k;
	this.current_event++;
    }
    return payment_schedule;
}

LoanCalculator.prototype.show_payments = function(payment_schedule) {
    console.log("type", "payment", "beginning principal",
		"interest", "end_balance");
    payment_schedule.forEach (function(i) {
        console.log(i["event"], i["on"], i.payment,
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

var extract_payment = function(params) {
    if (typeof(params.amount) == "function") {
	payment = params.amount();
    } else {
	payment = params.amount;
    }
    if (payment.hasOwnProperty("amount")) {
	payment = payment.amount;
    }
    if (payment.hasOwnProperty("toNumber")) {
	payment = payment.toNumber();
    }
    return payment;
}

LoanCalculator.prototype.fund = function(params) {
    var o = this;
    
    var _fund = function(params) {
	var payment = extract_payment(params);
	principal = o.principal;
	interest_accrued = o.balance - o.principal;
	o.balance = o.balance + payment;
	o.principal = o.principal + payment;
        retval = {"event":"Funding",
                "on":params.on,
                "payment":payment,
                "principal": o.principal,
                "interest_accrued": interest_accrued,
                "balance":o.balance,
                "note":params.note};
	return(retval);
    }
    this.add_to_event_table(_fund)(params);
}

LoanCalculator.prototype.payment = function(params) {
    var o = this;
    var _payment = function(params) {
	var payment = extract_payment(params);
	principal = o.principal;
	interest_accrued = o.balance - o.principal;
        if (payment > o.balance) {
            payment = o.balance;
	}
        if (payment >  (o.balance-o.principal)) {
            o.principal = o.principal - (payment - o.balance + o.principal);
	}
        o.balance = o.balance - payment;
        if (payment > 0) {
            return {"event":"Payment",
                    "on":params.on,
                    "payment":payment,
                    "principal":principal,
                    "interest_accrued": interest_accrued,
                    "balance":o.balance,
                    "note":params.note}
	}
    }
    if (params.prepend === "true") {
	this.prepend_to_event_table(_payment)(params);
    } else {
	this.add_to_event_table(_payment)(params);
    }
}

LoanCalculator.prototype.amortize = function(params) {
    var o = this;
    var _amortize = function(params) {
	var p = extract_payment(params);
	var npayments = params.payments;
	var on = params.on;
	var forward_date = 
	    moment(on).add(params.interval).toDate();
	payment = o.interest(on, forward_date) / 
	    (1.0 - Math.pow(1 + o.interest(on, forward_date), 
			    -npayments)) * p
	var d = forward_date;
	for (var i=0; i < npayments; i++) {
            if (! (d  in params.skip)) {
		o.payment({"on":d, "amount" : payment, 
			   "note" : params.note,
			   "prepend" : "true"});
	    }
	    d = moment(d).add(params.interval).toDate();
	}
    }
    this.add_to_event_table(_amortize)(params);
}

LoanCalculator.prototype.interest = function(from_date,
					    to_date) {
    var yearfrac = this.year_frac(from_date, to_date);
    var periods = yearfrac * this.term_sheet.compound_per_year;
    return Math.pow((1.0 + this.term_sheet.annual_interest_rate / 
		    this.term_sheet.compound_per_year), periods) - 1.0;
}

LoanCalculator.prototype.year_frac = function(from_date,
					      to_date) {
    if (this.term_sheet.day_count_convention === "30/360US") {
	return YEARFRAC.YEARFRAC(from_date, to_date, 1);
    } else {
	throw "unknown day count convention";
    }
}

LoanCalculator.prototype.remaining_principal = function() {
    o = this;
    return function() { return o.principal; }
}

LoanCalculator.prototype.accrued_interest = function() {
    o = this;
    return function() { return (o.balance - o.principal); }
}

LoanCalculator.prototype.remaining_balance = function() {
    o = this;
    return function() { return(o.balance); }
}

