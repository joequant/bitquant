// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
"use strict";


if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define (function() {
    function Notes() {
	this.report = (function (payment_schedule,
                                  calculator,
                                  process_payment,
                                  output) {
	    try {
		var append_span = function(info) {
		    output.append(info.join(" - "));
		};

		output.html("");
		output.append("<span class='block'>event</span>");
		output.append("<span class='date-block'>date</span>");
		output.append("<span class='block'>principal</span>");
		output.append("<span class='block'>fees</span>");
		output.append("<span class='block'>balance</span>");
		output.append("<span class='block'>late balance</span>");
		output.append("<span class='block'>principal payment</span>");
		output.append("<span class='block'>fee payment</span>");
		output.append("<br>");

		payment_schedule.forEach(function(i) {
		    process_payment(i);
		    var note = "";
		    if (i.note != undefined) {
			note = i.note;
		    }
		    if (i.event == "Note" ||
			i.event == "Terminate" ||
		        i.event == "Action" ) {
			output.append("<span class='block'>" +
				      i.event + "</span>");
			output.append("<span class='date-block'>" +
				      i.on.toDateString() + "</span>");
			output.append("<span>" +
				      note + "</span>");
			output.append("<br>");
		    } else if (i.event ===  "Transfer" ||
			i.event === "Obligation") {
			var actual = i.actual;
			if (actual === undefined) {
			    actual = i.on;
			}
			var actor = i.from;
			if (i.to !== undefined) {
			    actor = actor + " -> " + i.to;
			}
			var list = [i.event,
				    i.on.toDateString(),
				    actor];
			if (i.amount !== undefined) {
			    list.push(Number(i.amount).toFixed(2));
			}
			if (i.item  !== undefined) {
			    list.push(i.item);
			}
			if (i.note !== undefined) {
			    list.push(i.note);
			}
			append_span(list);
			output.append("<br>");
		    } else {
			output.append("<span class='block'>" +
				i.event + "</span><span class='date-block'>" +
				i.on.toDateString() + "</span><span class='number block'>" +
				Number(i.principal).toFixed(2) +
	"</span><span class='number block'>" +
				Number(i.interest_accrued).toFixed(2)
				+ "</span><span class='number block'>" +
				Number(i.balance).toFixed(2)
				+ "</span><span class='number block'>" +
				Number(i.late_balance).toFixed(2)
				+ "</span><span class='number block'>" +
				Number(i.principal_payment).toFixed(2)
				+ "</span><span class='number block'>" +
				Number(i.interest_payment).toFixed(2)
				+ "</span><span>" +
				note + "</span><br>");
		    }
		});
		var myElements = document.querySelectorAll(".block");
 
		for (var i = 0; i < myElements.length; i++) {
		    myElements[i].style.width = "80px";
		    myElements[i].style.display = "inline-block";
		}

		myElements = document.querySelectorAll(".date-block");
		for (var i = 0; i < myElements.length; i++) {
		    myElements[i].style.width = "120px";
		    myElements[i].style.display = "inline-block";
		}
	    } catch (err) {
		output.html(err.message);
	    }
	});
   
	this.header = (function () {/*
The lender represents that the explanatory notes are a good faith
explanation of the terms of the agreement entered into by the parties.

Nevertheless, these explanatory notes do not form part of the
contract, and in case of a conflict between the code and these notes,
the code shall prevail.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
	this.terms = (function () {/*
Schedule A states that there is no time based interest rate, and that
the total credit limit for the duration of the credit line is HKD
{{credit_limit}}.

Section 17 of the contract states that Principal shall be paid in
either HKD or XBT.  Interest and late fees must be paid via bitcoin
based on the XBT exchange rate which is defined as the conversion rate
for exchange of bitcoin at either ANXBTC or bitcashout.

Schedule B states that the late interest rate is
{{late_additional_interest_rate}} percent per annum.

Schedule C S.1 states that the lender will provide a payment on
request up to the maximum credit limit.

Schedule C S.2 states that if the borrower misses a deadline that
there will be a late interest charge due immediately.

Schedule C S.3 states that the borrower agrees to pay back the any
remaining balance and a finance charge of {{finance_charge}} percent,
each quarter.  This payment will normally be due 45 days after the end
of the quarter.  In the event, that the borrower fails to receive a
grant payment from the HKSAR government, this deadline will be
extended to three days after the borrower receives the grant payment
or 90 days after the end of the quarter.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
