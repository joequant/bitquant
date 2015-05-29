data = {}
data.terms = ['Governing law and jurisdiction','Definitions','Interpretation',
		'Commencement','Time is of the essence','Use of funds',
		'Rollover option','Administration of funds','Regulatory activities','Representations, Warranties and Undertakings',
		'Events of Default','Amendments, Waivers and Consents and Remedies','Assignment and transfer',
		'Counterparts','Notices','Additional provisions'];

analyzer = require('./TermSheet');
contract = new analyzer();

var explanations = new Array(16);
explanations[0] = 'This clause specifies that the laws of a mutually agreed upon jurisdiction will govern the interpretation and enforcement of the terms of the contract.';
explanations[1] = 'This clause specifies the important definitions used in this contract';
explanations[2] = 'Only for testing now';
explanations[3] = 'Only for testing now';
explanations[4] = 'Only for testing now';
explanations[5] = 'Only for testing now';
explanations[6] = 'Only for testing now';
explanations[7] = 'Only for testing now';
explanations[8] = 'Only for testing now';
explanations[9] = 'Only for testing now';
explanations[10] = 'Only for testing now';
explanations[11] = 'Only for testing now';
explanations[12] = 'Only for testing now';
explanations[13] = 'Only for testing now';
explanations[14] = 'Only for testing now';
explanations[15] = 'Only for testing now';


var clauses = new Array(16);
clauses[0] = '<h5>This Agreement and any dispute or claim arising out of or in connection with it or its subject matter or formation (including non-contractual disputes or claims) shall be governed by and construed in accordance with the laws of Hong Kong.</h5>'+
 '<h5>Each party irrevocably agrees that, subject as provided below, the courts of Hong Kong shall have non-exclusive jurisdiction over any dispute or claim that arises out of, or in connection with this Agreement or its subject matter or formation (including non-contractual disputes or claims). Nothing in this clause shall limit the right of the Lender to take proceedings against the Borrower in any other court of competent jurisdiction, nor shall the taking of proceedings in any one or more jurisdictions preclude the taking of proceedings in any other jurisdictions, whether concurrently or not, to the extent permitted by the law of such other jurisdiction. This Agreement has been entered into on the date stated at the beginning of it.</h5>';

clauses[1] = '<h5>The following definitions apply in this Agreement:</h5> <ul><li>Business Day: a day other than a Saturday, Sunday or public holiday when banks in Hong Kong are open for business. </li><li>HK$: the lawful currency of Hong Kong. </li><li>Hong Kong: the Hong Kong Special Administration Region of the People’s Republic of China. </li><li></li>Related persons: shall comprise immediate relatives and other persons living in the household of a natural person, or in the case of legal persons, immediate relatives and other persons living in the household of a director or senior manager of the legal person.<li>XBT Exchange Rate: the conversion rate between HKD and XBT as quoted by ANXBTC or Bitcashout</li></ul>';

clauses[2] = '<ul><li>In this Agreement: </li>'+
	'<ul><li>unless the context otherwise requires, words in the singular shall include the plural and in the plural shall include the singular; </li>'+
	'<li>unless the context otherwise requires, a reference to one gender shall include a reference to the other genders;</li>'+
	'<li>a reference to a party shall include that party\'s successors, permitted assigns and permitted transferees; </li>'+
	'<li>a reference to a statute or statutory provision is a reference to it as amended, extended or re-enacted from time to time; </li>'+
	'<li>a reference to writing or written includes mail, fax and e-mail; </li>'+
	'<li>unless the context othoerwise requires, a reference to a clause or Schedule is to a clause of, or Schedule to, this Agreement; </li>'+
	'<li>any words following the terms including, include, in particular, for example or any similar expression shall be construed as illustrative and shall not limit the sense of the words, description, definition, phrase or term preceding those terms. </li></ul></ul>'+
	'<ul><li>The Schedules are written in the javascript, and shall form part of this Agreement and shall have effect as if set out in full in the body of this Agreement. Any reference to this Agreement includes the Schedules.</li></ul>' + 
	'<ul><li>In case of any inconsistency between the body of the Agreement and the Schedules, the body of the Agreement shall prevail, in which case the parties may amend the Schedules in good faith to reflect the body of the Agreement.</li></ul>';


clauses[3] = '<h5>This Agreement shall be deemed to have commenced on the date of this Agreement.</h5>';
clauses[4] = '<h5>Time is of the essence in this agreement.</h5>';

