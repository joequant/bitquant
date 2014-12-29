// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
"use strict";


if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

define (function() {
    function Notes() {
	this.header = (function () {/*
Although the lender represents that the explanatory notes are a good
faith explanation of the terms of the contract, these notes to not
form part of the contract, and in case of a conflict between the code
and these notes, the code shall prevail.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
	this.standard_payment = (function() {/*
Standard payments - The borrower intends to pay back the loan
over as 8 equal installments and completed in 8 months.  The
payback will begin in the 5th month.  

However, the borrower is obligated to pay back only the accrued
interest with each standard payment
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
	this.accelerated_payment = (function() {/*
Accelerated payment - If the total revenues from the product
exceeds the revenue target, the borrower the will be required
to pay a specified fraction of the outstanding balance in
addition to a specified fraction of the interest had the
balance been carried to the end of the contract.  This payment
will be due on the first of the month on or following one month
after the revenue target is reached or the final payment date,
whichever is first.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
	this.additional_credit_limit = (function() {/*
During the operation of this facility, the borrower may request
additional credit up to this limit
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
