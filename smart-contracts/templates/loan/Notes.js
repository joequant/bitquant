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
percent per year, compounded monthly, using the
{{day_count_convention}} day count convention.  The initial loan
amount is {{currency}} {{initial_loan_amount}}.  The credit limit
consists of an additional {{currency}} {{additional_credit_limit}}.
There are two revenue targets for the accelerated payment.  The first
target occurs at HKD 750,000 and causes an accelerated payment of one
half of the loan.  The other target occurs at HKD 1,500,000 and
results an in accelerated payment of the full loan.

Revenue is defined in section 17 of the contract and includes receipts
due to sales of the product and licensing fees resulting from the
product.  The borrower is required to provide monthly updates as to
the receipts of the product, and it inform the lender within three
days if the borrower reasonably believes that the revenue targets has
been hit.

Section 17 of the contract states that Principal shall be paid in
either HKD or XBT.  Interest and late fees must be paid via bitcoin
based on the XBT exchange rate which is defined as the conversion rate
for exchange of bitcoin at either ANXBTC or bitcashout.

Schedule B states that the late interest rate is
{{late_additional_interest_rate}} percent per annum more than the
standard interest rate.

Schedule C S.1 states that the lender will provide the inital loan
amount on the date of the contract.

Schedule C S.2 states that the borrower may request up to an
additional amount up to the credit limit during the duration of the
loan.

Schedule C S.3 states that the borrower agrees to pay back the any
remaining principal and accrued interest on the first of the month
following the after one year of the date of the loan.  This agreement
will terminate following this payment.

Schedule C S.4 states that the borrower may make early payments at any
time.

Schedule C S.5 states that any payments will be applied first to late
fees, then to interest, then to principal. In the event that the
borrower fails to make a required payment, the interest will accrue at
5% above the basic interest rate, compounded daily, and will be added
to the required balance.  S.5 also states that the borrower may skip
the a principal payment before the end of the termination of the loan
without penalty.

Schedule C S.6 describes the standard payments schedule - The borrower
intends to pay back the loan over as 8 equal installments and
completed in 8 months.  The payback will begin in the first 1st of the
month on or after the fifth month after the start of the loan.

Schedule C S.7 describes the accelerated payment schedule - If the
total revenues from the product exceeds the revenue target, the
borrower the will be required to pay a specified fraction of the
outstanding balance in addition to a specified fraction of the
interest had the balance been carried to the end of the contract.
This payment will be due on the first of the month on or following two
weeks after the revenue target is reached or the final payment date,
whichever is first.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