clauses[5] = '<li>Any funds received by the manager, its agents, or related persons of the manager or its agents, excluding refunds of deposits, in connection with the named property shall be the property of this trust, and may only be used in accordance with the terms and conditions of this agreement.</li>'+
	'<li>During the existence of this trust, the manager or any agent of the manager or any person related to the manager may not collect or cause to be collected any non-refundable funds concerning the named property other than rent which has been executed via a written agreement which has been provided to the beneficiary or which have otherwise expressly been disclosed in writing to the beneficiary. The manager agrees that any funds that have not been expressly disclosed to the beneficiary shall immediately become the property of the beneficiary. </li>'+
	'<li>Any funds owned by the trust which are in excess of that what is necessary to fulfil the payment obligations of the trust to the beneficiary in that calendar year, shall immediately become the property of the manager, who may thereupon use those funds for any purpose whatsoever.</li>'+
	'<li>The initial investment, as defined in Schedule A, may only be used for the purpose of paying for the deposit and rent advances for the named property or as reimbursement to any person who has paid said fees.</li>'+
	'<li>Upon presentation of the landlord documents as specified in Schedule A, ownership of the and funds associated with the overhead fee as defined in Schedule A shall immediate pass from the trust to the manager, who may use these funds for any purpose whatsoever.</li>';

clauses[6] = '<h5>Upon execution of the tenant lease, the beneficiary of the agreement may direct that the trustee release the investment fee to the manager for the purpose of concluding another investment agreement.</h5>';


clauses[7] = '<li>The trustee shall have authority to keep the funds owned by the trust in any business cash account normally used by the trustee for business operations, provided that the trustee shall have reasonable belief that no event shall occur that would prevent the trustee from fulfiling their obligations to the beneficiary. In the event that the trustee has reasonable belief that keeping the funds owned by the trust in said account may prevent the trustee from fulfilling its obligations under this agreement, it shall forthwith segregate the funds owned by the trust from other funds owned by the trustee. </li>' +
	'<li>The trustee shall insure that any funds held by the trust shall be stored in a form which is commonly used for the storage of cash for businesses. Examples of these forms include but are not limited to insured bank accounts and stored value card. In no event shall the trustee pledge funds owned by the trust as collateral to any third party, nor may the trustee use the funds owned by the trust for investment purposes without the express written consent of the beneficiary. </li>' +
	'<li>The trustee shall have authority to appoint a trust administrator to mangage funds in the trust. </li>' +
	'<li>In the event, that the settlor has a reasonable belief that the trustee is unable to properly administer the terms of the trust, the settlor shall have authority to revoke the authority of the trustee and appoint a new trustee to manage the funds owned by the trust. This action shall not affect the distribution or ownership of funds. </li>' +
	'<li>The beneficiary of this trust has the authority to revoke the trust agreement at any time, upon which time any funds owned by the trust shall be transfered to the beneficiary. </li>' +
	'<li>This trust shall automatically terminate when the trustee has fulfiled all obligations owed to the beneficiary as specified in Schedule A.</li>' ;

clauses[8] = '<li>If any provision (or part of a provision) of this Agreement is or becomes invalid, illegal or unenforceable, it shall be deemed modified to the minimum extent necessary to make it valid, legal and enforceable. If such modification is not possible, the relevant provision (or part of a provision) shall be deemed deleted. Any modification to or deletion of a provision (or part of a provision) under this clause shall not affect the legality, validity and enforceability of the rest of this Agreement. </li>' +
	'<li>It is the express intention of the settlor that this agreement should not constitute a collective investment scheme as defined by the laws of Hong Kong, and the trustee shall take all reasonable actions necessary to prevent this agreement from constituting a collective investment scheme. </li>' +
	'<li>It is the express intention of the settlor that the issuance, sale, resale, and marketing of this agreement, shall not constitute a regulated activity under the Securities Futures Ordinance of the laws of Hong Kong, and the trustee shall take all reasonable actions necessary so that the issuance, sale, resale, and marketing of this agreement not be construed as performing a regulated activity under the Securities Futures Ordinance. </li>' +
	'<li>In the event that this agreement is deemed or is likely to be deemed to be a collective investment scheme by any governmental authority having jurisdiction over Hong Kong or in the event that issuance, sale, resale, and marketing of this agreement is deemed or is likely to be deemed a regulated activity under the Securities Futures Ordinance by any governmental authority having jurisdiction over Hong Kong, the trustees are authorized to take any reasonable and lawful efforts to challenge or prevent said determination and are authorized to use up to five percent of the funds that due to the beneficiary.</li>' +
	'<li>In the event that this agreement is deemed or is likely to be deemed to be a collective investment scheme by any governmental authority having jurisdiction over Hong Kong or in the event that issuance, sale, resale, and marketing of this agreement is deemed or is likely to be deemed a regulated activity under the Securities Futures Ordinance by any governmental authority having jurisdiction over Hong Kong, the settlor is authorized to direct the trustee to use a reasonable portion of the fund not exceeding five percent of the amount owned by the trust to conduct any reasonable and lawful efforts intended to challenge or prevent said government action. </li>' +
	'<li>In the event that the trustee has a reasonable belief that its ability to perform the actions specified in the trust agreement is limited or will be limited by any actual or proposed action by any governmental authority having jurisdiction over Hong Kong, the trustee is authorized to use the funds owned by the trust to fund any reasonable and lawful efforts intended to challenge or prevent said government action, provided that the amounts used do not exceed the likely cost to the beneficiary associated with said government action.</li>' +
	'<li>In the event that the settlor has a reasonable belief that the ability of the trustee to ability to perform the actions specified in the trust agreement is limited or will be limited by any actual or proposed action by any governmental authority having jurisidiction over Hong Kong, the settlor is authorized to direct the trustee to use a reasonable portion of the fund to conduct any reasonable and lawful efforts intended to challenge or prevent said government action, provided that the amounts used do not exceed the likely cost of said government action. 9.8 Funding the aforesaid reasonable and lawful activities may include contributions to reasonable and lawful collective activities in cooperation with third parties to challenge or prevent a determination by governmental authorities. 9.9 For the purpose of computing the cost of a said government action, a reasonable expense associated with time and inconvenience may be included.</li>' ;

