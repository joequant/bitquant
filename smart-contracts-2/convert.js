var contract = {
    "data" : {
	"reference_date": "2017-Jan-01",
	"maturity_date": "2018-Jul-01",
	"reference_value": ["USD", 1000],
	"company": "Kuaiwear Limited, a company incorporated under the laws of Hong Kong",
	"initial_purchaser": "Joseph Chen-Yu Wang",
	"note_class": "convertible notes issued for the purpose of raising approximately USD 500k after 1 July 2016 until 1 July 2017 or a later date specified by the company if the target fund raise has not been achieved",
	"interest_rate_percent": 10,
	"interest_period": "year",
	"interest_compounding": "simple",
	"date_count_convention": "365/Actual",
	"exercise_notice_period": [10, "business_days"],
	"qualified_financing_amount": ["USD", 500000],
	"conversion_discount_percent": 80,
	"conversion_cap": ["USD", 4000000],
	"nonelection_conversion_factor": 1.5,
	"transfer_objection_period": [5, "business_days"],
	"change_of_control_notice_period": [10, "business_days"],
	"change_of_control_election_period": [5, "business_days"]
    },
    "template" :
`For value received, {{company}}, the "Company", hereby
promises to pay to the order of {{initial_purchaser}} (hereinafter
together with permitted transferees, successors in title and assigns
referred to as the "Holder") {{reference_value}}, the "Reference
Value", and accrued interest from time to time. The Company intends on
using the proceeds for general corporate purposes.

This Convertible Note (this "Note") is one in a series of Convertible
Notes (collectively, the "Notes") issued by the Company.  As used in
this note, "Majority Note Holders" shall mean the holders of a
majority of the aggregate outstanding amounts of {{note_class}}
(the"Note Class")

1. **Interest**.  This Note shall bear interest at
{{interest_rate_percent}} percent per {{interest_period}} with
{{interest_compounding}} compounding and a date count convention of
{{date_count_convention}} .  Interest shall be calculated as accruing
from {{reference_date}} (the "Reference Date") until the date on which
this Note is converted as provided herein or paid in connection with
repayment in full of the amount due of this Note, and shall not be
payable until it is so converted or repaid.

2. **Amount Due**.  Unless earlier converted into shares of Preferred
Shares or Ordinary Shares pursuant to the terms of this Note and
subject to the default provisions set forth herein, the face value of
this Note together with accrued interest (the sum of such principal
and accrued interest being hereinafter referred to as the "Amount
Due") shall be payable at any time following {{maturity_date}} (the
"Maturity Date") at the discretion of the Company or alternatively
upon the demand of the Holder or an authorized agent of the Holder
having given the company a notice of {{exercise_notice_period}}.  The
Amount Due may not be prepaid before the Maturity Date in whole or in
part without the prior written consent of the Majority Note Holders.

3. **Conversion of the Notes**.  The Note shall be convertible according
to the following terms:  

    > (a) Subject to Section 9, the following terms shall have the
      meanings assigned below:

    >> (i) "Change of Control" shall mean and include any of the following

    >>> (a) consummation of merger or consolidation of the Company (or
        the Parent) with or into any other corporation or other entity
        in which the holders of the Company’s (or the Parent’s, as
        applicable) voting securities immediately prior to such merger
        or consolidation will not, directly or indirectly, continue to
        hold at least a majority of the outstanding voting securities
        of the Company (or the Parent, as applicable);

    >>> (b) a sale, lease, exchange or other transfer (in one
        transaction or a related series of transactions) of all or
        substantially all of the Company’s (or the Parent’s) assets
        to an unrelated person or entity;

    >>> (c) the acquisition by any person or any group of persons,
        acting together in any transaction or related series of
        transactions, of such quantity of the Company’s (or
        Parent’s) voting securities as causes such person, or group
        of persons, to own beneficially, directly or indirectly, as of
        the time immediately after such transaction or related series
        of transactions, fifty percent (50%) or more of the combined
        voting power of the voting securities of the Company (or the
        Parent, as applicable) other than as a result of

    >>>>(I) an acquisition of securities directly from the Company (or
        the Parent, as applicable) or

    >>>> (II) an acquisition of securities by the Company (or the
         Parent) which, by reducing the voting securities outstanding,
         increases the proportionate voting power represented by the
         voting securities owned by any such person or group of persons
         to fifty percent (50%) or more of the combined voting power of
         such voting securities; provided that the transfer of
         ownership of the Company to the Parent for the purposes of
         internal restructuring shall not constitute a Change of
         Control;

    >> (ii) "Change of Control Effective Date" means the date on
       which a Change of Control occurs;

    >> (iii) "Change of Control Notice" means a notice from the
       Company to the Holder stating: (a) that a Change of Control
       is anticipated to occur, and (b) the anticipated Change of
       Control Effective Date with respect to such Change of Control;

    >> (iv) "Hong Kong" means the Hong Kong Special Administrative
       Region of the People’s Republic of China;

    >> (v) "Ordinary Shares" means the ordinary shares of the
       Company or Parent;

    >> (vi) "Preferred Shares" means the preferred shares of the
       Company or Parent (or any similar equity security to be issued
       in connection with the Qualified Financing) to be authorized
       immediately prior to the closing of the Qualified Financing;
       and

    >> (vii) "Qualified Financing" means the first bona fide sale
       (or series of related sales) by the Company or Parent of its
       Preferred Shares (or a similar equity security) following the
       Reference Date of this Note in which the Company or Parent
       receives gross proceeds of at least
       {{qualified_financing_amount}} (excluding the principal amount
       of and accrued interest on the Notes).

    >> (viii) "Parent" means a company directly or indirectly owning
controlling interest of the equity interest in the Company.

    >> (ix) "Business day" means a day excluding weekends and public holidays
and weather emergencies in which stock exchanges within Hong Kong are
closed for regular trading the entire day

    > (b) Subject to Section 9, the Amount Due shall automatically be
      converted by the Company, without need of any further action by
      the Holder, into Preferred Shares issued in the Qualified
      Financing.  The number of Preferred Shares to be issued upon
      such conversion shall be as specified in Schedule
      A. Notwithstanding the foregoing, the Company shall provide
      written notice to the Holder a reasonable period of time prior
      to the Qualified Financing.

    > (c) Upon the conversion of this Note into Preferred Shares or
      Ordinary Shares, as the case may be, in lieu of any fractional
      shares to which the Holder would otherwise be entitled, the
      Company shall pay the Holder an amount in cash equal to such
      fraction multiplied by the issue price of such Preferred Shares
      or Ordinary Shares, as the case may be.

    > (d) As promptly as practicable after the conversion of this Note, the
  Company at its expense will issue and deliver, or procure the Parent
  to issue and deliver, to the Holder, upon surrender of the Note, a
  certificate or certificates for the number of Preferred Shares or
  Ordinary Shares, as the case may be, issuable upon such conversion.

4. **Default**  This Note shall become immediately due and payable upon
the occurrence of any of the following events of default
(individually, an "Event of Default" and collectively, "Events of
Default"):

    >> (a) the liquidation, dissolution or insolvency of the Company
       (or Parent), or the appointment of a receiver or custodian for
       the Company (or Parent) of all or substantially all of its
       property;

    >> (b) the institution by or against the Company (or Parent) of
       any proceedings under any applicable bankruptcy,
       reorganization, receivership, insolvency or other similar law
       affecting the rights of creditors generally; or

    >> (c) the failure of the Company to make any payment of principal
       or interest when due on this Note or any Note in the Note
       Class, upon notice and demand by the Majority Note Holders

5. **No Set-Off**.  All payments by the Company under this Note shall be
made without set-off or counterclaim and be without any deduction or
withholding for any taxes or fees of any nature, unless the obligation
to make such deduction or withholding is imposed by law.

6. **Conversion or Repayment Option upon Change of Control**. 
Subject to Section 9: 

    > (a) Notwithstanding any other term contained in this Note, prior
      to any anticipated Change of Control that occurs before the
      Maturity Date, the Company hereby grants the Holder the
      option, exercisable at the sole discretion of the Holder, to
      convert the Notes held by it into Ordinary Shares in the manner
      set forth below.

    > (b) The Company shall deliver to the Holder a Change of
      Control Notice no less than {{change_of_control_notice_period}}
      prior to any anticipated Change of Control. The Holder may
      make an election (a "Change of Control Election") with respect
      to the Notes in writing by notice to the Company no later than
      {{change_of_control_election_period}} after delivery of the
      Change of Control Notice.  Following delivery of such Change of
      Control Election, the Company shall provide the Holder with
      such information regarding the terms of the Change of Control as
      it may reasonably request, subject to any restrictions on the
      Company (or Parent, as applicable) pursuant to any applicable
      confidentiality agreement.  Any such election to convert the
      Note in connection with a Change of Control shall be irrevocable
      once delivered to the Company and upon such election, the
      Holder shall not be entitled to the prepayment option under
      this Section 6.

    > (c) If the Holder timely delivers a Change of Control
      Election, the Note shall automatically convert into Ordinary
      Shares at a conversion price per share (or similar equity
      securities) that is equal to the Conversion Cap.

    > (d) Upon conversion, the Holder shall be entitled to
      participate in any sale of equity securities of the Company (or
      Parent, as applicable) pursuant to a Change of Control, in
      proportion to its shareholding in the Company (or Parent, as
      applicable), (on a fully diluted basis).

    > (e) If the Holder fails to timely deliver a Change of Control
      Election or declines to convert its Note into Ordinary Shares,
      the Company shall (i) prepay all of this Note for an amount
      equal to the {{nonelection_conversion_factor}} times the
      Reference Value.

7. **Collection Expenses**  If this Note is not paid in accordance with
its terms, the Company shall pay to the Holder, in addition to
principal and accrued interest thereon, all costs of collection of
this Note, including but not limited to reasonable attorneys’ fees,
court costs and other costs for the enforcement of payment of this
Note.

8. **Waivers**  The Company hereby expressly and irrevocably waives
presentment, demand, protest, notice of protest and all other notices
in connection with this Note (excluding those notices set forth in
Section 4(a) above).  No delay or extension on the part of the
Holder in exercising any right hereunder shall operate as a waiver
of such right or of any other right under this Note, and a waiver of
any right on any one occasion shall not operate as a waiver of such
right on any future occasion.

9. **Conversion into Company or Parent Shares**

    > (a) For the purposes of automatic conversion pursuant to
      Sections 3(b) and 3(c), references to Ordinary Shares and
      Preferred Shares shall be to Ordinary Shares and Preferred
      Shares of the Parent only;

    > (b) For the purposes of conversion pursuant to a Change of
      Control Election under Section 6, references to Ordinary Shares
      and Preferred Shares shall be to:

    >> (i) Ordinary Shares and Preferred Shares of the Parent if the
       Change of Control relates to the Parent; and

    >> (ii) Ordinary Shares and Preferred Shares of the Company if the
       Change of Control relates to the Company.

10. **Transfers; Successors and Assigns.**  This Note, and the obligations
and rights of the parties hereunder, shall be binding upon and inure
to the benefit of the Company, the Parent, the holder of this Note,
and their respective heirs, successors and assigns; provided, however,
that the Company may not transfer or assign its obligations hereunder,
by operation of law or otherwise, without the consent of the Majority
Note Holders.

    > The Holder may not transfer or assign its rights hereunder 
      except to a wholly-owned and controlled affiliate, by operation 
      of law or otherwise, unless:

    >> a) it has obtained the written consent of the company.  This 
       consent may be general and may be also given in advance to a 
       general set of transactions, or
    >> b) having given the Company written notice of the proposed 
       transfer or assignment, it has not received from the Company 
       a written notice of objection within the {{transfer_objection_period}}.

11. **Changes**.  Changes in or additions to this Note may be made or
compliance with any term, covenant, agreement, condition or provision
set forth herein may be omitted or waived (either generally or in a
particular instance and either retroactively or prospectively), upon
written consent of the Company and the Majority Note Holders;
provided, however, that no such change, addition, omission or waiver
shall adversely and disproportionately affect any Holder in a
manner different than any other holder of the other Notes without the
prior written consent of such Holder.

12. **Notices**.  All notices and other communications given or made
pursuant hereto shall be in writing and shall be deemed effectively
given: 

    > (i) upon personal delivery to the party to be notified, 

    > (ii) when sent by confirmed facsimile if sent during normal 
      business hours of the recipient, if not so confirmed, then on 
      the next business day,

    > (iii) five (5) business days after having been sent by 
      registered or certified mail, return receipt requested, 
      postage prepaid or 
   
    > (iv) one (1) business day after deposit with a nationally
      recognized overnight courier, specifying next day delivery, with
      written verification of receipt or

    > (v) or by electronic mail when receipt of the mail has been
      confirmed.  All communications shall be sent to the respective
      parties at the following addresses (or at such other addresses
      as shall be specified by notice given in accordance with this
      Section 9(d)

    The Holder of the note shall provide the Company with updated
    contact information, and the Company shall not be responsible for
    any consequences arising from the failure of the Holder to receive
    notice from the Company, provided that the Company shall have made
    reasonable efforts to contact the Holder using the contact
    information which has been provided to the Company.

13. **Severability**.  If one or more provisions of this Note are held to
be unenforceable under applicable law, such provision shall be
excluded from this Note and the balance of the Note shall be
interpreted as if such provision were so excluded and shall be
enforceable in accordance with its terms.

14. **Governing Law**.  This Note and the obligations of the Company
hereunder shall be governed by, and construed in accordance with, the
laws of Hong Kong, without regard to the principles of conflicts of
law of any jurisdiction.

15. **Arbitration**.

    >> (i) Any party to a dispute, controversy or claim (each, a
       "Dispute") arising out of or relating to this Note and the
       obligations of the Company hereunder, or the interpretation,
       breach, or validity hereof, is entitled to submit the Dispute
       to arbitration process with notice to the other party to the
       Dispute.

    >> (ii) Arbitration shall be conducted in Hong Kong under the
       auspices of the Hong Kong International Arbitration Centre
       ("HKIAC") by one arbitrator. The arbitration proceedings
       shall be conducted in English. The arbitration tribunal shall
       apply the HKIAC Administered Arbitration Rules in effect at the
       time of the arbitration.

    >> (iii) The decision of the arbitration tribunal shall be final
       and binding upon the parties, and the prevailing party may
       apply to a court of competent jurisdiction for enforcement of
       such award. The parties undertake to carry out any award
       without delay and shall be deemed to have waived their right to
       any form of recourse insofar as such waiver can validly be
       made.

    >> (iv) During the course of the arbitration tribunal’s
       adjudication of the Dispute, this Note shall continue to be
       valid except with respect to the part in Dispute and under
       adjudication.

    >> (v) In an arbitration arising out of or related to this Note
       and the obligations of the Company hereunder, the arbitration
       tribunal shall award to the prevailing party, the cost of
       arbitration (including legal, accounting and other professional
       fees and expenses reasonably incurred by any prevailing party
       with respect to the investigation, collection, prosecution
       and/or defense of any claim in the Dispute). If the arbitration
       tribunal determines a party to be the prevailing party under
       circumstances where the prevailing party won on some but not
       all of the claims and counterclaims, the panel may award the
       prevailing party an appropriate percentage of the costs of
       arbitration (including legal, accounting and other professional
       fees and expenses reasonably incurred, by any prevailing party
       with respect to the investigation, collection, prosecution
       and/or defense of any claim in the Dispute).

16. **Entire Agreement**.  Without prejudice to any party’s liability for
any fraudulent misrepresentation, this Note constitutes the full and
entire understanding and agreement between the parties with regard to
the subject matter hereof.

17. **Third Party Rights**.  A person who is not a party has no right
under the Contracts (Rights of Third Parties) Ordinance (Cap. 623 of
the laws of Hong Kong) to enforce or to enjoy the benefit of any term
of this Note.`,
   "schedules" : [
           {
	       "name" : "schedule_a",
	       "display" : "Schedule A",
               "description" : `Schedule A describes the preferred shares to be issued upon automatic conversion.`,
	       "inputs" : [
		   {
		       "name" : "amount_due",
		       "display" : "Amount Due",
		       "description" : "Amount Due on date of conversion",
		       "type" : "number"
		   },
		   {
		       "name": "price_per_share",
		       "display": "Price per share",
		       "description" : "Price per share of the preferred shares sold to investors",
		       "type" : "number"
		   },
		   {
		       "name" : "shares_outstanding",
		       "description" : "the total number of Ordinary Shares of the Company outstanding on a fully diluted basis, assuming exercise in full of outstanding options and warrants and conversion of any outstanding convertible securities of the Company",
		       "type": "number",
		   }
	       ],
	       "outputs" : [
		   {
		       "name": "shares_issued",
		       "description": "Number of preferred shares to be issued upon conversion",
		       "type" : "number"
		   },
		   {
		       "name" : "cash_issued",
		       "description" : "Cash issued",
		       "type" : "money"
		   }
	       ],
	       "parameters" : [
		   {
		       "name" : "conversion_cap",
		       "description" : "Conversion cap",
		       "type" : "number"
		   },
		   {
	               "name" : "conversion_discount_percent",
                       "description": "Conversion discount",
                       "type" : "percent"
		   }
               ],
               "function" : function(input, params) {
		   var conversion_price =
		       params['conversion_discount_percent'] / 100.0 *
		       input['price_per_share'];
		   var conversion_price_cap =
		       params['conversion_cap'] /
		       params['shares_outstanding'];
		   if (conversion_price > conversion_price_cap) {
		       conversion_price = conversion_price_cap;
		   }
		   var shares_issued = input['amount_due'] /
		       conversion_price;
		   shares_issued = int(shares_issued);
		   var cash_issued = input['amount_due'] -
		       shares_issued * conversion_price;
		   return {
		       "shares_issued": shares_issued,
		       "cash_issued": cash_issued,
		       "conversion_price_cap": conversion_price_cap,
		       "conversion_price": conversion_price
		   };
	       }
	   }
   ]
};
