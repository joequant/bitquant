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
  * Business Day: a day other than a Saturday, Sunday or public holiday in England when banks in London are open for business.
  * Commencement Date: the date that the Lessee takes Delivery of the Equipment.
  * Delivery: the transfer of physical possession of the Equipment to the Lessee at the Site.
  * Deposit: the deposit amount set out in the Payment Schedule.
  * Equipment: the items of equipment listed in Schedule 2, all substitutions, replacements or renewals of such equipment and all related accessories, manual and instructions provided for it.
  Payment Schedule: Schedule 1 which sets out the sums payable under this agreement.
[Purchase Option: the Lessee's option to purchase the Equipment as more fully described in clause 8.]
[Purchase Option Price: the price of the Purchase Option as set out in the Payment Schedule.]
Site: the Lessee's premises at [LOCATION].
Rental Payments: the payments made by or on behalf of Lessee for hire of the Equipment.
Rental Period: the period of hire as set out in clause 3.
Total Loss: [due to the Lessee's default] the Equipment is, in the Lessor's reasonable opinion [or the opinion of its insurer(s)], damaged beyond repair, lost, stolen, seized or confiscated.
VAT: value added tax chargeable under the Value Added Tax Act 1994.
1.2 Clause, schedule and paragraph headings shall not affect the interpretation of this agreement.
1.3 A person includes a natural person, corporate or unincorporated body (whether or not having separate legal personality) [and that person's legal and personal representatives, successors and permitted assigns]. 
1.4 The schedules form part of this agreement and shall have effect as if set out in full in the body of this agreement and any reference to this agreement includes the schedules. 
1.5 A reference to a company shall include any company, corporation or other body corporate, wherever and however incorporated or established. 
1.6 Unless the context otherwise requires, words in the singular shall include the plural and vice versa. 
1.7 Unless the context otherwise requires, a reference to one gender shall include a reference to the other genders. 
1.8 A reference to a statute or statutory provision is a reference to it as [amended, extended or re-enacted from time to time OR it is in force as at the date of this agreement].
1.9 A reference to a statute or statutory provision shall include all subordinate legislation made [from time to time OR as at the date of this agreement] under that statute or statutory provision.
1.10 A reference to writing or written includes fax [and e-mail OR but not e-mail].
1.11 Any obligation on a party not to do something includes an obligation not to allow that thing to be done.
1.12 [A reference to this agreement or to any other agreement or document referred to in this agreement is a reference to this agreement or such other agreement or document as varied or novated (in each case, other than in breach of the provisions of this agreement) from time to time.]
1.13 References to clauses and schedules are to the clauses and schedules of this agreement and references to paragraphs are to paragraphs of the relevant schedule. 
1.14 Any words following the terms including, include, in particular, for example or any similar expression shall be construed as illustrative and shall not limit the sense of the words, description, definition, phrase or term preceding those terms.
2. Equipment hire
2.1 The Lessor shall hire the Equipment to the Lessee [for use at the Site] subject to the terms and conditions of this agreement. 
2.2 The Lessor shall not, other than in the exercise of its rights under this agreement or applicable law, interfere with the Lessee's quiet possession of the Equipment.
3. Rental Period
The Rental Period starts on the Commencement Date and shall continue for a period of [NUMBER] [months OR years] unless this agreement is terminated earlier in accordance with its terms.
4. Rental Payments and Deposit
4.1 The Lessee shall pay the Rental Payments to the Lessor in accordance with the Payment Schedule. The Rental Payments shall be paid in [CURRENCY] and shall be made by [PAYMENT METHOD].
4.2 The Rental Payments are exclusive of VAT and any other applicable taxes and duties or similar charges which shall be payable by the Lessee at the rate and in the manner from time to time prescribed by law. 
4.3 All amounts due under this agreement shall be paid in full without any set-off, counterclaim, deduction or withholding (other than any deduction or withholding of tax as required by law).
4.4 If the Lessee fails to make any payment due to the Lessor under this agreement by the due date for payment, then, without limiting the Lessor's remedies under clause 11, the Lessee shall pay interest on the overdue amount at the rate of [4]% per annum above [FULL NAME OF BANK]'s base rate from time to time. Such interest shall accrue on a daily basis from the due date until actual payment of the overdue amount, whether before or after judgment. The Lessee shall pay the interest together with the overdue amount.
4.5 The Deposit is a deposit against default by the Lessee of payment of any Rental Payments or any loss of or damage caused to the Equipment. The Lessee shall, on the date of this agreement, pay a deposit of £[AMOUNT] to the Lessor. If the Lessee fails [without due cause] to make any Rental Payments in accordance with the Payment Schedule, or causes any loss or damage to the Equipment (in whole or in part), the Lessor shall be entitled to apply the Deposit against such default, loss or damage. The Lessee shall pay to the Lessor any sums deducted from the Deposit within ten (10) Business Days of a demand for the same. The Deposit (or balance thereof) shall be refundable within [five (5)] Business Days of the end of the Rental Period.
5. Delivery [and installation]
5.1 Delivery of the Equipment shall be made by the Lessor. The Lessor shall use all reasonable endeavours to effect Delivery by the date and time agreed between the parties. Title and risk shall transfer in accordance with clause 6 of this agreement.
5.2 [The Lessee shall procure that a duly authorised representative of the Lessee shall be present at the Delivery of the Equipment. Acceptance of Delivery by such representative shall constitute conclusive evidence that the Lessee has examined the Equipment and has found it to be in good condition, complete and fit in every way for the purpose for which it is intended [(save as regards any latent defects not reasonably apparent on inspection)]. If required by the Lessor, the Lessee's duly authorised representative shall sign a receipt confirming such acceptance.]
OR
5.3 [The Lessor shall at the Lessee's expense install the Equipment at the Site. The Lessee shall procure that a duly authorised representative of the Lessee shall be present at the installation of the Equipment. Acceptance by such representative of installation shall constitute conclusive evidence that the Lessee has examined the Equipment and has found it to be in good condition, complete and fit in every way for the purpose for which it is intended  [(save as regards any latent defects not reasonably apparent on inspection)]. If required by the Lessor, the Lessee's duly authorised representative shall sign a receipt confirming such acceptance.]
5.4 To facilitate Delivery [and installation], the Lessee shall [at its sole expense] provide all requisite materials, facilities, access and suitable working conditions to enable Delivery [and installation] to be carried out safely and expeditiously [including the materials, facilities, access and working conditions specified in Schedule [ ]].
6. Title, risk and insurance
6.1 The Equipment shall at all times remain the property of the Lessor, and the Lessee shall have no right, title or interest in or to the Equipment (save the right to possession and use of the Equipment subject to the terms and conditions of this agreement) [except where the Lessee purchases the Equipment pursuant to the Purchase Option in clause 8]. 
6.2 The risk of loss, theft, damage or destruction of the Equipment shall pass to the Lessee on Delivery. The Equipment shall remain at the sole risk of the Lessee during the Rental Period and any further term during which the Equipment is in the possession, custody or control of the Lessee (Risk Period) until such time as the Equipment is redelivered to the Lessor. During the Rental Period and the Risk Period, the Lessee shall, at its own expense, obtain and maintain the following insurances:
(a) insurance of the Equipment to a value not less than its full replacement value comprehensively against all usual risks of loss, damage or destruction by fire, theft or accident, and such other risks as the Lessor may from time to time nominate in writing;
(b) insurance for such amounts as a prudent owner or operator of the Equipment would insure for, or such amount as the Lessor may from time to time reasonably require, to cover any third party or public liability risks of whatever nature and however arising in connection with the Equipment; and
(c) insurance against such other or further risks relating to the Equipment as may be required by law, together with such other insurance as the Lessor may from time to time consider reasonably necessary and advise to the Lessee.
6.3 All insurance policies procured by the Lessee shall be endorsed to provide the Lessor with at least [twenty (20)] Business Days' prior written notice of cancellation or material change (including any reduction in coverage or policy amount) and shall upon the Lessor's request name the Lessor on the policies as a loss payee in relation to any claim relating to the Equipment. The Lessee shall be responsible for paying any deductibles due on any claims under such insurance policies.
6.4 The Lessee shall give immediate written notice to the Lessor in the event of any loss, accident or damage to the Equipment arising out of or in connection with the Lessee's possession or use of the Equipment.
6.5 If the Lessee fails to effect or maintain any of the insurances required under this agreement, the Lessor shall be entitled to effect and maintain the same, pay such premiums as may be necessary for that purpose and recover the same as a debt due from the Lessee.
6.6 The Lessee shall, on demand, supply copies of the relevant insurance policies or other insurance confirmation acceptable to the Lessor and proof of premium payment to the Lessor to confirm the insurance arrangements.
7. Lessee's responsibilities
7.1 The Lessee shall during the term of this agreement:
(a) ensure that the Equipment is kept and operated in a suitable environment[, which shall as a minimum meet the requirements set out in Schedule [ ]], used only for the purposes for which it is designed, and operated in a proper manner by trained competent staff in accordance with any operating instructions [provided by the Lessor];
(b) take such steps (including compliance with all safety and usage instructions provided by the Lessor) as may be necessary to ensure, so far as is reasonably practicable, that the Equipment is at all times safe and without risk to health when it is being set, used, cleaned or maintained by a person at work;
(c) maintain at its own expense the Equipment in good and substantial repair in order to keep it in as good an operating condition as it was on the Commencement Date (fair wear and tear only excepted) including replacement of worn, damaged and lost parts, and shall make good any damage to the Equipment;
(d) make no alteration to the Equipment and shall not remove any existing component(s) from the Equipment [without the prior written consent of the Lessor [unless carried out to comply with any mandatory modifications required by law or any regulatory authority or]] unless the component(s) is/are replaced immediately (or if removed in the ordinary course of repair and maintenance as soon as practicable) by the same component or by one of a similar make and model or an improved/advanced version of it. Title and property in all substitutions, replacements, renewals made in or to the Equipment shall vest in the Lessor immediately upon installation;
(e) keep the Lessor fully informed of all material matters relating to the Equipment;
(f) [keep the Equipment at all times at the Site and shall not move or attempt to move any part of the Equipment to any other location without the Lessor's prior written consent OR at all times keep the Equipment in the possession or control of the Lessee and keep the Lessor informed of its location];
(g) permit the Lessor or its duly authorised representative to inspect the Equipment at all reasonable times and for such purpose to enter upon the Site or any premises at which the Equipment may be located, and shall grant reasonable access and facilities for such inspection;
(h) maintain operating and maintenance records of the Equipment and make copies of such records readily available to the Lessor, together with such additional information as the Lessor may reasonably require;
(i) not, without the prior written consent of the Lessor, part with control of (including for the purposes of repair or maintenance), sell or offer for sale, underlet or lend the Equipment or allow the creation of any mortgage, charge, lien or other security interest in respect of it;
(j) not without the prior written consent of the Lessor, attach the Equipment to any land or building so as to cause the Equipment to become a permanent or immovable fixture on such land or building. If the Equipment does become affixed to any land or building then the Equipment must be capable of being removed without material injury to such land or building and the Lessee shall repair and make good any damage caused by the affixation or removal of the Equipment from any land or building and indemnify the Lessor against all losses, costs or expenses incurred as a result of such affixation or removal;
(k) not do or permit to be done any act or thing which will or may jeopardise the right, title and/or interest of the Lessor in the Equipment and, where the Equipment has become affixed to any land or building, the Lessee must take all necessary steps to ensure that the Lessor may enter such land or building and recover the Equipment both during the term of this agreement and for a reasonable period thereafter, including by procuring from any person having an interest in such land or building, a waiver in writing and in favour of the Lessor of any rights such person may have or acquire in the Equipment and a right for the Lessor to enter onto such land or building to remove the Equipment;
(l) not suffer or permit the Equipment to be confiscated, seized or taken out of its possession or control under any distress, execution or other legal process, but if the Equipment is so confiscated, seized or taken, the Lessee shall notify the Lessor and the Lessee shall at its sole expense use its best endeavours to procure an immediate release of the Equipment and shall indemnify the Lessor on demand against all losses, costs, charges, damages and expenses incurred as a result of such confiscation;
(m) not use the Equipment for any unlawful purpose;
(n) ensure that at all times the Equipment remains identifiable as being the Lessor's property and wherever possible shall ensure that a visible sign to that effect is attached to the Equipment;
(o) deliver up the Equipment at the end of the Rental Period or on earlier termination of this agreement at such address as the Lessor requires, or if necessary allow the Lessor or its representatives access to the Site or any premises where the Equipment is located for the purpose of removing the Equipment; and
(p) not do or permit to be done anything which could invalidate the insurances referred to in clause 6.
7.2 The Lessee acknowledges that the Lessor shall not be responsible for any loss of or damage to the Equipment arising out of or in connection with any negligence, misuse, mishandling of the Equipment or otherwise caused by the Lessee or its officers, employees, agents and contractors[, and the Lessee undertakes to indemnify the Lessor on demand against the same, and against all losses, liabilities, claims, damages, costs or expenses of whatever nature otherwise arising out of or in connection with any failure by the Lessee to comply with the terms of this agreement].
8. [Purchase Option
8.1 The Lessee shall, subject to clause 8.2, have the option, exercisable by not less than [twenty (20)] Business Days' written notice to the Lessor, to purchase the Equipment on the last Business Day of the Rental Period at the Purchase Option Price. 
8.2 The Purchase Option may be exercised only if all amounts due to the Lessor under this agreement up to the date of exercise of the Purchase Option have been paid in full by the Lessee.
8.3 Upon completion of the purchase of the Equipment under this clause 8, such title to the Equipment as the Lessor had on the Commencement Date shall transfer to the Lessee. The Equipment shall transfer to the Lessee in the condition and at the location in which it is found on the date of transfer.]
9. Warranty
9.1 The Lessor warrants that the Equipment shall substantially conform to its specification (as made available by the Lessor), be of satisfactory quality and fit for any purpose held out by the Lessor. The Lessor shall [use all reasonable endeavours to] remedy, free of charge, any material defect in the Equipment which manifests itself within [twelve (12)] months from Delivery, provided that:
(a) the Lessee notifies the Lessor of any defect in writing within [ten (10)] Business Days of the defect occurring [or of becoming aware of the defect];
(b) the Lessor is permitted to make a full examination of the alleged defect;
(c) the defect did not materialise as a result of misuse, neglect, alteration, mishandling or unauthorised manipulation by any person other than the Lessor's authorised personnel;
(d) the defect did not arise out of any information, design or any other assistance supplied or furnished by the Lessee or on its behalf; and
(e) the defect is directly attributable to defective material, workmanship or design.
9.2 Insofar as the Equipment comprises or contains equipment or components which were not manufactured or produced by the Lessor, the Lessee shall be entitled only to such warranty or other benefit as the Lessor has received from the manufacturer.
9.3 If the Lessor fails to remedy any material defect in the Equipment in accordance with clause 9.1, the Lessor shall, at the Lessee's request, accept the return of part or all of the Equipment and make an appropriate reduction to the Rental Payments payable during the remaining term of the agreement and, if relevant, return any Deposit (or any part of it).
10. Liability
10.1 Without prejudice to clause 10.2, the Lessor's maximum aggregate liability for breach of this agreement (including any liability for the acts or omissions of its employees, agents and subcontractors), whether arising in contract, tort (including negligence), misrepresentation or otherwise, shall in no circumstances exceed £[AMOUNT].
10.2 Nothing in this agreement shall exclude or in any way limit:
(a) either party's liability for death or personal injury caused by its own negligence;
(b) either party's liability for fraud or fraudulent misrepresentation; or
(c) [liability for any breach of the terms implied by section 8 of the Supply of Goods (Implied Terms) Act 1973 or] any other liability which cannot be excluded by law.
10.3 This agreement sets forth the full extent of the Lessor's obligations and liabilities in respect of the Equipment and its hiring [and sale] to the Lessee. In particular, there are no conditions, warranties or other terms, express or implied, including as to quality, fitness for a particular purpose or any other kind whatsoever, that are binding on the Lessor except as specifically stated in this agreement. Any condition, warranty or other term concerning the Equipment which might otherwise be implied into or incorporated within this agreement, whether by statute, common law or otherwise, is expressly excluded.
10.4 Without prejudice to clause 10.2, neither party shall be liable under this agreement for any:
(a) [loss of profit];
(b) [loss of revenue]
(c) [loss of business]; or
(d) [indirect or consequential loss or damage],
in each case, however caused, even if foreseeable.
11. Termination
11.1 Without affecting any other right or remedy available to it, the Lessor may terminate this agreement with immediate effect by giving [written] notice to the Lessee if:
(a) the Lessee fails to pay any amount due under this agreement on the due date for payment [and remains in default not less than [NUMBER] days after being notified [in writing] to make such payment];
(b) the Lessee commits a material breach of any other term of this agreement which breach is irremediable or (if such breach is remediable) fails to remedy that breach within a period of [NUMBER] days after being notified [in writing] to do so;
(c) [the Lessee repeatedly breaches any of the terms of this agreement in such a manner as to reasonably justify the opinion that its conduct is inconsistent with it having the intention or ability to give effect to the terms of this agreement;]
(d) the Lessee suspends, or threatens to suspend, payment of its debts or is unable to pay its debts as they fall due or admits inability to pay its debts or [(being a company or limited liability partnership) is deemed unable to pay its debts within the meaning of section 123 of the Insolvency Act 1986 OR (being an individual) is deemed either unable to pay its debts or as having no reasonable prospect of so doing, in either case, within the meaning of section 268 of the Insolvency Act 1986 OR (being a partnership) has any partner to whom any of the foregoing apply];
(e) the Lessee commences negotiations with all or any class of its creditors with a view to rescheduling any of its debts, or makes a proposal for or enters into any compromise or arrangement with its creditors [other than (being a company) for the sole purpose of a scheme for a solvent amalgamation of the Lessee with one or more other companies or the solvent reconstruction of the Lessee];
(f) a petition is filed, a notice is given, a resolution is passed, or an order is made, for or in connection with the winding up of the Lessee (being a company) [other than for the sole purpose of a scheme for a solvent amalgamation of the Lessee with one or more other companies or the solvent reconstruction of the Lessee];
(g) an application is made to court, or an order is made, for the appointment of an administrator, or if a notice of intention to appoint an administrator is given or if an administrator is appointed, over the Lessee (being a company);
(h) the holder of a qualifying floating charge over the assets of the Lessee (being a company) has become entitled to appoint or has appointed an administrative receiver;
(i) a person becomes entitled to appoint a receiver over the assets of the Lessee or a receiver is appointed over the assets of the Lessee;
(j) [the Lessee (being an individual) is the subject of a bankruptcy petition or order;]
(k) a creditor or encumbrancer of the Lessee attaches or takes possession of, or a distress, execution, sequestration or other such process is levied or enforced on or sued against, the whole or any part of the Lessee's assets and such attachment or process is not discharged within [14] days;
(l) any event occurs, or proceeding is taken, with respect to the Lessee in any jurisdiction to which it is subject that has an effect equivalent or similar to any of the events mentioned in clause 11.1(d) to clause 11.1(k) (inclusive);
(m) the Lessee suspends or ceases, or threatens to suspend or cease, carrying on all or a substantial part of its business; [or]
(n) [the Lessee (being an individual) dies or, by reason of illness or incapacity (whether mental or physical), is incapable of managing his or her own affairs or becomes a patient under any mental health legislation[; or]]
11.2 [For the purposes of clause 11.1(b), material breach means a breach (including an anticipatory breach) that is serious in the widest sense of having a serious effect on the benefit which the Lessor would otherwise derive from:
(a) a substantial portion of this agreement; or
(b) any of the obligations set out in clause clause 7,
over the term of this agreement. In deciding whether any breach is material no regard shall be had to whether it occurs by some accident, mishap, mistake or misunderstanding.]
11.3 This agreement shall automatically terminate if a Total Loss occurs in relation to the Equipment.
12. Consequences of termination
12.1 Upon termination of this agreement, however caused:
(a) the Lessor's consent to the Lessee's possession of the Equipment shall terminate and the Lessor may, by its authorised representatives, without notice and at the Lessee's expense, retake possession of the Equipment and for this purpose may enter the Site or any premises at which the Equipment is located; and
(b) without prejudice to any other rights or remedies of the Lessee, the Lessee shall pay to the Lessor on demand:
(i) all Rental Payments and other sums due but unpaid at the date of such demand together with any interest accrued pursuant to clause 4.4;
(ii) any costs and expenses incurred by the Lessor in recovering the Equipment and/or in collecting any sums due under this agreement (including any storage, insurance, repair, transport, legal and remarketing costs).
12.2 Upon termination of this agreement pursuant to clause 11.1, any other repudiation of this agreement by the Lessee which is accepted by the Lessor or pursuant to clause 11.3, without prejudice to any other rights or remedies of the Lessor, the Lessee shall pay to the Lessor on demand a sum equal to the whole of the Rental Payments that would (but for the termination) have been payable if the agreement had continued from the date of such demand to the end of the Rental Period, less: 
(a) a discount for accelerated payment at the percentage rate set out in the Payment Schedule; and
(b) [the Lessor's reasonable assessment of the market value of the Equipment on sale].
12.3 The sums payable pursuant to clause 12.2 shall be agreed compensation for the Lessor's loss and shall be payable in addition to the sums payable pursuant to clause 12.1(b). Such sums may be partly or wholly recovered from any Deposit.
12.4 Termination or expiry of this agreement shall not affect any rights, remedies, obligations or liabilities of the parties that have accrued up to the date of termination or expiry, including the right to claim damages in respect of any breach of the agreement which existed at or before the date of termination or expiry.
13. Force majeure
Neither party shall be in breach of this agreement nor liable for delay in performing, or failure to perform, any of its obligations under this agreement if such delay or failure result from events, circumstances or causes beyond its reasonable control. In such circumstances [the time for performance shall be extended by a period equivalent to the period during which performance of the obligation has been delayed or failed to be performed OR the affected party shall be entitled to a reasonable extension of the time for performing such obligations]. If the period of delay or non-performance continues for [NUMBER] [weeks OR months], the party not affected may terminate this agreement by giving [NUMBER] [days'] written notice to the affected party.
14. Confidential information
14.1 Each party undertakes that it shall not [at any time OR at any time during this agreement, and for a period of [five] years after termination of this agreement,] disclose to any person any confidential information concerning the business, affairs, customers, clients or suppliers of the other party [or of any member of the group of companies to which the other party belongs], except as permitted by clause 14.2.
14.2 Each party may disclose the other party's confidential information:
(a) to its employees, officers, representatives or advisers who need to know such information for the purposes of carrying out the party's obligations under this agreement. Each party shall ensure that its employees, officers, representatives or advisers to whom it discloses the other party's confidential information comply with this clause 14; and
(b) as may be required by law, a court of competent jurisdiction or any governmental or regulatory authority.
14.3 No party shall use any other party's confidential information for any purpose other than to perform its obligations under this agreement.
15. Assignment and other dealings
This agreement is personal to the parties and neither party shall assign, transfer, mortgage, charge, subcontract, declare a trust over or deal in any other manner with any of its rights and obligations under this agreement.
16. Entire agreement
16.1 This agreement constitutes the entire agreement between the parties and supersedes and extinguishes all previous agreements, promises, assurances, warranties, representations and understandings between them, whether written or oral, relating to its subject matter.
16.2 Each party acknowledges that in entering into this agreement it does not rely on[, and shall have no remedies in respect of,] any statement, representation, assurance or warranty (whether made innocently or negligently) that is not set out in this agreement.
16.3 Each party agrees that it shall have no claim for innocent or negligent misrepresentation [or negligent misstatement] based on any statement in this agreement.
16.4 [Nothing in this clause shall limit or exclude any liability for fraud.]
17. Variation
No variation of this agreement shall be effective unless it is in writing and signed by the parties (or their authorised representatives).
18. No partnership or agency
18.1 Nothing in this agreement is intended to, or shall be deemed to, establish any partnership or joint venture between any of the parties, constitute any party the agent of another party, or authorise any party to make or enter into any commitments for or on behalf of any other party.
18.2 Each party confirms it is acting on its own behalf and not for the benefit of any other person.
19. Further assurance
[At its own expense, each OR Each] party shall, and shall use all reasonable endeavours to procure that any necessary third party shall, [promptly] execute and deliver such documents and perform such acts as may [reasonably] be required for the purpose of giving full effect to this agreement.
20. Counterparts
20.1 This agreement may be executed in any number of counterparts, each of which when executed [and delivered] shall constitute a duplicate original, but all the counterparts shall together constitute the one agreement.
20.2 [Transmission of [an executed counterpart of this agreement (but for the avoidance of doubt not just a signature page) OR the executed signature page of a counterpart of this agreement] by (a) fax or (b) e-mail (in PDF, JPEG or other agreed format) shall take effect as delivery of an executed counterpart of this agreement. If either method of delivery is adopted, without prejudice to the validity of the agreement thus made, each party shall provide the others with the original of such counterpart as soon as reasonably possible thereafter.]
20.3 [No counterpart shall be effective until each party has executed [and delivered] at least one counterpart.]
21. Third party rights
No one other than a party to this agreement[, their successors and permitted assignees,] shall have any right to enforce any of its terms.
22. Notices
22.1 Any notice [or other communication] given to a party under or in connection with this contract shall be in writing and shall be:
(a) delivered by hand or by pre-paid first-class post or other next working day delivery service at its registered office (if a company) or its principal place of business (in any other case); or 
(b) sent by fax to its main fax number.
22.2 Any notice [or communication] shall be deemed to have been received:
(a) if delivered by hand, on signature of a delivery receipt [or at the time the notice is left at the proper address];
(b) if sent by pre-paid first-class post or other next working day delivery service, at [9.00 am] on the [second] Business Day after posting [or at the time recorded by the delivery service].
(c) if sent by fax, at [9.00 am] on the next Business Day after transmission.
22.3 This clause does not apply to the service of any proceedings or other documents in any legal action or, where applicable, any arbitration or other method of dispute resolution. [For the purposes of this clause, "writing" shall not include e-mail.]
23. Waiver
No failure or delay by a party to exercise any right or remedy provided under this agreement or by law shall constitute a waiver of that or any other right or remedy, nor shall it prevent or restrict the further exercise of that or any other right or remedy. No single or partial exercise of such right or remedy shall prevent or restrict the further exercise of that or any other right or remedy.
24. Rights and remedies
Except as expressly provided in this agreement, the rights and remedies provided under this agreement are in addition to, and not exclusive of, any rights or remedies provided by law.
25. Severance
25.1 If any provision or part-provision of this agreement is or becomes invalid, illegal or unenforceable, it shall be deemed modified to the minimum extent necessary to make it valid, legal and enforceable. If such modification is not possible, the relevant provision or part-provision shall be deemed deleted. Any modification to or deletion of a provision or part-provision under this clause shall not affect the validity and enforceability of the rest of this agreement.
25.2 If [one party gives notice to the other of the possibility that] any provision or part-provision of this agreement is invalid, illegal or unenforceable, the parties shall negotiate in good faith to amend such provision so that, as amended, it is legal, valid and enforceable, and, to the greatest extent possible, achieves the intended commercial result of the original provision.

This agreement has been entered into on the date stated at the beginning of it.




17. Additional provisions
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
