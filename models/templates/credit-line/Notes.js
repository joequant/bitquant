// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
"use strict";


if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define (function() {
    function Notes() {
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
