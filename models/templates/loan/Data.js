vdata = {}
vdata.terms = ['Governing law and jurisdiction','Definitions','Interpretation',
		'Commencement','Purpose','Commencement',
		'Interest','Costs','Repayment','Representations, Warranties and Undertakings',
		'Events of Default','Amendments, Waivers and Consents and Remedies','Assignment and transfer',
		'Counterparts','Severance','Notices','Additional provisions'];

analyzer = require('./TermSheet');
contract = new analyzer();

var explanations = new Array(17);
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
explanations[16] = 'Only for testing now';


var clauses = new Array(17);
clauses[0] = '<h5>This Agreement and any dispute or claim arising out of or in connection with it or its subject matter or formation (including non-contractual disputes or claims) shall be governed by and construed in accordance with the laws of Hong Kong.</h5>'+
 '<h5>Each party irrevocably agrees that, subject as provided below, the courts of Hong Kong shall have non-exclusive jurisdiction over any dispute or claim that arises out of, or in connection with this Agreement or its subject matter or formation (including non-contractual disputes or claims). Nothing in this clause shall limit the right of the Lender to take proceedings against the Borrower in any other court of competent jurisdiction, nor shall the taking of proceedings in any one or more jurisdictions preclude the taking of proceedings in any other jurisdictions, whether concurrently or not, to the extent permitted by the law of such other jurisdiction. This Agreement has been entered into on the date stated at the beginning of it.</h5>';

clauses[1] = '<h5>The following definitions apply in this Agreement:</h5> <ul><li>Business Day: a day other than a Saturday, Sunday or public holiday when banks in Hong Kong are open for business. </li><li>Event of Default: any event or circumstance listed in clause 11.</li><li>Facility: the term loan facility made available under this Agreement. </li><li>HK$: the lawful currency of Hong Kong. </li><li>Hong Kong: the Hong Kong Special Administration Region of the People’s Republic of China. </li><li>Loan: the principal amount of the loan made or to be made by the Lender to the Borrower under this Agreement or (as the context requires) the principal amount outstanding for the time being of that loan. </li><li> Product: the watermelon compression system </li><li>XBT Exchange Rate: the conversion rate between HKD and XBT as quoted by ANXBTC or Bitcashout</li></ul>';

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


clauses[3] = '<h5>The Lender grants to the Borrower an unsecured Facility in accordance with Schedule A, subject to conditions of this Agreement.</h5>';
clauses[4] = '<h5>The Borrower shall use all money borrowed under this Agreement for the sole purpose of expanding its business. </h5>'+
	'<h5>The Lender is not obliged to monitor or verify how any amount advanced under this Agreement is used.</h5>';


clauses[5] = '<h5>This Agreement shall be deemed to have commenced on the date of this Agreement.</h5>';

clauses[6] = '<h5>Interest accrue and be payable in accordance with Schedule C of this Agreement.</h5>' +
	'<h5>If the Borrower fails to make any payment due under this Agreement on the due date for payment, interest on the unpaid amount and be payable in accordance with Schedule B of this Agreement.</h5>';

clauses[7] = '<h5>The Lender shall bear all costs and expenses (together with any value added tax on them) that the Lender incurs in connection with the negotiation and preservation and enforcement of the Loan and/or this Agreement.</h5>'+
'<h5>The Borrower shall pay any stamp, documentary and other similar duties and taxes (if any) to which this Agreement may be subject, or give rise and shall indemnify the Lender against any losses or liabilities that it may incur as a result of any delay or omission by the Borrower in paying any such duties or taxes.</h5>';

clauses[8] = '<h5>The Borrower shall repay the Loan as specified in the attached Schedule C.</h5>'+
	'<h5>All payments made by the Borrower under this Agreement shall be made in full, without set-off, counterclaim or condition, and free and clear of, and without any deduction or withholding.</h5>';


clauses[9] = '<ul><li>The Borrower represents, warrants and undertakes to the Lender on the date of this Agreement:</li>' + 
'<ul><li>(a) is a duly incorporated limited liability company validly existing under the laws of its jurisdiction of incorporation;</li>' +  
'<li>(b) has the power to enter into, deliver and perform, and has taken all necessary action to authorise its entry into, delivery and performance of, this Agreement; and</li>' +  
'<li>(c) has obtained all required authorisations to enable it to enter into, exercise its rights and comply with its obligations in this Agreement.</li></ul></ul>' +  
'<ul><li>The entry into and performance by it of, and the transactions contemplated by, this Agreement, do not and will not contravene or conflict with:</li>' + 
'<ul><li>(a) its constitutional documents; </li>' +  
'<li>(b) any agreement or instrument binding on it or its assets or constitute a default or termination event (however described) under any such agreement or instrument; or </li>' +   
'<li>(c) any law or regulation or judicial or official order, applicable to it.</li></ul></ul>' +    
'<ul><li>The information, in written or electronic format, supplied by, or on its behalf, to the Lender in connection with this Agreement was, at the time it was/will be supplied or at the date it was/will be stated to be given (as the case may be):</li>' +  
'<ul><li>(a) if it was factual information, complete, true and accurate in all material respects;  </li>' + 
'<li>(b) if it was a financial projection or forecast, prepared on the basis of recent historical information and on the basis of reasonable assumptions and was fair and made on reasonable grounds; and  </li>' + 
'<li>(c) if it was an opinion or intention, made after careful consideration and was fair and made on reasonable grounds; and  </li>' + 
'<li>(d) not misleading in any material respect, nor rendered misleading by a failure to disclose other information.</li></ul></ul>';

