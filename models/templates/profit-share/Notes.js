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

		var calc_out = calculator.output
		var num_out = function(header, n) {
		    output.append(header + ": ");
		    output.append(Number(n).toFixed(2));
		    output.append("<br>");
		}

		output.append("<h3>Analysis</h3>");
		num_out("Initial investor payment",
			calc_out.initial_investor_payment);
		num_out("year1_return_to_investor",
			calc_out.year1_return_to_investor);
		num_out("year1_return_to_manager",
			calc_out.year1_return_to_manager);
		num_out("year2_return_to_investor",
			calc_out.year2_return_to_investor);
		num_out("year2_return_to_manager",
			calc_out.year2_return_to_manager);
	    } catch (err) {
		output.html(err.message);
	    }
	});

	this.header = (function () {/*
<h3>Explanatory Notes</h3>
These explanatory notes do NOT form part of the contract. NO
WARRANTIES AND REPRESENTATIONS ARE GIVEN CONCERNING THE ACCURACY OF
THESE NOTES.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
	this.terms = (function () {/*
Interests
--------
Things that the manager is worried about:
The agent needs to execute contracts very quickly.
The agent needs cash flow for overhead.
Things that the investor is worried about:
The investor worries most of all about getting paid and getting a good return.
The investor worries about getting stuck with a bad apartment and being stuck last in line when dealing with a big investor.=
The investor worries that there are cash flows outside of the  contract.  In particular, that the agent may be collecting extra money from the tenants, or that money may be tunnelled out to large investors.
The investor is also concerned what happens it some major event happens.  An example scenario that would be if in August 2015, Hong  Kong gets hit with Avian flu.

Trust Structure
---------------
This agreement creates a trust as a legal entity to hold the funds that go into the apartment.  This insures that the funds are legally separate from the funds of the manager, and therefore cannot be taken if the manager becomes insolvent.  The trust is stand-alone and is distinct from any agreements that the manager has made with third parties.  
In the present agreement, the settlor, the investor, and the beneficary are the same party, and the manager and the trustee are also the same party.  This is not a requirement, and the agreement was specifically designed so that these roles can be taken by different people.
The agreement places all of the funds from the tenant into the trust, but allows the trustee to withdraw funds for the manager once the trust contains enough funds to satisfy the payment requirements.
In addition the trust is designed to be scalable and fault tolerant.  There is no reason a large number of these trusts can't be created, and if there is a flaw in one agreement, subsequent agreements can be revised.
In addition because the trust is a separate legal entity that distributes all of its income, the taxes are put in the hands of the beneficiary and the manager.

Template Agreement Execution
----------------------------
This agreement is intended to be executed very quickly.  Typically, the manager will simply e-mail the settlor stating that they wish to agree to the template agreement with the following parameters filled in, and the settlor can agree by immediately transfering the money.

Use of funds
------------
The agreement puts any funds from the flat into the trust, but allows the manager to immediately withdraw any excess.

Rollover option
---------------
Once the deposit has been recovered on one flat, the trust agreement allows that deposit to be immediately used to create new agreements for another flat.

Administration
--------------
This agreement is unusual in that it allows for the trustee to store the funds in a normal business account.  The reason for this is that the trustee is likely to be dealing with dozens of agreements, and the administrative cost for requiring a separate account is high.  However, the agreement allows for the beneficiary to force the trustee to place funds into a segregated account if it becomes necessary.

Schedule of payments
--------------------
S.1 starts the contract immediately upon payment of the investment and overhead fees to the agent.  What will typically happen is that the agent will give the investor the address of the property and the landlord rent, and the investor will agree to the contract and immediately wire over the cash.  
Note that there is nothing that requires that the manager wait for the cash before actually signing the lease.  The manager can sign the lease using other funds, and if they need additional funds they can execute the contract with a flat that they have already signed a lease to. They can even use the contract to get funds on the basis of cash flow of an apartment that they have already rented.  
S.2 splits the payments into two parts.  The first is the initial investment which includes only the 2 months deposit and the first months payment.  The other part is an overhead payment which the agent will keep provided that the contract goes smoothly.  The purpose of the overhead payment is to make sure that the agent has the cash to undertake general expenses.  
The overhead payment is a fixed amount since it is impossible for a small investor to track how the agent spends move for general expenses.  IT IS CRITICAL THAT THE AGENT INSURE THAT THE OVERHEAD PAYMENT IS ENOUGH TO PAY FOR THEIR GENERAL EXPENSES.  When negotiating the amount of the overhead payment, it is better if the agent and investor do not throw numbers back and forth but rather that the agent determine that payment based on their expected costs.  
The fact that the agent gets the overhead fee upfront, is good for the agent since they have free cash which they are certain they do not have to return.  
S.3 fixes the dates and amounts of the payment back to the investor.  This is set on a fixed date in order to simplify administration for both the investor and the agent.  Having the cash due based on a variable date means that the agent has to do a lot of administration which can be bad if they are in the middle of renting houses.  The date at which this payment is due is in October, so the process would be that the agent spends all of their time in July and August making their tenants happy, and in September and October, they can go through all of the contracts and see what is due to whom.  
Having all of the contracts due on one date is also good for the investors since they know that should be expecting money on October 1.  Also if something very unexpected happens (i.e. Avian flu) and the agent runs into cash issues, this should be obvious very quickly at which point all of the investors can collectively meet with the agent and decide on what can be done.  
S.3 also lists the payments.  Note here that the payments are all based on figures whose numbers can be documented.  Note also that the definition of the payments also includes all payments made by the tenant to the agent, which avoids the possibility that the agent could be pressured to reduce the payout by including other fees.  
S.4 are some remedies in case something goes wrong.  The first remedy is to terminate the contract with no payments.  The second remedy is to terminate the contract with a repayment of the initial investment *AND* the overhead payment.  
S.5 says what happens if everything goes right.  Once the landlord contract is executed, the manager must provide the investor with the documents, and the trust releases the funds to the deposit payer for the purpose of paying the deposit.  
S.6 says what happens when the tenant signs the control.  The manager provides the investor with the tenant documents.  The manager collects the overhead payment from the trust and also excess payments for that year.  Also in case of a rollover option, the initial investment can be used as a deposit for another flat.
S.7 says that the investor provides the funds on the initial contract date, and that the manager has one week to use the funds to execute the contract.
S.8 says that within one month, the agent must rent out the flat and
provide the investor with documents.
S.9 provides for two payments.  Both are based on verifiable data. 
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
    }
    return Notes;
});