clauses[9] = '<ul><li>The Trustee represents, warrants and undertakes to the Settlor on the date of this Agreement:</li>' + 
'<ul><li>(a) is a duly incorporated limited liability company validly existing under the laws of its jurisdiction of incorporation;</li>' +  
'<li>(b) has the power to enter into, deliver and perform, and has taken all necessary action to authorise its entry into, delivery and performance of, this Agreement; and</li>' +  
'<li>(c) has obtained all required authorisations to enable it to enter into, exercise its rights and comply with its obligations in this Agreement.</li></ul></ul>' +  
'<ul><li>The entry into and performance by it of, and the transactions contemplated by, this Agreement, do not and will not contravene or conflict with:</li>' + 
'<ul><li>(a) its constitutional documents; </li>' +  
'<li>(b) any agreement or instrument binding on it or its assets or constitute a default or termination event (however described) under any such agreement or instrument; or </li>' +   
'<li>(c) any law or regulation or judicial or official order, applicable to it.</li></ul></ul>' +    
'<ul><li>The information, in written or electronic format, supplied by, or on its behalf, to the Investor in connection with this Agreement was, at the time it was/will be supplied or at the date it was/will be stated to be given (as the case may be):</li>' +  
'<ul><li>(a) if it was factual information, complete, true and accurate in all material respects;  </li>' + 
'<li>(b) if it was a financial projection or forecast, prepared on the basis of recent historical information and on the basis of reasonable assumptions and was fair and made on reasonable grounds; and  </li>' + 
'<li>(c) if it was an opinion or intention, made after careful consideration and was fair and made on reasonable grounds; and  </li>' + 
'<li>(d) not misleading in any material respect, nor rendered misleading by a failure to disclose other information.</li></ul>'+
'<li>BOTH THE MANAGER AND THE TRUSTEE FULLY, COMPLETELY, AND ABSOLUTELY INDEMNIFIES THE TRUST, SETTLOR, AND BENEFICIARY OF ANY AND ALL LIABILITY AND CLAIMS BY THIRD PARTIES ARISING FROM ACTIVITIES CONCERNING THE NAMED PROPERTY, INCLUDING BUT NOT LIMITED TO BREACH OF CONTRACT, NON-PAYMENT OF RENT, BREACH OF WARRANTY AND REPRESENTATIONS, AND FALSE ADVERTISING. IN NO EVENT MAY THE TRUSTEE USE OR ALLOW TO BE USED FUNDS OWNED BY THE TRUST TO SATISFY CLAIMS BY THIRD PARTIES AGAINST THE MANAGER. THIS INDEMNITY SHALL CONTINUE AFTER THE TERMINATION OF THE TRUST.</li></ul>';

clauses[10] = '<ul><li>Each of the events or circumstances set out in this clause is an Event of Default: </li>'+
	'<ul><li>The Manager fails to pay any sum payable by it under this Agreement. </li>'+
	'<li>The Manager fails (other than by failing to pay), to comply with any provision of this Agreement and (if the Investor considers, acting reasonably, that the default is capable of remedy), such default is not remedied within 7 Business Days of the earlier of: </li>'+
	'<ul><li>the Investor notifying the Manager of the default and the remedy required; </li><li>the Manager becoming aware of the default. </li></ul>' +
	'<li>Any representation, warranty or statement made, repeated or deemed made by the Manager in, or pursuant to, this Agreement is (or proves to have been) incomplete, untrue, incorrect or misleading when made or deemed made. </li>'+
	'<li>The Manager suspends or ceases to carry on (or threatens to suspend or cease to carry on) all or a substantial part of its business. </li>'+
	'<li>The passing of a resolution for the winding up of the Manager; or the appointment of a receiver, administrator or administrative receiver over the whole or any part of the assets of the Manager or the making of any arrangement with the creditors of the Manager for the affairs, business and property of the Manager to be managed by a supervisor.</li></ul></ul>';

