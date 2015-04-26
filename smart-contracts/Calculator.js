// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";
if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define(["moment", "./YEARFRAC"], function(moment, YEARFRAC) {
function Calculator() {
}

Calculator.prototype.test_wrapper = function() {
    console.log("Hello world");
};

Calculator.prototype.add_to_event_table = function(func) {
    var o = this;
    return function(param) {
	var on = param["on"];
	if (!(on in o.events)) {
	    if (o.event_list.length > 0 && 
		on < o.event_list[o.current_event]) {
		throw new Error("Event already past" + o.event_list[o.current_event]);
	    }
	    o.event_list.push(on);
	    o.event_list = o.event_list.sort(function(a, b) {
		return new Date(a) - new Date(b);
	    });
	    o.events[on] = [];
	}
	if (param.prepend === "true") {
	    o.events[on].unshift(function() { return func(o, param); });
	} else {
	    o.events[on].push(function() { return func(o, param); });
	}
    };
}

Calculator.prototype.run_events = function(term_sheet) {
    var payment_schedule = [];
    this.currency = term_sheet.currency;
    this.principal = 0.0;
    this.balance = 0.0;
    this.current_event = 0;
    this.late_balance = 0.0;
    this.late_principal = 0.0;
    var obj = this;
    var prev_date = undefined;
    while (this.current_event < this.event_list.length) {
	var k = this.event_list[this.current_event];
	var i = this.events[k];
        if (prev_date !== undefined) {
            var interest = 
		this.compounding_factor(prev_date,
					k,
					term_sheet.annual_interest_rate,
					term_sheet.compound_per_year,
					term_sheet.day_count_convention) * 
		(this.balance - this.late_balance) +
		this.compounding_factor(prev_date,
					k,
					term_sheet.late_annual_interest_rate,
					term_sheet.late_compound_per_year,
					term_sheet.late_day_count_convention) *
		this.late_balance;
            this.balance = this.balance + interest;
	}
        i.forEach(function(j){
            var payment = j();
            if (payment === undefined) {
		return;
	    } else if (payment.constructor === Array) {
		payment.forEach(function(i) {
		    if (payment.late_balance === undefined) {
			payment.late_balance = obj.late_balance;
		    }
		    if (payment.late_principal === undefined) {
			payment.late_principal = obj.late_principal;
		    }
		    payment_schedule.push(payment);
		}
			       );
	    } else {
		if (payment.late_balance === undefined) {
		    payment.late_balance = obj.late_balance;
		}
		if (payment.late_principal === undefined) {
		    payment.late_principal = obj.late_principal;
		}
                payment_schedule.push(payment);
	    }
	});
        prev_date = k;
	this.current_event++;
    }
    return payment_schedule;
}

Calculator.prototype.show_payments = function(term_sheet) {
    var obj = this;
    var payment_schedule = this.calculate(term_sheet);
    var lines = [["type", "payment", "beginning principal",
		"interest", "end_balance"]];
    payment_schedule.forEach (function(i) {
	Array.prototype.push.apply(lines,
				   obj.term_sheet.process_payment(obj, i));
    }
			     );
    return lines;
}

Calculator.prototype.apr = function(payment_schedule) {
    var prev_event = undefined;
    var calc = this;
    var total_interest = 0.0;
    var total_year_frac = 0.0;
    var obj = this;
    payment_schedule.forEach(function(i) {
        if (prev_event != undefined && i['principal'] > 0.0) {
            var year_frac = 
		calc.year_frac(prev_event, i['on'],
			       obj.term_sheet.day_count_convention);
            var interest = i['interest_accrued'] / i['principal'];
            total_year_frac = total_year_frac + year_frac;
            total_interest = total_interest + interest;
	}
        prev_event = i['on'];
    });
    return total_interest / total_year_frac * 100.0;
}

Calculator.prototype.show_payment = function(i) {
    var line = [];
    line.push([i["event"], i["on"], i.payment,
                   i["principal"], i["interest_accrued"],
                    i["balance"]]);
    
    if(i['note'] != undefined) {
        line.push(["  ", i['note']]);
    }
    return line;
}

Calculator.prototype.calculate = function(term_sheet) {
    this.events = {};
    this.event_list = [];
    this.current_event = 0;
    this.term_sheet = term_sheet;
    term_sheet.payments(this);
    return this.run_events(term_sheet);
}

Calculator.prototype.extract_payment = function(params) {
    var payment;
    if (params == undefined) {
	return undefined;
    }
    if (params.hasOwnProperty("amount")) {
	payment = params.amount;
    } else {
	payment = params;
    }
    if (typeof(payment) == "function") {
	payment = payment();
    } 
    if (payment.hasOwnProperty("amount")) {
	payment = payment.amount;
    }
    if (payment.hasOwnProperty("toNumber")) {
	payment = payment.toNumber();
    }
    return payment;
}

Calculator.prototype.fund = function(params) {
    var _fund = function(o, params) {
	var payment = o.extract_payment(params);
	var principal = o.principal;
	var interest_accrued = o.balance - o.principal;
	o.balance = o.balance + payment;
	o.principal = o.principal + payment;
        return {"event":"Funding",
                "on":params.on,
                "payment":payment,
                "principal": o.principal,
                "interest_accrued": interest_accrued,
                "balance":o.balance,
                "note":params.note};
    }
    this.add_to_event_table(_fund)(params);
}

var _payment = function(o, params) {
    var payment = o.extract_payment(params);
    var principal = o.principal;
    var interest_accrued = o.balance - o.principal;
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

Calculator.prototype.payment = function(params) {
    if (params.payment_func === undefined) {
	params.payment_func = _payment;
   }
    this.add_to_event_table(params.payment_func)(params);
}

Calculator.prototype.add_to_balance = function(params) {
    var _payment = function(o, params) {
	var payment = o.extract_payment(params);
        o.balance = o.balance + payment;
        if (payment > 0) {
            return {"event":"Add balance",
                    "on":params.on,
                    "payment":payment,
                    "principal": o.principal,
                    "interest_accrued": 0.0,
                    "balance":o.balance,
                    "note":params.note}
	}
    }
    this.add_to_event_table(_payment)(params);
}

Calculator.prototype.note = function(params) {
    var _payment = function(o, params) {
        return {"event":"Note",
                "note":params.note};
    };
    this.add_to_event_table(_payment)(params);
}

Calculator.prototype.amortize = function(params) {
    if (params.payment_func === undefined) {
	params.payment_func = _payment;
    }
    var _amortize = function(o, params) {
	var p = o.extract_payment(params);
	var npayments = params.payments;
	var on = params.on;
	var forward_date = 
	    o.add_duration(on, params.interval);
	var compounding_factor = 
	    o.compounding_factor(on,
				 forward_date,
				 o.term_sheet.annual_interest_rate,
				 o.term_sheet.compound_per_year,
				 o.term_sheet.day_count_convention);
	var payment = compounding_factor / 
	    (1.0 - Math.pow(1 + compounding_factor, -npayments)) * p
	var d = forward_date;
	for (var i=0; i < npayments; i++) {
	    var payment_info = {};
	    payment_info.on = d;
	    payment_info.amount = payment;
	    payment_info.prepend = true;
	    payment_info.required = 
		params.required;
	    o.add_to_event_table(params.payment_func)(payment_info);
	    d = o.add_duration(d, params.interval);
	}
    }
    this.add_to_event_table(_amortize)(params);
}

Calculator.prototype.set_parameters = function(term_sheet, params) {
    this.set_items(term_sheet, term_sheet.contract_parameters, params);
}

Calculator.prototype.set_events = function(term_sheet, events) {
    this.set_items(term_sheet, term_sheet.event_spec, events);
}

Calculator.prototype.set_items = function(term_sheet, event_spec, events) {
    event_spec.forEach(function(i) {
	if (events[i.name] == undefined &&
	    i.unfilled_value != undefined) {
	    term_sheet[i.name] = i.unfilled_value;
	    return;
	}
	if (events[i.name] == undefined) {
	    return;
	}
	if (i.type == "grid") {
	    var v = events[i.name];
	    term_sheet[i.name] = [];
	    v.forEach(function(row) {
		i.columns.forEach(function (j) {
		    if (row[j.name] == undefined) {
			return;
		    }
		    if (j.type == "date") {
			var vars = row[j.name].split("-");
			row[j.name] =
			    new Date(vars[0], vars[1]-1, vars[2]);
		    } else if (j.name = "amount") {
			row[j.name] = Number(row[j.name]);
		    }
		});
		term_sheet[i.name].push(row);
	    });
	    return;
	} else if (i.type == "date") {
	    var vars = events[i.name].split("-");
	    term_sheet[i.name] =
		new Date(vars[0], vars[1]-1, vars[2]);
	} else if (i.name = "amount") {
	    term_sheet[i.name] = Number(events[i.name]);
	} else {
	    term_sheet[i.name] = events[i.name];
	}
    });
}


Calculator.prototype.compounding_factor = function(from_date,
						       to_date,
						       annual_interest_rate,
						       compound_per_year,
						       day_count_convention) {
    var yearfrac = this.year_frac(from_date, to_date,
				  day_count_convention);
    var periods = yearfrac * compound_per_year;
    return Math.pow((1.0 + annual_interest_rate / 100.0 / 
		     compound_per_year), periods) - 1.0;
}

Calculator.prototype.add_duration = function (date,
						  duration) {
    var d = moment(date);
    d.add.apply(d, duration);
    return d.toDate();
}

Calculator.prototype.interest = function(from_date, to_date,
						  amount) {
    var obj = this;
    return function() {
	return obj.compounding_factor(from_date, 
				      to_date,
				     obj.term_sheet.annual_interest_rate,
				     obj.term_sheet.compound_per_year,
				     obj.term_sheet.day_count_convention) 
	    * amount();
    }
}

Calculator.prototype.year_frac = function(from_date,
					      to_date,
					      day_count_convention) {
    if (day_count_convention === "30/360US") {
	return YEARFRAC.YEARFRAC(from_date, to_date, 0);
    } else if (day_count_convention === "Actual/Actual") {
	return YEARFRAC.YEARFRAC(from_date, to_date, 1);
    } else if (day_count_convention === "Actual/360") {
	return YEARFRAC.YEARFRAC(from_date, to_date, 2);
    } else if (day_count_convention === "Actual/365") {
	return YEARFRAC.YEARFRAC(from_date, to_date, 3);
    } else if (day_count_convention === "30/360EUR") {
	return YEARFRAC.YEARFRAC(from_date, to_date, 4);
    } else {
	throw Error("unknown day count convention");
    }
}

Calculator.prototype.remaining_principal = function() {
    var o = this;
    return function() { return o.principal; }
}

Calculator.prototype.accrued_interest = function() {
    var o = this;
    return function() { return (o.balance - o.principal); }
}

Calculator.prototype.remaining_balance = function() {
    var o = this;
    return function() { return(o.balance); }
}

Calculator.prototype.multiply = function (a, b) {
    var o = this;
    return function() { return o.extract_payment(a) * b };
}

Calculator.prototype.limit_balance = function(a, b) {
    var o = this;
    return function() {
	var request = o.extract_payment(a);
	var limit = o.extract_payment(b);
	if (request + o.principal > limit) {
	    return limit - o.principal ;
	} else {
	    return request;
	}
    }
}

return Calculator;
});
