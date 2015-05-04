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
		payment_schedule.forEach(function(i) {
		    process_payment(i);
		    var note = "";
		    if (i.note != undefined) {
			note = i.note;
		    }
		    if (i.event == "Note" ||
			i.event == "Terminate") {
			append_span([i.event,
				     i.on.toDateString(),
				     note]);
			output.append("<br>");
		    }

		    if (i.event ===  "Transfer" ||
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
		    }
		});
	    } catch (err) {
		output.html(err.message);
	    }
	});

	this.header = (function () {/*
These explanatory notes do NOT form part of the contract. NO
WARRANTIES AND REPRESENTATIONS ARE GIVEN CONCERNING THE ACCURACY OF
THESE NOTES.  IN CASE OF CONFLICT BETWEEN THESE NOTES AND THE
JAVASCRIPT CODE, THE CODE SHALL PREVAIL.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
	this.terms = (function () {/*
Things that the agent is worried about:
* The agent needs to execute contracts very quickly.
* The agent needs cash flow for overhead.

Things that the investor is worried about:

* The investor worries most of all about getting paid and getting a
  good return.
* The investor worries about getting stuck with a bad apartment and
  being stuck last in line when dealing with a big investor.=
* The investor worries that there are cash flows outside of the
  contract.  In particular, that the agent may be collecting extra money
  from the tenants, or that money may be tunnelled out to large investors.
* The investor is also concerned what happens it some major event
  happens.  An example scenario that would be if in August 2015, Hong
  Kong gets hit with Avian flu.

S.1 starts the contract immediately upon payment of the investment and
overhead fees to the agent.  What will typically happen is that the
agent will give the investor the address of the property and the
landlord rent, and the investor will agree to the contract and
immediately wire over the cash.

Note that there is nothing that requires that the agent wait for the
cash before actually signing the lease.  The agent can sign the lease
using other funds, and if they need additional funds they can execute
the contract with a flat that they have already signed a lease to.
They can even use the contract to get funds on the basis of cash flow
of an apartment that they have already rented.

This contract is designed as a template contract, where the agent and
the investor needs to just "fill in the blanks."  This means that it
would be easy to automate contract execution, and the agent can even
put a page on their web site where investors can press a button send
over the cash.

Also a "fill in the blank" template contract makes it easy to put the
information on a spreadsheet or database.

S.2 splits the payments into two parts.  The first is the initial
investment which includes only the 2 months deposit and the first
months payment.  The other part is an overhead payment which the agent
will keep provided that the contract goes smoothly.  The purpose of
the overhead payment is to make sure that the agent has the cash to
undertake general expenses.

The overhead payment is a fixed amount since it is impossible for a
small investor to track how the agent spends move for general
expenses.  IT IS CRITICAL THAT THE AGENT INSURE THAT THE OVERHEAD
PAYMENT IS ENOUGH TO PAY FOR THEIR GENERAL EXPENSES.  When negotiating
the amount of the overhead payment, it is better if the agent and
investor do not throw numbers back and forth but rather that the agent
determine that payment based on their expected costs.

The fact that the agent gets the overhead fee upfront, is good for the
agent since they have free cash which they are certain they do not
have to return.

S.3 fixes the dates of the payment back to the investor.  This is set
on a fixed date in order to simplify administration for both the
investor and the agent.  Having the cash due based on a variable date
means that the agent has to do a lot of administration which can be
bad if they are in the middle of renting houses.  The date at which
this payment is due is in October, so the process would be that the
agent spends all of their time in July and August making their tenants
happy, and in September and October, they can go through all of the
contracts and see what is due to whom.

Having all of the contracts due on one date is also good for the
investors since they know that should be expecting money on October
15.  Also if something very unexpected happens (i.e. Avian flu) and
the agent runs into cash issues, this should be obvious very quickly
at which point all of the investors can collectively meet with the
agent and decide on what can be done.

S.4 lists the payments.  Note here that the payments are all based on
figures whose numbers can be documented.  Note also that the
definition of the payments also includes all payments made by the
tenant to the agent, which avoids the possibility that the agent could
be pressured to reduce the payout by including other fees.

IMPORTANT NOTE: THE CURRENT CONTRACT ASSUMES THAT AGENT ASSUMES
RESPONSIBLITY FOR A PAYMENT IN YEAR TWO REGARDLESS OF WHETHER OR NOT
THEY HAVE RECEIVED PAYMENT FROM THE TENANT.  THIS ALSO ASSUMES THAT
THE TENANT WILL PAY FOR A FULL 12 MONTHS IN YEAR TWO.  PLEASE
NEGOTIATE IF THESE ASSUMPTIONS ARE NOT TRUE.

S.5 are some remedies in case something goes wrong.  The first remedy
is to terminate the contract with no payments.  The second remedy is
to terminate the contract with a repayment of the initial investment
*AND* the overhead payment.

S.6 says that the investor provides the funds on the initial contract
date.  These funds will normally be used to pay for the deposit and
the administrative expenses.  Note that it is permissible for the
agent to use the funds for other purposes if the deposit has been
paid.  This contract purposely avoids mentioning deposits to avoid
creating new complexities.  As much as possible, the issue of deposits
is an issue between the tenant, the landlord, and the agent with the
investor not involved.

S.7 says that within one week, the agent must provide the investor
with a set of documents from the landlord showing that the flat has
been secured.  If the agent fails to provide those documents, then
they agent is obligated to return all funds.  Note again that there is
nothing to prevent the agent from providing documents from a
pre-existing lease agreement if that lease agreement was funded with
the agents own capital.

S.8 says that within one month, the agent must rent out the flat and
provide the investor with documents.

S.9 provides for two payments.  Both are based on verifiable data. 

REMAINING RISK

The two major risks for the investor are:

* some catastrophic event - Avian flu for example.

* counterparty risk - If the agent declares bankruptcy, then the
investor assumes risk of loss, even if the flat is profitable.  There
are ways of reducing/removing this risk (i.e. including securitized
provisions or creating a trust structure that is bankruptcy remote)
but both create legal complexity.  One balance is to balance the
amount of risk versus the legal costs both in time and money of
creating something more bulletproof.

The major risks for the agent are:

* cash flow problems.  The agent must insure that the overhead fee
that they charge is sufficient to pay for their general expenses.

* second year issues.  The contract as written makes the agent liable
for second year payments even if they cannot find a tenant.

* keeping tenants happy 

*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
