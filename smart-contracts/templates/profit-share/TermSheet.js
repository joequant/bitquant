// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License

"use strict";

if (typeof define !== 'function') {
    var define = require('amdefine')(module);
}

var contract_template = (function () {/*
{{header_text}}

This TRUST AGREEMENT is dated {{initial_date_string}}


1) The settlor of this agreement is {{investor.name}} incorporated and
registered in Hong Kong with company number
{{investor.company_number}} whose registered office is at
{{investor.registered_office}} (INVESTOR).

2) The trustee of this agreement is {{manager.name}} incorporated and
registered in {{manager.location}} with company number
{{manager.company_number}} whose registered office is at
{{manager.registered_office}} (MANAGER).

3) The beneficiary of this agreement is the INVESTOR and any assignees
of the INVESTOR.

BACKGROUND

The investor as settlor has agreed to provide the manager as trustee
funds of the purpose of investment into a named real property.  The
trustee agrees to handle the funds according to the terms of this
agreement benefit of the beneficiary.

AGREED TERMS

1. Governing law and jurisdiction
------------------------------
1.1 This Agreement and any dispute or claim arising out of or in connection with it or its subject matter or formation (including non-contractual disputes or claims) shall be governed by and construed in accordance with the laws of Hong Kong.  
1.2 Each party irrevocably agrees that, subject as provided below, the courts of Hong Kong shall have non-exclusive jurisdiction over any dispute or claim that arises out of, or in connection with this Agreement or its subject matter or formation (including non-contractual disputes or claims). Nothing in this clause shall limit the right of the Investor to take proceedings against the Manager in any other court of competent jurisdiction, nor shall the taking of proceedings in any one or more jurisdictions preclude the taking of proceedings in any other jurisdictions, whether concurrently or not, to the extent permitted by the law of such other jurisdiction.
This Agreement has been entered into on the date stated at the beginning of it.

2. Definitions
-----------
2.1 The following definitions apply in this Agreement:  
  * Business Day: a day other than a Saturday, Sunday or public holiday when banks in Hong Kong are open for business.  
  * HK$: the lawful currency of Hong Kong.  
  * Hong Kong: the Hong Kong Special Administration Region of the People’s Republic of China.  
  * Related persons: shall comprise immediate relatives and other persons living in the household of a natural person, or in the case of legal persons, immediate relatives and other persons living in the household of a director or senior manager of the legal person,
  * XBT Exchange Rate:  the conversion rate between HKD and XBT as quoted by ANXBTC or Bitcashout

3. Interpretation
--------------
3.1 In this Agreement:  
3.1.1 unless the context otherwise requires, words in the singular shall include the plural and in the plural shall include the singular;  
3.1.2 unless the context otherwise requires, a reference to one gender shall include a reference to the other genders;  
3.1.3 a reference to a party shall include that party's successors, permitted assigns and permitted transferees;  
3.1.4 a reference to a statute or statutory provision is a reference to it as amended, extended or re-enacted from time to time;  
3.1.5 a reference to writing  or written includes mail, fax and e-mail;  
3.1.6 unless the context othoerwise requires, a reference to a clause or Schedule is to a clause of, or Schedule to, this Agreement; and  
3.1.7 any words following the terms including, include, in particular, for example  or any similar expression shall be construed as illustrative and shall not limit the sense of the words, description, definition, phrase or term preceding those terms.  
3.2 The Schedules are written in the javascript, and shall form part of this Agreement and shall have effect as if set out in full in the body of this Agreement. Any reference to this Agreement includes the Schedules.  
3.3 In case of any inconsistency between the body of the Agreement and the Schedules, the body of the Agreement shall prevail, in which case the parties may amend the Schedules in good faith to reflect the body of the Agreement. 

4. Commencement
------------
4.1 This Agreement shall be deemed to have commenced on the date of this Agreement.

5. Time is of the essence
-------------------------
5.1 Time is of the essence in this agreement.

6. Use of funds
---------------
6.1 Any funds received by the manager, its agents, or related persons
of the manager or its agents, excluding refunds of deposits, in
connection with the named property shall be the property of this
trust, and may only be used in accordance with the terms and
conditions of this agreement.

6.2 During the existence of this trust, the manager or any agent of
the manager or any person related to the manager may not collect or
cause to be collected any non-refundable funds concerning the named
property other than rent which has been executed via a written
agreement which has been provided to the beneficiary or which have
otherwise expressly been disclosed in writing to the beneficiary.  The
manager agrees that any funds that have not been expressly disclosed
to the beneficiary shall immediately become the property of the
beneficiary.

6,3 Any funds owned by the trust which are in excess of that what is
necessary to fulfil the payment obligations of the trust to the
beneficiary in that calendar year, shall immediately become the
property of the manager, who may thereupon use those funds for any
purpose whatsoever.

6.4 The initial investment, as defined in Schedule A, may only be used
for the purpose of paying for the deposit and rent advances for the
named property or as reimbursement to any person who has paid said
fees.

6.5 Upon presentation of the landlord documents as specified in
Schedule A, ownership of the and funds associated with the overhead
fee as defined in Schedule A shall immediate pass from the trust to
the manager, who may use these funds for any purpose whatsoever.
 
6.6 The trustee shall have authority to keep the funds owned by the
trust in any business cash account normally used by the trustee for
business operations, provided that the trustee shall have reasonable
belief that no event shall occur that would prevent the trustee from
fulfiling their obligations to the beneficiary.  In the event that the
trustee has reasonable belief that keeping the funds owned by the
trust in said account may prevent the trustee from fulfilling its
obligations under this agreement, it shall forthwith segregate the
funds owned by the trust from other funds owned by the trustee.

6.7 The trustee shall insure that any funds held by the trust shall be
stored in a form which is commonly used for the storage of cash for
businesses.  Examples of these forms include insured bank accounts and
stored value card.  In no event shall the trustee pledge funds owned
by the trust as collateral to any third party, nor may the trustee use
the funds owned by the trust for investment purposes without the
express written consent of the beneficiary.

6.8 The trustee shall have authority to appoint a trust administrator
to mangage funds in the trust.

6.9 In the event, that the settlor has a reasonable belief that the
trustee is unable to properly administer the terms of the trust, the
settlor shall have authority to revoke the authority of the trustee
and appoint a new trustee to manage the funds owned by the trust.
This action shall not affect the distribution or ownership of funds.

6.10 The beneficiary of this trust has the authority to revoke the
trust agreement at any time, upon which time any funds owned by the
trust shall be transfered to the beneficiary.

6.11 This trust shall automatically terminate when the trustee has
fulfiled all obligations owed to the beneficiary as specified in
Schedule A.

7. Regulatory activities
------------------------ 

7.1 If any provision (or part of a provision) of this Agreement is or
becomes invalid, illegal or unenforceable, it shall be deemed modified
to the minimum extent necessary to make it valid, legal and
enforceable. If such modification is not possible, the relevant
provision (or part of a provision) shall be deemed deleted. Any
modification to or deletion of a provision (or part of a provision)
under this clause shall not affect the legality, validity and
enforceability of the rest of this Agreement.

7.2 It is the express intention of the settlor that this agreement
should not constitute a collective investment scheme as defined by the
laws of Hong Kong, and the trustee shall take all reasonable actions
necessary to prevent this agreement from constituting a collective
investment scheme.  

7.3 It is the express intention of the settlor that the issuance,
sale, resale, and marketing of this agreement, shall not constitute a
regulated activity under the Securities Futures Ordinance of the laws
of Hong Kong, and the trustee shall take all reasonable actions
necessary to prevent the issuance, sale, resale, and marketing of this
agreement not be construed as performing a regulated activity under
the Securities Futures Ordinance.

7.3 In the event that this agreement is deemed or is likely to be
deemed to be a collective investment scheme by any governmental
authority having jurisdiction over Hong Kong or in the event that
issuance, sale, resale, and marketing of this agreement is deemed or
is likely to be deemed a regulated activity under the Securities
Futures Ordinance by any governmental authority having jurisdiction
over Hong Kong, the trustees are authorized to take any reasonable and
lawful efforts to challenge or prevent said determination and are
authorized to use up to ten percent of the funds that are owned by the
trust for these activities.

7.4 In the event that this agreement is deemed or is likely to be
deemed to be a collective investment scheme by any governmental
authority having jurisdiction over Hong Kong, the settlor is
authorized to direct the trustee to use a reasonable portion of the
fund not exceeding ten percent of the amount owned by the trust to
conduct any reasonable and lawful efforts intended to challenge or
prevent said government action.

7.5 In the event that the trustee has a reasonable belief that its
ability to perform the actions specified in the trust agreement is
limited or will be limited by any actual or proposed action by any
governmental authority having jurisdiction over Hong Kong, the trustee
is authorized to use the funds owned by the trust to fund any
reasonable and lawful efforts intended to challenge or prevent said
government action, provided that the amounts used do not exceed the
likely cost of comply with said government action.

7.6 In the event that the settlor has a reasonable belief that the
ability of the trustee to ability to perform the actions specified in
the trust agreement is limited or will be limited by any actual or
proposed action by any governmental authority having jurisidiction
over Hong Kong, the settlor is authorized to direct the trustee to use
a reasonable portion of the fund to conduct any reasonable and lawful
efforts intended to challenge or prevent said government action,
provided that the amounts used do not exceed the likely cost of comply
with said government action.

7.7 Funding the aforesaid reasonable and lawful activities may include
contributions to reasonable and lawful collective activities in
cooperation with third parties to challenge or prevent a determination
by governmental authorities.


7. Representations, Warranties and Undertakings
--------------------------------------------
7.1 The Manager represents, warrants and undertakes to the Investor on the date of this Agreement:  
(a) is a duly incorporated limited liability company validly existing under the laws of its jurisdiction of incorporation;  
(b) has the power to enter into, deliver and perform, and has taken all necessary action to authorise its entry into, delivery and performance of, this Agreement; and  
(c) has obtained all required authorisations to enable it to enter into, exercise its rights and comply with its obligations in this Agreement.  
7.2 The entry into and performance by it of, and the transactions contemplated by, this Agreement, do not and will not contravene or conflict with:
(a) its constitutional documents;  
(b) any agreement or instrument binding on it or its assets or constitute a default or termination event (however described) under any such agreement or instrument; or  
(c) any law or regulation or judicial or official order, applicable to it.  
7.3 The information, in written or electronic format, supplied by, or on its behalf, to the Investor in connection with this Agreement was, at the time it was/will be supplied or at the date it was/will be stated to be given (as the case may be):  
(a) if it was factual information, complete, true and accurate in all material respects;  
(b) if it was a financial projection or forecast, prepared on the basis of recent historical information and on the basis of reasonable assumptions and was fair and made on reasonable grounds; and  
(c) if it was an opinion or intention, made after careful consideration and was fair and made on reasonable grounds; and  
(d) not misleading in any material respect, nor rendered misleading by a failure to disclose other information.
7.4.  THE MANAGER FULLY, COMPLETELY, AND ABSOLUTELY INDEMNIFIES THE TRUST, SETTLOR, AND BENEFICIARY OF ANY AND ALL LIABILITY AND CLAIMS BY THIRD PARTIES ARISING FROM ACTIVITIES CONCERNING THE NAMED PROPERTY, INCLUDING BUT NOT LIMITED TO BREACH OF CONTRACT, NON-PAYMENT OF RENT, BREACH OF WARRANTY AND REPRESENTATIONS, AND FALSE ADVERTISING.  IN NO EVENT MAY THE TRUSTEE USE OR ALLOW TO BE USED FUNDS OWNED BY THE TRUST TO SATISFY CLAIMS BY THIRD PARTIES AGAINST THE MANAGER.  THIS INDEMNITY SHALL CONTINUE AFTER THE TERMINATION OF THE TRUST.


8. Events of Default
-----------------
8.1 Each of the events or circumstances set out in this clause is an Event of Default.  
(i) The Manager fails to pay any sum payable by it under this Agreement.  
(ii) The Manager fails (other than by failing to pay), to comply with any provision of this Agreement and (if the Investor considers, acting reasonably, that the default is capable of remedy), such default is not remedied within 7 Business Days of the earlier of:  
(a) the Investor notifying the Manager of the default and the remedy required;  
(b) the Manager becoming aware of the default.  
(iii) Any representation, warranty or statement made, repeated or deemed made by the Manager in, or pursuant to, this Agreement is (or proves to have been) incomplete, untrue, incorrect or misleading when made or deemed made.  
(iv) The Manager suspends or ceases to carry on (or threatens to suspend or cease to carry on) all or a substantial part of its business.  
(v) The passing of a resolution for the winding up of the Manager; or the appointment of a receiver, administrator or administrative receiver over the whole or any part of the assets of the Manager or the making of any arrangement with the creditors of the Manager for the affairs, business and property of the Manager to be managed by a supervisor.

9. Amendments, Waivers and Consents and Remedies
---------------------------------------------
9.1 No amendment of this Agreement shall be effective unless it is in writing and signed by, or on behalf of, each party to it (or its authorised representative).  
9.2 A waiver of any right or remedy under this Agreement or by law, or any consent given under this Agreement, is only effective if given in writing by the waiving or consenting party and shall not be deemed a waiver of any other breach or default. It only applies in the circumstances for which it is given and shall not prevent the party giving it from subsequently relying on the relevant provision.  
9.3 A failure or delay by a party to exercise any right or remedy provided under this Agreement or by law shall not constitute a waiver of that or any other right or remedy, prevent or restrict any further exercise of that or any other right or remedy or constitute an election to affirm this Agreement. No election to affirm this Agreement by the Investor shall be effective unless it is in writing. 
9.4 The rights and remedies provided under this Agreement are cumulative and are in addition to, and not exclusive of, any rights and remedies provided by law..  

10. Assignment and transfer
-----------------------

10.1 The beneficiary may assign any of its rights under this Agreement
or transfer all its rights or obligations by novation, provided that
the beneficiary of this agreement must consist of a single natural or
legal person or legal entity, and provided that the beneficiary has
notified the trustee in writing that the rights made under the
agreement have been assigned.
10.2 The trustee may not assign any of its rights or transfer any of
its rights or obligations under this Agreement without the consent of
the beneficiary.

11. Counterparts
------------
11.1 This Agreement may be executed in any number of counterparts, each of which when executed shall constitute a duplicate original, but all the counterparts shall together constitute one agreement.  
11.2 No counterpart shall be effective until each party has executed at least one counterpart.  

12. Severance

13. Notices
-------
13.1 Any notice or other communication given to a party under or in connection with this Agreement shall be:  
(a) in writing;   
(b) delivered by hand, by pre-paid first-class post or other next working day delivery service or sent by fax; and  
(c) sent to:  
the Manager at:  
Address: {{manager.contact.address}}  
Email: {{manager.contact.email}}  
Attention: {{manager.contact.name}}  
the Investor at:  
Address: {{investor.contact.address}}  
Email: {{investor.contact.email}}  
Attention: {{investor.contact.name}}    
or to any other address or fax number as is notified in writing by one
party to the other from time to time.  
13.2 Any notice or other communication that the Investor gives to the Manager under or in connection with, this Agreement shall be deemed to have been received:  
(a) if delivered by hand, at the time it is left at the relevant address;  
(b) if posted by pre-paid first-class post or other next working day delivery service, on the second Business Day after posting; and  
(c) if sent by fax or email, when received in legible form.  
13.3 A notice or other communication given on a day that is not a Business Day, or after normal business hours, in the place it is received, shall be deemed to have been received on the next Business Day.  
13.4 Any notice or other communication given to the Investor shall be deemed to have been received only on actual receipt.  


14. Additional provisions
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

    obj.manager = {
	name : "YOYODYNE PROPULSION SYSTEMS LIMITED",
	location : "Hong Kong",
	company_number : "1234552",
	registered_office : "3/F, Nam Wo Hong Building 148 Wing Lok Street Sheung Wan, Hong Kong",
	contact : {
	    name: "John Bigboote",
	    address: "Yoyodyne Propulsion Systems, 1938 Cranbury Road, Grovers Mills, New Jersey",
	    email: "bigboote@example.com"
	}
    };

    obj.investor = {
	name : "BANZAI INSTITUTE FOR BIOMEDICAL ENGINEERING AND STRATEGIC INFORMATION LIMITED",
	location : "Hong Kong",
	company_number : "2334455",
	registered_office : "3/F, Citicorp Centre, 18 Whitfield Road, Tin Hau, Hong Kong",
	contact : {
	    name: "Dr. Buckaroo Banzai",
	    address: "Banzai Institute, 1 Banzai Road, Holland Township, New Jersey",
	    email: "buckaroo@example.com"
	}
    };

    obj.property = {
	address : ""
    };

    obj.additional_provisions = (function () {/*
* Related parties shall include the agent, its directors, senior
  managers, investors providing more than 10% of working capital or
  equity, and their immediate household.

* The agent warranties that other than the landlord documents provided
  the investor they have not entered to any agreement concerning the
  designated property, and to the best of their knowledge, that the
  rents derived from the property are unencumbered and have not been
  pledged in connection with any other profit sharing or investment
  agreement.

* The agent warranties that they and related parties may not collect
  any additional rent or derive any other benefit from the designated
  property other than through a tenant agreement provided to the
  investor or which has otherwise been disclosed to the investor in
  writing.

* The agent warranties that they and related parties have no
  agreements whatsoever with the landlord concerning the designated
  property other than those documented through the landlord agreement
  provided to the investor, and that they will received no benefit
  income or fees from the landlord concerning the designated property.

* The agent fully indemifies the investor against any and all claims
 concerning the designated property.

* Landlord documents refers to an executed lease agreement between the
  agent and the designated property for a term of two years.  The lease
  between the landlord and the agent must contain the following
  provisions:
** The lease agreement allow subletting
** The lease agreement must be for a period of no less than two years
 and must containing no provision allowing for early termination of
 the lease.
** The lease agreement must make the landlord responsible for keeping
 the property in good repair, and for the costs of ordinary maintainence

* Tenant documents refers to an executed agreement between an agent
 and the tenants of the property, and must include the name and
 contact information of a representative of the tenant.  The agreed
 rent paid to the agent must exceed the rent paid to the landlord.

* Tenant fees includes any non-refundable fees paid by the tenants to
 the agent for the purpose of securing or maintaining the property.
 Tenant fees excludes any refundable deposits.

*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
};

// SCHEDULES

// SCHEDULE A

function Schedule_A(obj) {
    // S.1
    obj.profit_share_fraction = 0.5;
    obj.landlord_rent_payment = 12000;
    obj.overhead_payment = 10000;
    obj.initial_date = new_date(2015, 5, 15);
    obj.initial_date_string = obj.initial_date.toDateString();
    obj.year1_payment_date = new_date(2015, 10, 1);
    obj.year2_payment_date = new_date(2016, 10, 1);
    obj.currency = 'HKD';
}

// SCHEDULE B

function Schedule_B(obj) {
}

// SCHEDULE C
function Schedule_C() {
    Contract_Config(this);
    Contract_Text(this);
    Schedule_A(this);
    Schedule_B(this);

    this.contract_parameters = [
	{   name: "header",
	    display: "<h3>Contract Terms</h3>",
	    type: "html"
	},
	{
	    name: "profit_share_fraction",
	    display: "Profit share fraction",
	    type: "number",
	    scenario: true
	},
	{
	    name: "landlord_rent_payment",
	    display: "Landlord rent payment",
	    type: "number",
	    scenario: true
	},
	{
	    name: "overhead_payment",
	    display: "Overhead payment",
	    type: "number",
	    scenario: true
	},
	{
	    name: "initial_date",
	    display: "Initial loan date",
	    type: "date",
	    scenario: true
	},
	{
	    name: "year1_payment_date",
	    display: "Investor Payment date 1",
	    type: "date",
	    scenario: true
	},
	{
	    name: "year2_payment_date",
	    display: "Investor Payment date 2",
	    type: "date",
	    scenario: true
	}
    ];

    this.event_spec = [
	{   name: "header",
	    display: "<h3>Events</h3>",
	    type: "html"
	},
	{
	    name : "tenant_rent_payment",
	    display : "Tenant rent payment (monthly)",
	    type: "number",
	    value: "18000"
	},
	{
	    name : "tenant_other_fees_year1",
	    display : "Tenant other fees year1",
	    type: "number",
	    value: "0"
	},
	{
	    name : "tenant_other_fees_year2",
	    display : "Tenant other fees year2",
	    type: "number",
	    value: "0"
	},
	{   name: "rollover",
	    display: "Rollover",
	    type: "checkbox",
	    value: false
	},
	{
	    name : "tenant_actual_year1_payment_date",
	    display : "Actual tenant year 1 payment date",
	    type: "date",
	    value: "2015-09-15"
	},
	{
	    name : "tenant_actual_year2_payment_date",
	    display : "Actual tenant year 1 payment date",
	    type: "date",
	    value: "2016-09-15"
	},

	{
	    name : "tenant_actual_year1_payment",
	    display : "Actual tenant year 1 payment (excluding deposits)",
	    type: "number",
	    value: (18000 * 12).toString()
	},
	{
	    name : "tenant_actual_year2_payment",
	    display : "Actual tenant year 2 payment (excluding deposits)",
	    type: "number",
	    value: (18000 * 12).toString()
	},
	{
	    name : "actual_overhead",
	    display : "Actual overhead",
	    type: "number",
	    value: this.overhead_payment.toString()
	}
    ];
    this.event_spec.push(
	{
	    name: "header",
	    type: "note"
	}
    );
    this.event_spec.push(
	{
	    name: "terms",
	    type: "note"
	}
    );
}


Schedule_C.prototype.process_payment = function(i) {
}

Schedule_C.prototype.payments = function(calc) {
    var contract = this;
    // S.1
    calc.note({"on" : contract.initial_date,
	       "note" : "Contract becomes effective upon payment from the investor to trust"});

    // S.2
    var initial_investment = 3 * contract.landlord_rent_payment;
    var overhead_payment = contract.overhead_payment;

    console.log(contract);
    // S.4 
    var year1_payment_to_investor = contract.profit_share_fraction * 
	(12.0 *
	(contract.tenant_rent_payment - contract.landlord_rent_payment) +
	contract.tenant_other_fees_year1);
    
    var year2_payment_to_investor = contract.profit_share_fraction * 
	(12.0 *
	(contract.tenant_rent_payment - contract.landlord_rent_payment) +
	contract.tenant_other_fees_year2);

    var year1_payment_from_tenant = 12.0 * contract.tenant_rent_payment +
	contract.tenant_other_fees_year1;
    console.log(contract.tenant_rent_payment);

    var year2_payment_from_tenant = 12.0 * contract.tenant_rent_payment +
	contract.tenant_other_fees_year2;

    contract.initial_investment = initial_investment;
    contract.year1_payment_to_investor = year1_payment_to_investor;
    contract.year2_payment_to_investor = year2_payment_to_investor;
    contract.year1_payment_from_tenant = year1_payment_from_tenant;
    contract.year2_payment_from_tenant = year2_payment_from_tenant;

    // S.5
    var contract_terminates = function(params) {
	calc.terminate({"on" : params.on});
    }
    var refund_all_payments = function(params) {
	calc.transfer({"on" : params.on,
		       "from" : "trust",
		       "to" : "investor",
		       "amount" : initial_investment,
		       "note" : "refund initial investment"});
	calc.transfer({"on" : params.on,
		       "from" : "trust",
		       "to" : "investor",
		       "amount" : contract.overhead_payment,
		       "note" : "refund overhead payment"});
	calc.terminate({"on" : params.on});
    }

    var execute_landlord_contract = function(params) {
	calc.obligation({"deadline": calc.add_duration(params.actual,
						 [1, "day"]),
			"from" : "manager",
			"to" : "investor",
			"item" : "provide landlord documents"});

	calc.transfer({"on": params.actual,
		       "from" : "trust",
		       "to" : "landlord or deposit payer",
		       "amount" : initial_investment,
		       "item" : "pay deposit for flat"});
    }


    var execute_tenant_contract = function(params) {
	calc.obligation({"deadline": calc.add_duration(params.actual,
						 [1, "week"]),
			"from" : "manager",
			"to" : "investor",
			"item" : "provide tenant documents"});

	calc.transfer({"on": params.actual,
		       "from" : "tenant",
		       "to" : "trust",
		       "amount" : year1_payment_from_tenant,
		       "item" : "tenant payment to trust"});
	calc.transfer({"on": params.actual,
		       "from" : "trust",
		       "to" : "manager",
		       "amount" : contract.overhead_payment,
		       "item" : "transfer overhead payment to manager"});

	if (contract.rollover) {
	    calc.transfer({"on": params.actual,
			   "from" : "trust",
			   "to" : "new_trust",
			   "amount" : initial_investment,
			   "item" : "rollover investment to new trust"});
	};

	calc.transfer({"on": params.actual,
		       "from" : "trust",
		       "to" : "manager",
		       "amount" : contract.tenant_actual_year1_payment -
		       year1_payment_to_investor - 
		       initial_investment,
		       "item" : "transfer excess payment to manager"});
    }

    // S.6
    if (!contract.rollover) {
	calc.transfer({"on": contract.initial_date,
		       "from" : "investor",
		       "to" : "trust",
		       "amount" : initial_investment,
		       "note" : "initial investment"});
    }

    calc.transfer({"on": contract.initial_date,
		   "from" : "investor",
		   "to" : "trust",
		   "amount" : contract.overhead_payment,
		   "note" : "overhead_payment"});

    // S.7
    calc.obligation({"deadline": calc.add_duration(contract.initial_date,
						   [1, "week"]),
		   "from" : "manager",
		   "item" : "execute contract with landlord",
		   "success" : execute_landlord_contract,
		   "failure" : refund_all_payments});

    // S.8
    calc.obligation({"deadline" : calc.add_duration(contract.initial_date,
						    [1, "month"]),
		     "from": "manager",
		     "item" : "execute contract with tenants",
		     "success" : execute_tenant_contract,
		     "failure" : refund_all_payments});


    // S.9 
    calc.transfer({"on": contract.year1_payment_date,
		  "from" : "trust",
		  "to" : "investor",
		  "amount" : year1_payment_to_investor,
		  "note" : "year 1 investor payment"});

    // S.10
    calc.transfer({"on": contract.tenant_actual_year2_payment_date,
		  "from" : "tenant",
		  "to" : "trust",
		  "amount" : contract.tenant_actual_year2_payment,
		  "note" :  "year 2 tenant payment"});

    calc.transfer({"on": contract.tenant_actual_year2_payment_date,
		  "from" : "trust",
		  "to" : "manager",
		  "amount" : contract.tenant_actual_year2_payment -
		       year2_payment_to_investor,
		  "note" : "year 2 transfer excess"});

    calc.transfer({"on": contract.year2_payment_date,
		  "from" : "trust",
		  "to" : "investor",
		  "amount" : year2_payment_to_investor,
		  "note" : "year 2 investor payment"});
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
return Schedule_C;
});