clauses[10] = '<ul><li>Each of the events or circumstances set out in this clause is an Event of Default: </li>'+
	'<ul><li>The Borrower fails to pay any sum payable by it under this Agreement. </li>'+
	'<li>The Borrower fails (other than by failing to pay), to comply with any provision of this Agreement and (if the Lender considers, acting reasonably, that the default is capable of remedy), such default is not remedied within 7 Business Days of the earlier of: </li>'+
	'<ul><li>the Lender notifying the Borrower of the default and the remedy required;</li><li>the Borrower becoming aware of the default.</li></ul>' +
	'<li>Any representation, warranty or statement made, repeated or deemed made by the Borrower in, or pursuant to, this Agreement is (or proves to have been) incomplete, untrue, incorrect or misleading when made or deemed made. </li>'+
	'<li>The Borrower suspends or ceases to carry on (or threatens to suspend or cease to carry on) all or a substantial part of its business. </li>'+
	'<li>a reference to writing or written includes mail, fax and e-mail; </li>'+
	'<li>The passing of a resolution for the winding up of the Borrower; or the appointment of a receiver, administrator or administrative receiver over the whole or any part of the assets of the Borrower or the making of any arrangement with the creditors of the Borrower for the affairs, business and property of the Borrower to be managed by a supervisor.</li></ul></ul>';

clauses[11] = '<ul><li>No amendment of this Agreement shall be effective unless it is in writing and signed by, or on behalf of, each party to it (or its authorised representative).</li>'+
	'<li>A waiver of any right or remedy under this Agreement or by law, or any consent given under this Agreement, is only effective if given in writing by the waiving or consenting party and shall not be deemed a waiver of any other breach or default. It only applies in the circumstances for which it is given and shall not prevent the party giving it from subsequently relying on the relevant provision.</li>' +
	'<li>A failure or delay by a party to exercise any right or remedy provided under this Agreement or by law shall not constitute a waiver of that or any other right or remedy, prevent or restrict any further exercise of that or any other right or remedy or constitute an election to affirm this Agreement. No election to affirm this Agreement by the Lender shall be effective unless it is in writing. </li><li> The rights and remedies provided under this Agreement are cumulative and are in addition to, and not exclusive of, any rights and remedies provided by law.</li></ul>';


clauses[12] = '<ul><li>The Lender may assign any of its rights under this Agreement or transfer all its rights or obligations by novation. </li>'+
	'<li>The Borrower may not assign any of its rights or transfer any of its rights or obligations under this Agreement.</li></ul>';

clauses[13] = '<ul><li>This Agreement may be executed in any number of counterparts, each of which when executed shall constitute a duplicate original, but all the counterparts shall together constitute one agreement.</li>'+
	'<li>No counterpart shall be effective until each party has executed at least one counterpart.</li></ul>';

clauses[14] = '<h5>If any provision (or part of a provision) of this Agreement is or becomes invalid, illegal or unenforceable, it shall be deemed modified to the minimum extent necessary to make it valid, legal and enforceable. If such modification is not possible, the relevant provision (or part of a provision) shall be deemed deleted. Any modification to or deletion of a provision (or part of a provision) under this clause shall not affect the legality, validity and enforceability of the rest of this Agreement.</h5>';

clauses[15] = '<ul><li>Any notice or other communication given to a party under or in connection with this Agreement shall be: </li><ul><li>in writing;</li><li>delivered by hand, by pre-paid first-class post or other next working day delivery service or sent by fax; and </li><li>sent to: </li>'+
	'<ul><li>the Borrower at: <br/>Address:' + contract.borrower.contact.address + '<br/>Email:' + contract.borrower.contact.email + '<br/>Attention:' + contract.borrower.contact.name +
	'</li><li>the Lender at: <br/>Address:' + contract.lender.contact.address + '<br/>Email:' + contract.lender.contact.email + '<br/>Attention:' + contract.lender.contact.name  +
	'</li><li>or to any other address or fax number as is notified in writing by one party to the other from time to time.</li></ul>' +
	'</ul><li>Any notice or other communication that the Lender gives to the Borrower under or in connection with, this Agreement shall be deemed to have been received: </li><ul>'+
	'<li>if delivered by hand, at the time it is left at the relevant address; </li>' +
	'<li>if posted by pre-paid first-class post or other next working day delivery service, on the second Business Day after posting; and </li>' +
	'<li>if sent by fax or email, when received in legible form. </li>' +
	'</ul><li>A notice or other communication given on a day that is not a Business Day, or after normal business hours, in the place it is received, shall be deemed to have been received on the next Business Day. </li>'+
	'<li>Any notice or other communication given to the Lender shall be deemed to have been received only on actual receipt.</li></ul>';


clauses[16] = '<ul><li>AFor the purpose of of computing accelerated payments in this Agreement, the revenue shall be the cumulative gross receipts received by the Borrower, any subsidiaries or holding companies of the Borrower, or any other companies controlled by or affliated with the Borrower. Gross receipts shall include income derived from sales of the Product as well as an licensing fees received in conjunction with the Product or any intellectual property associated with the product. </li>'+
	'<li>During the term of the Facility, the Borrower agrees to provide the Lender on at least a monthly basis an accounting gross receipts received in conjunction with the sales or licensing of the Product and any associated intellectual property, and to notify the Lender within three (3) Business Days if the Borrower has reasons to believe that the cumulative gross receipts has exceeded the revenue targets specified in this contract.</li>'+
	'<li>Any principal due under this Agreement may be paid via HKD or via bitcoins based on the XBT Exchange Rate. Any interest (including default interest) due under this Agreement must be paid via bitcoins based on the XBT Exchange Rate.</li></ul>';


vdata.clauses = clauses
vdata.explanations = explanations

module.exports = vdata