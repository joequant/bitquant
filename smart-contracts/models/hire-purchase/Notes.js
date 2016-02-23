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
Schedule 1 states that lessor will pay {{number_payments}} payments at an interest rate of {{annual_interest_rate}} against an initial amount of {{initial_amount}} for {{equipment}}.  The lessor may take ownership of the equipment at anytime during the lease period by paying off the balance of the loan.
  
The lessor agrees that the loan made between Bitquant Research Laboratories (Asia) Limited and lessee dated 26 November 2014 which was assigned to the lessor shall be deemed to be paid off if lessee pays the lessor the difference between the amount of that loan and the initial value of this agreement which is the sum of 33200 HKD.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
