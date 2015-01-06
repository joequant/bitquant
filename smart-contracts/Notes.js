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
Schedule A S.1 states that the interest rate is 10 percent per year,
compounded monthly, using the 30/360US day count convention.  

Schedule A S.2 states that the lender will provide an inital loan
amount of HKD 50,000 on the date of the contract.

Schedule A S.3 states that the borrower may request up to an
additional HKD 50,000 during the duration of the loan.

Schedule A S.4 states that the borrower agrees to pay back the any
remaining principal and accrued interest on the first of the month
following the after one year of the date of the loan. // CHECK ON
THIS.

Schedule A S.5 states that the borrower may make early payments at any
time.

Schedule A S.6 states that any payments will be applied first to late
fees, then to interest, then to principal. In the event that the
borrower fails to make a required payment, the interest will accrue at
5% above the basic interest rate, compounded daily, and will be added
to the required balance.  S.6 also states that the borrower may skip
the a principal payment before the end of the termination of the loan
without penalty. //CHECK ON THIS

Schedule A S.7 describes the standard payments schedule - The borrower
intends to pay back the loan over as 8 equal installments and
completed in 8 months.  The payback will begin in the 5th month.

Schedule A S.8 describes the accelerated payment schedule - If the
total revenues from the product exceeds the revenue target, the
borrower the will be required to pay a specified fraction of the
outstanding balance in addition to a specified fraction of the
interest had the balance been carried to the end of the contract.
This payment will be due on the first of the month on or following one
month after the revenue target is reached or the final payment date,
whichever is first.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