clauses[11] = '<ul><li>No amendment of this Agreement shall be effective unless it is in writing and signed by, or on behalf of, each party to it (or its authorised representative).</li>'+
	'<li>A waiver of any right or remedy under this Agreement or by law, or any consent given under this Agreement, is only effective if given in writing by the waiving or consenting party and shall not be deemed a waiver of any other breach or default. It only applies in the circumstances for which it is given and shall not prevent the party giving it from subsequently relying on the relevant provision.</li>' +
	'<li>A failure or delay by a party to exercise any right or remedy provided under this Agreement or by law shall not constitute a waiver of that or any other right or remedy, prevent or restrict any further exercise of that or any other right or remedy or constitute an election to affirm this Agreement. No election to affirm this Agreement by the Lender shall be effective unless it is in writing. </li><li> The rights and remedies provided under this Agreement are cumulative and are in addition to, and not exclusive of, any rights and remedies provided by law.</li></ul>';


clauses[12] = '<ul><li>The beneficiary may assign any of its rights under this Agreement or transfer all its rights or obligations by novation, provided that the beneficiary of this agreement must consist of a single natural or legal person or legal entity, and provided that the beneficiary has notified the trustee in writing that the rights made under the agreement have been assigned. </li>'+
	'<li>The trustee may not assign any of its rights or transfer any of its rights or obligations under this Agreement without the consent of the beneficiary.</li></ul>';

clauses[13] = '<ul><li>This Agreement may be executed in any number of counterparts, each of which when executed shall constitute a duplicate original, but all the counterparts shall together constitute one agreement.</li>'+
	'<li>No counterpart shall be effective until each party has executed at least one counterpart.</li></ul>';


clauses[14] = '<ul><li>Any notice or other communication given to a party under or in connection with this Agreement shall be: </li><ul><li>in writing;</li><li>delivered by hand, by pre-paid first-class post or other next working day delivery service or sent by fax; and </li><li>sent to: </li>'+
	'<ul><li>the Manager at: <br/>Address:' + contract.manager.contact.address + '<br/>Email:' + contract.manager.contact.email + '<br/>Attention:' + contract.manager.contact.name +
	'</li><li>the Investor at: <br/>Address:' + contract.investor.contact.address + '<br/>Email:' + contract.investor.contact.email + '<br/>Attention:' + contract.investor.contact.name  +
	'</li><li>or to any other address or fax number as is notified in writing by one party to the other from time to time.</li></ul>' +
	'</ul><li> Any notice or other communication that the Investor gives to the Manager under or in connection with, this Agreement shall be deemed to have been received: </li><ul>'+
	'<li>if delivered by hand, at the time it is left at the relevant address; </li>' +
	'<li>if posted by pre-paid first-class post or other next working day delivery service, on the second Business Day after posting; and </li>' +
	'<li>if sent by fax or email, when received in legible form. </li>' +
	'</ul><li>A notice or other communication given on a day that is not a Business Day, or after normal business hours, in the place it is received, shall be deemed to have been received on the next Business Day. </li>'+
	'<li>Any notice or other communication given to the Investor shall be deemed to have been received only on actual receipt.</li></ul>';

clauses[15] = '<ul><li>Related parties shall include the agent, its directors, senior managers, investors providing more than 10% of working capital or equity, and their immediate household.</li>' +
	'<li>Landlord documents refers to an executed lease agreement between the manager and the landlord designated property for a term of two years. The lease between the landlord and the manager must contain the following provisions:'+
	'<ul><li>The lease agreement allow subletting</li><li>The lease agreement must be for a period of no less than two years and must containing no provision allowing for early termination of the lease.</li><li>The lease agreement must make the landlord responsible for keeping the property in good repair, and for the costs of maintainence and repair.</li></ul></li>' +
	'<li>Tenant documents refers to an executed agreement between an agent and the tenants of the property, and must include the name and contact information of a representative of the tenant. The agreed rent paid to the agent must exceed the rent paid to the landlord.</li>' +
	'<li>Tenant fees includes any non-refundable fees paid by the tenants to the agent for the purpose of securing or maintaining the property. Tenant fees excludes any refundable deposits.</li></ul>' ;


data.clauses = clauses
data.explanations = explanations

module.exports = data