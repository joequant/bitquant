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
Schedule A states that the interest rate is {{annual_interest_rate}}
percent per year, compounded {{compound_per_year}} per year, using the
{{day_count_convention}} day count convention.  The initial loan
amount is {{currency}} {{initial_loan_amount}}.  The credit limit
consists of an additional {{currency}} {{additional_credit_limit}}.

Schedule B states that the late interest rate is
{{late_additional_interest_rate}} percent per annum more than the
standard interest rate.

Schedule C S.1 states that the lender will provide the inital loan
amount on the date of the contract.

Schedule C S.2 states that early payments are allowed.

Schedule C S.3 states that any payments will be applied first to late
fees, then to interest, then to principal. In the event that the
borrower fails to make a required payment, the interest will accrue at
5% above the basic interest rate, compounded daily, and will be added
to the required balance.  S.5 also states that the borrower may skip
the a principal payment before the end of the termination of the loan
without penalty.

Schedule C S.4 The borrower intends to pay back the loan over as {{number_payments}} equal installments with an interval of {{interval}}.  

{{additional_provisions}}
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
