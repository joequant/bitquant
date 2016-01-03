// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

var contract_template = (function () {/*
{{header_text}}

THIS AGREEMENT is dated {{initial_date_string}}

BETWEEN

{{parties_formatted}}

AGREED TERMS

1. Governing law
----------------
This agreement and any dispute or claim arising out of or in connection with it or its subject matter or formation (including non-contractual disputes or claims) shall be governed by and construed in accordance with the law of {{choice_of_law}}.  

2. Jurisdiction
---------------
Each party irrevocably agrees that any dispute or claim arising out of or in connection with this agreement or its subject matter or formation shall be under the {{jurisdiction}}.

3. Interpretation
-----------------
3.1 The following definitions and rules of interpretation apply in this agreement.  
  * Business Day: a day other than a Saturday, Sunday or public holiday in Kenya when banks in Narobi are open for business.  
  * Commencement Date: the date that the Lessee takes Delivery of the Equipment.  
  * Delivery: the transfer of physical possession of the Equipment to the Lessee at the Site.  
  * Deposit: the deposit amount set out in the Payment Schedule.  
  * Equipment: the items of equipment listed in Schedule 2, all substitutions, replacements or renewals of such equipment and all related accessories, manual and instructions provided for it.  
  * Payment Schedule: Schedule 1 which sets out the sums payable under this agreement.  
  * Purchase Option: the Lessee's option to purchase the Equipment as more fully described in clause 8.  
  * Purchase Option Price: the price of the Purchase Option as set out in the Payment Schedule.  
  * Site: the Lessee's premises at {{lessee_premises}}.  
  * Rental Payments: the payments made by or on behalf of Lessee for hire of the Equipment.  
  * Rental Period: the period of hire as set out in clause 3.  
   3.2 Clause, schedule and paragraph headings shall not affect the interpretation of this agreement.  
   3.3 A person includes a natural person, corporate or unincorporated body (whether or not having separate legal personality) and that person's legal and personal representatives, successors and permitted assigns.  
   3.4 The schedules form part of this agreement and shall have effect as if set out in full in the body of this agreement and any reference to this agreement includes the schedules.  
   3.5 A reference to a company shall include any company, corporation or other body corporate, wherever and however incorporated or established.  
   3.6 Unless the context otherwise requires, words in the singular shall include the plural and vice versa.  
   3.7 Unless the context otherwise requires, a reference to one gender shall include a reference to the other genders.  
   3.8 A reference to writing or written includes fax and e-mail.  
   3.9 Any obligation on a party not to do something includes an obligation not to allow that thing to be done.  
   3.10 Any words following the terms including, include, in particular, for example or any similar expression shall be construed as illustrative and shall not limit the sense of the words, description, definition, phrase or term preceding those terms.

4. Equipment hire
-----------------
  4.1 The Lessor shall hire the Equipment to the Lessee subject to the terms and conditions of this agreement.  
  4.2 The Lessor shall not, other than in the exercise of its rights under this agreement or applicable law, interfere with the Lessee's quiet possession of the Equipment.

5. Rental Period
----------------
The Rental Period starts on the Commencement Date and shall continue for a period of {{rental_duration_string}} unless this agreement is terminated earlier in accordance with its terms.  

6. Rental Payments and Deposit
------------------------------
6.1 The Lessee shall pay the Rental Payments to the Lessor in accordance with the Payment Schedule. The Rental Payments shall be paid in {{currency}} and shall be made by {{payment_method}}.  
6.2 The Rental Payments are exclusive of VAT and any other applicable taxes and duties or similar charges which shall be payable by the Lessee at the rate and in the manner from time to time prescribed by law.  
6.3 All amounts due under this agreement shall be paid in full without any set-off, counterclaim, deduction or withholding (other than any deduction or withholding of tax as required by law).  
6.4 If the Lessee fails to make any payment due to the Lessor under this agreement by the due date for payment, then, without limiting the Lessor's remedies under clause 11, the Lessee shall pay interest on the overdue amount at the rate of {{overdue_rate}} from time to time. Such interest shall accrue on a daily basis from the due date until actual payment of the overdue amount, whether before or after judgment. The Lessee shall pay the interest together with the overdue amount.  

7. Title, risk
--------------
7.1 The Equipment shall at all times remain the property of the Lessor, and the Lessee shall have no right, title or interest in or to the Equipment (save the right to possession and use of the Equipment subject to the terms and conditions of this agreement) except where the Lessee purchases the Equipment pursuant to the Purchase Option in clause 8.  
7.2 The risk of loss, theft, damage or destruction of the Equipment shall pass to the Lessee on Delivery. The Equipment shall remain at the sole risk of the Lessee during the Rental Period and any further term during which the Equipment is in the possession, custody or control of the Lessee (Risk Period) until such time as the Equipment is redelivered to the Lessor.  
7.3 The Lessee shall give immediate written notice to the Lessor in the event of any loss, accident or damage to the Equipment arising out of or in connection with the Lessee's possession or use of the Equipment.  

8. Right of hirer to complete agreement
------------------------------------
8.1. The hirer may after previous notice in writing to the owner complete the purchase of the goods comprised in this agreement by paying the owner on a day specificed in the notice the "net balance" due to the owners.  
8.2 The "net balance" means the balance originally payable under the agreement less any amounts (other than the deposit) paid or provided, whether by cash or other consideration, by or on behalf of the hirer under the agreement.  
8.3 The hirer may complete the purchase under paragraph 1 above ither
a) during the continuance of the agreement; or  
b) within 28 days after the owner has taken possession of the goods on paying the owner in addition to the net balance  
i) the resonable cost incurrened by the owner in and incidental to taking posession or the goods; and  
ii) any amounts properly expended by the owner on the storage, repair, or maintence of the goods; and  
iii) any additional interest which is due under the agreement  

9. Right of hirer to terminate agreement
-----------------------------------------
9.1 The leasee may pay an end to this agreement by returning the goods to the owner and giving him written notice of termination of this agreement.  
9.2 He must them pay any installments which are in arrear at the time he gives notice.  If when he has paid the installments, the total amount which he has paid under the agreement is less than ***, he must also pay enough to make up that sum.  
9.3. If the goods have been damaged owing to the hirer having failed to take reasomable care of them, the lessor may sue him for the amount of the damage uneless that amount can be agreed between the lessor and lessee.  
9.4. The lessor must return the goods at his own expense to the premises from which they were originally supplied to him or to such other place as the owner may direct.  The owner must reimburse the hirer for any additional expense incurred in returning the goods to premises other than those from which they were originally supplied.  
9.5. The hirer should see whether this agreement contains provisions allowing him to put an end to the agreement on terms more favourable to him than those just mentioned.  If it does he may put an end to the agreement on those terms.  

10. Liability
-------------  
10.1 Without prejudice to clause 10.2, the Lessor's maximum aggregate liability for breach of this agreement (including any liability for the acts or omissions of its employees, agents and subcontractors), whether arising in contract, tort (including negligence), misrepresentation or otherwise, shall in no circumstances exceed £[AMOUNT].
10.2 Nothing in this agreement shall exclude or in any way limit:
(a) either party's liability for death or personal injury caused by its own negligence;
(b) either party's liability for fraud or fraudulent misrepresentation; or
(c) any other liability which cannot be excluded by law.
10.3 This agreement sets forth the full extent of the Lessor's obligations and liabilities in respect of the Equipment and its hiring [and sale] to the Lessee. In particular, there are no conditions, warranties or other terms, express or implied, including as to quality, fitness for a particular purpose or any other kind whatsoever, that are binding on the Lessor except as specifically stated in this agreement. Any condition, warranty or other term concerning the Equipment which might otherwise be implied into or incorporated within this agreement, whether by statute, common law or otherwise, is expressly excluded.
10.4 Without prejudice to clause 10.2, neither party shall be liable under this agreement for any:
(a) loss of profit;
(b) loss of revenue
(c) loss of business; or
(d) indirect or consequential loss or damage,
in each case, however caused, even if foreseeable.

11. Termination
---------------
11.1 Without affecting any other right or remedy available to it, the Lessor may terminate this agreement with immediate effect by giving written notice to the Lessee if:
(a) the Lessee fails to pay any amount due under this agreement on the due date for payment and remains in default not less than [NUMBER] days after being notified in writing to make such payment;  
(b) the Lessee commits a material breach of any other term of this agreement which breach is irremediable or (if such breach is remediable) fails to remedy that breach within a period of [NUMBER] days after being notified [in writing] to do so;  
(c) the Lessee repeatedly breaches any of the terms of this agreement in such a manner as to reasonably justify the opinion that its conduct is inconsistent with it having the intention or ability to give effect to the terms of this agreement;  
(d) the Lessee suspends, or threatens to suspend, payment of its debts or is unable to pay its debts as they fall due or admits inability to pay its debts;  
(e) the Lessee commences negotiations with all or any class of its creditors with a view to rescheduling any of its debts, or makes a proposal for or enters into any compromise or arrangement with its creditors other than (being a company) for the sole purpose of a scheme for a solvent amalgamation of the Lessee with one or more other companies or the solvent reconstruction of the Lessee;  
(f) a petition is filed, a notice is given, a resolution is passed, or an order is made, for or in connection with the winding up of the Lessee (being a company) [other than for the sole purpose of a scheme for a solvent amalgamation of the Lessee with one or more other companies or the solvent reconstruction of the Lessee];  
(g) an application is made to court, or an order is made, for the appointment of an administrator, or if a notice of intention to appoint an administrator is given or if an administrator is appointed, over the Lessee (being a company);  
(h) the holder of a qualifying floating charge over the assets of the Lessee (being a company) has become entitled to appoint or has appointed an administrative receiver;  
(i) a person becomes entitled to appoint a receiver over the assets of the Lessee or a receiver is appointed over the assets of the Lessee;  
(k) a creditor or encumbrancer of the Lessee attaches or takes possession of, or a distress, execution, sequestration or other such process is levied or enforced on or sued against, the whole or any part of the Lessee's assets and such attachment or process is not discharged within [14] days;  
(l) any event occurs, or proceeding is taken, with respect to the Lessee in any jurisdiction to which it is subject that has an effect equivalent or similar to any of the events mentioned in clause 11.1(d) to clause 11.1(k) (inclusive);
(m) the Lessee suspends or ceases, or threatens to suspend or cease, carrying on all or a substantial part of its business; [or]  
(n) [the Lessee (being an individual) dies or, by reason of illness or incapacity (whether mental or physical), is incapable of managing his or her own affairs or becomes a patient under any mental health legislation[; or]]  

12. Consequences of termination
-------------------------------
12.1 Upon termination of this agreement, however caused:
(a) the Lessor's consent to the Lessee's possession of the Equipment shall terminate; and  
(b) without prejudice to any other rights or remedies of the Lessee, the Lessee shall pay to the Lessor on demand:  
(i) all Rental Payments and other sums due but unpaid at the date of such demand together with any interest accrued pursuant to clause 4.4;  
(ii) any costs and expenses incurred by the Lessor in recovering the Equipment and/or in collecting any sums due under this agreement (including any storage, insurance, repair, transport, legal and remarketing costs).  
12.2 Upon termination of this agreement pursuant to clause 11.1, any other repudiation of this agreement by the Lessee which is accepted by the Lessor or pursuant to clause 11.3, without prejudice to any other rights or remedies of the Lessor, the Lessee shall pay to the Lessor on demand a sum equal to the whole of the Rental Payments that would (but for the termination) have been payable if the agreement had continued from the date of such demand to the end of the Rental Period, less:   
(a) a discount for accelerated payment at the percentage rate set out in the Payment Schedule; and  
(b) [the Lessor's reasonable assessment of the market value of the Equipment on sale].  
12.3 The sums payable pursuant to clause 12.2 shall be agreed compensation for the Lessor's loss and shall be payable in addition to the sums payable pursuant to clause 12.1(b). Such sums may be partly or wholly recovered from any Deposit.  
12.4 Termination or expiry of this agreement shall not affect any rights, remedies, obligations or liabilities of the parties that have accrued up to the date of termination or expiry, including the right to claim damages in respect of any breach of the agreement which existed at or before the date of termination or expiry.  

13. Force majeure
-----------------
Neither party shall be in breach of this agreement nor liable for delay in performing, or failure to perform, any of its obligations under this agreement if such delay or failure result from events, circumstances or causes beyond its reasonable control. In such circumstances [the time for performance shall be extended by a period equivalent to the period during which performance of the obligation has been delayed or failed to be performed OR the affected party shall be entitled to a reasonable extension of the time for performing such obligations]. If the period of delay or non-performance continues for [NUMBER] [weeks OR months], the party not affected may terminate this agreement by giving [NUMBER] [days'] written notice to the affected party.  

14. Assignment and other dealings
---------------------------------
14.1 The lessee may not assign, transfer, mortgage, charge, subcontract, declare a trust over or deal in any other manner with any of its rights and obligations under this agreement.  
14.2 The lessor may assign, transfer, mortgage, charge, subcontract, declare a trust over or deal in any other manner with any of its rights and obligations under this agreement.  

15. Entire agreement
--------------------
15.1 This agreement constitutes the entire agreement between the parties and supersedes and extinguishes all previous agreements, promises, assurances, warranties, representations and understandings between them, whether written or oral, relating to its subject matter.  
15.2 Each party acknowledges that in entering into this agreement it does not rely on[, and shall have no remedies in respect of,] any statement, representation, assurance or warranty (whether made innocently or negligently) that is not set out in this agreement.  
15.3 Each party agrees that it shall have no claim for innocent or negligent misrepresentation [or negligent misstatement] based on any statement in this agreement.  
15.4 Nothing in this clause shall limit or exclude any liability for fraud.

16. Variation
-------------
No variation of this agreement shall be effective unless it is in writing and signed by the parties (or their authorised representatives).  

17. No partnership or agency
----------------------------
17.1 Nothing in this agreement is intended to, or shall be deemed to, establish any partnership or joint venture between any of the parties, constitute any party the agent of another party, or authorise any party to make or enter into any commitments for or on behalf of any other party.  
17.2 Each party confirms it is acting on its own behalf and not for the benefit of any other person.  

18. Counterparts
----------------
18.1 This agreement may be executed in any number of counterparts, each of which when executed and delivered shall constitute a duplicate original, but all the counterparts shall together constitute the one agreement.  
18.2 Transmission of the executed signature page of a counterpart of this agreement] by (a) fax or (b) e-mail (in PDF, JPEG or other agreed format) shall take effect as delivery of an executed counterpart of this agreement. If either method of delivery is adopted, without prejudice to the validity of the agreement thus made, each party shall provide the others with the original of such counterpart as soon as reasonably possible thereafter.  
18.3 No counterpart shall be effective until each party has executed and delivered at least one counterpart.  

19. Third party rights
----------------------
No one other than a party to this agreement, their successors and permitted assignees, shall have any right to enforce any of its terms.  

20. Notices
----------
20.1 Any notice given to a party under or in connection with this contract shall be in writing and shall be:  
(a) delivered by hand or by pre-paid first-class post or other next working day delivery service at its registered office (if a company) or its principal place of business (in any other case); or   
(b) sent by fax to its main fax number.  
21.2 Any notice shall be deemed to have been received:  
(a) if delivered by hand, on signature of a delivery receipt [or at the time the notice is left at the proper address];  
(b) if sent by pre-paid first-class post or other next working day delivery service, at [9.00 am] on the [second] Business Day after posting [or at the time recorded by the delivery service].   
(c) if sent by fax, at [9.00 am] on the next Business Day after transmission.
21.3 This clause does not apply to the service of any proceedings or other documents in any legal action or, where applicable, any arbitration or other method of dispute resolution.  

21. Waiver
----------
No failure or delay by a party to exercise any right or remedy provided under this agreement or by law shall constitute a waiver of that or any other right or remedy, nor shall it prevent or restrict the further exercise of that or any other right or remedy. No single or partial exercise of such right or remedy shall prevent or restrict the further exercise of that or any other right or remedy.  

22. Rights and remedies
-----------------------
Except as expressly provided in this agreement, the rights and remedies provided under this agreement are in addition to, and not exclusive of, any rights or remedies provided by law.

23. Severance
-------------
23.1 If any provision or part-provision of this agreement is or becomes invalid, illegal or unenforceable, it shall be deemed modified to the minimum extent necessary to make it valid, legal and enforceable. If such modification is not possible, the relevant provision or part-provision shall be deemed deleted. Any modification to or deletion of a provision or part-provision under this clause shall not affect the validity and enforceability of the rest of this agreement.  
23.2 If any provision or part-provision of this agreement is invalid, illegal or unenforceable, the parties shall negotiate in good faith to amend such provision so that, as amended, it is legal, valid and enforceable, and, to the greatest extent possible, achieves the intended commercial result of the original provision.  
/This agreement has been entered into on the date stated at the beginning of it.  

24. Additional provisions
-------------------------
{{additional_provisions}}

*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];



define(function() {

function Contract_Config(obj) {
    obj.allow_skip_principal = true;
}

function Contract_Text(obj) {
    obj.contract_text = contract_template;
    obj.header_text = (function () {/*
DRAFT FOR REFERENCE ONLY.  DO NOT EXECUTE.

Copyright (c) 2015 Bitquant Research Laboratories (Asia) Ltd.  
Legal text prepared by CryptoLaw (http://crypto-law.com/)

Released under terms of the Simplified BSD License.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];

    obj.choice_of_law = "England and Wales";
    obj.jurisdiction = "non-exclusive jurisdiction of the Courts of England and Wales, Hong Kong, or Republic of Kenya";
    obj.equipment = "one laptop"
    obj.parties = {
	roles : ["borrower", "lender"],
	borrower : {
	    type: "corporation",
	    name : "AIR BUTTON TECHNOLOGY LIMITED",
	    location : "Hong Kong",
	    company_number : "2122451",
	    registered_office : "518 Level 5 Core F, Cyberport 3, 100 Cyberport Road, Hong Kong",
	    contact : {
		name: "Oswis Wong",
		address: "Rm 8, Unit 518, Core F, Cyberport 3, Cyberport Rd., Hong Kong",
		email: "oswis@air-button.com"
	    }
	},
	lender:  {
	    type: "corporation",
	    name : " BITQUANT RESEARCH LABORATORIES (ASIA) LIMITED",
	    domicile : "Hong Kong",
	    company_number : "2022190",
	    registered_office : "3/F, B-25 Citicorp Centre, 18 Whitfield Road, Tin Hau, Hong Kong",
	    contact : {
		name: "Joseph Wang",
		address: "3/F, B-25 Citicorp Centre, 18 Whitfield Road, Tin Hau, Hong Kong",
		email: "joequant@gmail.com"
	    }
	}
    };


    obj.additional_provisions = (function () {/*
17.1 For the purpose of of computing accelerated payments in this
Agreement, the revenue shall be the cumulative gross receipts received
by the Borrower, any subsidiaries or holding companies of the
Borrower, or any other companies controlled by or affliated with the
Borrower.  Gross receipts shall include income derived from sales of
the Product as well as an licensing fees received in conjunction with
the Product or any intellectual property associated with the product.  
17.2 During the term of the Facility, the Borrower agrees to provide the
Lender on at least a monthly basis an accounting gross receipts
received in conjunction with the sales or licensing of the Product and
any associated intellectual property, and to notify the Lender within
three (3) Business Days if the Borrower has reasons to
believe that the cumulative gross receipts has exceeded the revenue
targets specified in this contract.  
17.3 Any principal due under this Agreement may be paid via HKD or via
bitcoins based on the XBT Exchange Rate.  Any interest (including
default interest) due under this Agreement must be paid via bitcoins
based on the XBT Exchange Rate.
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
};

// SCHEDULES

// SCHEDULE A

function Schedule_A(obj) {
    // S.1
    obj.annual_interest_rate = 10.0;
    obj.compound_per_year = 12;
    obj.day_count_convention = "30/360US";

    obj.initial_date = new_date(2015, 3, 1);
    obj.initial_date_string = obj.initial_date.toDateString();
    obj.currency = 'HKD';
    obj.initial_amount = 90000.00;
    obj.additional_credit_limit = 50000.0;
    obj.revenue_targets =
	[
	    { "revenue" : 750000.00, "multiplier" : 0.5},
	    { "revenue" : 1500000.00, "multiplier" : 1.0},
	];
    obj.max_duration = [ 1, 'year']
}

// SCHEDULE B

function Schedule_B(obj) {
    obj.late_additional_interest_rate = 5.0;
    obj.late_annual_interest_rate = 10.0 + obj.late_additional_interest_rate;
    obj.late_compound_per_year = 365;
    obj.late_day_count_convention = "30/360US";
}

// SCHEDULE C
function Schedule_C(obj) {
    obj.contract_parameters = [
	{
	    name: "annual_interest_rate",
	    display: "Annual percentage rate (%)",
	    type: "number",
	    scenario: true
	},
	{
	    name: "compound_per_year",
	    display: "Compounding periods per year",
	    type: "number",
	    scenario: true
	},
	{
	    name: "day_count_convention",
	    display: "Date Count Convention",
	    type: "text"
	},
	{
	    name: "initial_date",
	    display: "Initial loan date",
	    type: "date",
	    scenario: true
	},
	{
	    name: "initial_amount",
	    display: "Initial loan amount",
	    type: "number"
	},
	{
	    name: "additional_credit_limit",
	    display: "Additional credit limit",
	    type: "number"
	},
	{
	    name: "max_duration",
	    display: "Maximum duration",
	    type: "duration"
	},
	{ 
	    name: "currency",
	    display: "Currency",
	    type: "currency"
	},
	{
	    name: "revenue_targets",
	    display: "Revenue target table",
	    type: "grid",
	    columns: [
		{ name: "revenue",
		  display: "Revenue",
		  type: "number"
		},
		{ name: "multiplier",
		  display: "Multiplier",
		  type: "number"
		}
	    ]
	}
    ];

    obj.event_spec = [
	{
	    name : "revenues",
	    display : "Projected Revenues",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ],
	    unfilled_value : []
	},
	{
	    name: "early_payment",
	    display : "Early Payments",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ],
	    unfilled_value : []
	},
	{
	    name: "late_payment",
	    display : "Late payment",
	    type: "grid",
	    columns: [
		{ name: "on", display: "Date", type : 'date' },
		{ name: "amount", display : "Money", type : "number" }
	    ],
	    unfilled_value : []
	}
    ];

    if (obj.allow_skip_principal) {
	obj.event_spec.push(
	    {
		name: "skip_principal",
		display : "Skip principal payment",
		type: "grid",
		columns: [
		    { name: "on", display: "Date", type : 'date' }
		],
		unfilled_value : []
	    }
	);  
    } else {
	obj.skip_principal = [];
    }

    if (obj.additional_credit_limit > 0.0) {
	obj.event_spec.push(
	    {
		name: "credit_request",
		display : "Credit request",
		type: "grid",
		columns: [
		    { name: "on", display: "Date", type : 'date' },
		    { name: "amount", display : "Money", type : "number" }
		],
		unfilled_value : []
	    }
	);
    } else {
	obj.credit_request = [];
    }
    obj.event_spec.push(
	{
	    name: "header",
	    type: "note"
	}
    );
    obj.event_spec.push(
	{
	    name: "terms",
	    type: "note"
	}
    );
}


Schedule_C.prototype.process_payment = function(i) {
    if (i.event == "Payment") {
	var principal_payment = 0.0;
	var interest_payment = 0.0;
	if (i.payment > i.interest_accrued) {
	    interest_payment = i.interest_accrued;
	    principal_payment = i.payment - i.interest_accrued;
	} else {
	    interest_payment = i.payment;
	    principal_payment = 0.0;
	}
	i.principal_payment = principal_payment;
	i.interest_payment = interest_payment;
    } else {
	i.principal_payment = 0.0;
	i.interest_payment = 0.0;
    }
    return i;
}

Schedule_C.prototype.payments = function(calc) {
    // S.1
    calc.fund({"on" : this.initial_date,
               "amount" : this.initial_amount,
               "note" : "Initial funding"});

    // S.2
    obj = this;
    this.credit_request.forEach(function (i) {
	i.amount = calc.limit_balance(i.amount, 
				      obj.initial_amount + 
				      obj.additional_credit_limit);
        calc.fund(i);
    });

    // S.3
    var final_payment_date =
	following_1st_of_month(calc.add_duration(this.initial_date,
						 obj.max_duration));
    calc.payment({"on":final_payment_date,
                  "amount":calc.remaining_balance(),
                  "note":"Required final payment"});

    // S.4
    this.early_payment.forEach(function(i) {
	i.required = 0.0;
        calc.payment(i);
    });

    // S.5
    var payment_function = function(calc, params) {
	var payment = calc.extract_payment(params);

	var principal = calc.principal;
	var late_balance = calc.late_balance;
	var interest_accrued = calc.balance - calc.principal;

	if (payment > calc.balance) {
            payment = calc.balance;
	}

	payment = payment + late_balance;
	var required_payment = calc.extract_payment(params.required);
	if (required_payment === undefined) {
	    required_payment = payment;
	}
	var interest_payment = 0.0;
	var principal_payment = 0.0;

	if (payment > interest_accrued) {
	    interest_payment = interest_accrued;
	    principal_payment = payment - interest_accrued;
	} else {
	    interest_payment = payment;
	    principal_payment = 0.0;
	}

	if (contains(calc.term_sheet.skip_principal, params.on)
	   != undefined) {
	    payment = interest_payment;
	    principal_payment = 0.0;
	    params.note = "Principal payment skipped";
	}

	if (contains(calc.term_sheet.late_payment, params.on)) {
	    var late_payment = 
		contains(calc.term_sheet.late_payment, params.on).amount;
	    if (late_payment > payment) {
		payment = 0.0;
	    } else {
		payment = payment - late_payment;
	    }
	    params.note = "Late payment";
	}
	
	calc.balance = calc.balance - payment;

	if (payment >=  interest_accrued) {
	    calc.principal = calc.principal - payment + interest_accrued;
	}

	if (payment < late_balance) {
	    calc.late_balance = calc.late_balance - payment;
	} else {
	    calc.late_balance = 0.0;
	}

	if (payment < required_payment) {
	    calc.late_balance = calc.late_balance + required_payment - 
		payment;
	}
	if (payment > 0 || calc.late_balance > 0) {
            return {"event":"Payment",
                    "on":params.on,
                    "payment":payment,
                    "principal":principal,
                    "interest_accrued": interest_accrued,
                    "balance":calc.balance,
		    "late_balance" : calc.late_balance,
                    "note":params.note}
	}

    }

    // S.6
    var start_payment_date = 
	following_1st_of_month(
	    calc.add_duration(this.initial_date, [4, "months"]));

    calc.amortize({"on":start_payment_date,
                   "amount": calc.remaining_balance(),
                   "payments" : 8,
                   "interval" : [1, "month"],
		   "required" : calc.accrued_interest(),
		   "payment_func" : payment_function});

    if (this.revenues == undefined) {
	return;
    }

    // S.7
    var i = 0;
    var obj = this;
    this.getTargetHitDates().forEach(function(target_hit_date) {
        if (target_hit_date == undefined) {
            return;
	}
        var multiplier = obj.revenue_targets[i].multiplier;
        var payment_date = 
	    following_1st_of_month(calc.add_duration(target_hit_date, 
						     [2, "weeks"]));
        if (payment_date > final_payment_date) {
            payment_date = final_payment_date;
	}
        calc.add_to_balance(
	    {"on": payment_date,
	     "amount" : 
	     calc.multiply(calc.interest(target_hit_date,
					 final_payment_date,
					 calc.remaining_balance()), 
			   multiplier),
             "note" : "Accelerated interest " + (i+1).toString()}
	);
	var note = ("Required payment " + (i+1).toString())
	if (multiplier == 1.0) {
	    note = note + "Loan agreement terminates";
	}
        calc.payment(
	    {"on" : payment_date,
             "amount" : calc.multiply(calc.remaining_balance(),
				      multiplier),
	     "note" : note });
	i++;
    });
}

Schedule_C.prototype.getTargetHitDates = function () {
    var target_hit_dates = [];
    var total_revenue = 0.0;
    var revenue_idx = 0;
    var obj = this;
    this.revenues.forEach(function(i) {
	if (revenue_idx >= obj.revenue_targets.length) {
	    return;
	}

	total_revenue += i.amount;
	if(total_revenue < obj.revenue_targets[revenue_idx].revenue) {
	    revenue_idx = revenue_idx + 1;
	    return;
	}

	while(total_revenue >= obj.revenue_targets[revenue_idx].revenue) {
	    target_hit_dates.push(i['on']);
	    revenue_idx = revenue_idx + 1;
	    if (revenue_idx >= obj.revenue_targets.length) {
		return;
	    }
	}
    });
    return target_hit_dates;
}

function contains(a, obj) {
    for (var i = 0; i < a.length; i++) {
        if (a[i].on >= obj && a[i].on <= obj) {
            return a[i];
        }
    }
    return undefined;
}

function following_1st_of_month(a) {
    if (a.getDate() == 1) {
	return a;
    };
    if (a.getMonth() == 12) {
	return new Date(a.getFullYear() + 1, 0, 1);
    } 
    var retval = new Date(a.getFullYear(), a.getMonth() + 1, 1);
    return retval;
}

function new_date(year, month, day) {
    return new Date(year, month-1, day);
}

function TermSheet() {
    Contract_Config(this);
    Contract_Text(this);
    Schedule_A(this);
    Schedule_B(this);
    Schedule_C(this);
}

["process_payment", "payments", "getTargetHitDates"].map(function(i) {
    TermSheet.prototype[i] = Schedule_C.prototype[i];
});

return TermSheet;
});
