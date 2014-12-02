#!/usr/bin/python
from datetime import date
from money import Money
from dateutil.relativedelta import relativedelta
from decimal import Decimal
import findates

class LoanContract(object):
    def __init__(self):
        """The constants in this section are terms which have been
        agreed to between the borrower and the lender."""
        self.annual_interest_rate = 10.0 / 100.0
        self.initial_loan_date = date(2014, 12, 1)
        self.currency = 'HKD'
        self.initial_loan_amount = Money('50000.00', 'HKD')
        self.line_of_credit = Money('50000.00', 'HKD')
        self.final_payment_date = self.initial_loan_date + \
                                       relativedelta(years=1)
        self.bonus_targets = [Money('750000.00', 'HKD'),
                              Money('1500000.00', 'HKD')]
        self.bonus_multiplers = [0.5, 1.0]
    def set_events(self, events):
        self.revenues = events['revenues']
        self.early_payments = events['early_payments']
        self.credit_draws = events['credit_draws']
        if "skip_payments" in events:
            self.skip_payments = events['skip_payments']
        else:
            self.skip_payments = []
    def interest(self, from_date, to_date):
        """The interest will be 10 percent per annum compounded monthly
        using the 30/360 US day count convention ."""
        yearfrac = findates.daycount.yearfrac(from_date,
                                              to_date,
                                              "30/360 US")
        months = yearfrac * 12
        return Decimal((1.0 + \
               self.annual_interest_rate / 12.0) ** months - 1.0) 
        
    def payments(self, loan):
        """Any principal amounts in this loan will be paid in Hong
        Kong dollars.  Any accured interest shall be paid in the form
        of Bitcoin with the interest rate calculated in Hong Kong
        dollars"""
        self.currency_interest = "XBT"
        
        """The lender agrees to provide the borrower the initial loan
        amount on the initial date"""
        loan.fund(on=self.initial_loan_date,
                  amount=self.initial_loan_amount,
                  note="Initial funding")
        """The lender agrees to provide up the the line of credit amount
        for the duration of the loan."""
        for i in self.credit_draws:
            loan.fund(on=i['on'],
                      amount=i['amount'],
                      note="Credit draw")

        """The borrower agrees to pay back the any remaining principal
        and accrued interest one year after the loan is issued."""
        loan.payment(on=self.final_payment_date,
                            amount= loan.remaining_balance(),
                     note="Required final payment")

        """The borrower make early payments at any time."""
        for i in self.early_payments:
            loan.payment(on=i['on'],
                         amount=i['amount'],
                         note="Early payment")

        """ Standard payment schedule - The borrower intends to
        payback period will be separated into 8 installments and
        completed in 8 months.  The payback will begin in the 5th
        month.  However, unless the special conditions are triggered,
        the borrower is required to only pay the interest on the loan
        until the final payment date."""
        start_payment_date = self.initial_loan_date + \
                             relativedelta(months=4)
        loan.amortize(on=start_payment_date,
                      amount = loan.remaining_balance(),
                      payments=8,
                      interval=relativedelta(months=1),
                      note="Optional payment",
                      skip=self.skip_payments)

        if self.revenues == None or \
           self.bonus_targets == None:
               return
        """ Bonus - If the total revenues from the product exceeds the
        bonus target, the borrower will be required to pay a
        specified fraction of the outstanding balance in addition to a
        specified fraction of the interest had the balance been
        carried to the end of the contract.  This payment will be done
        within one month after the date the bonus target is reached"""
        for i, bonus_date in enumerate(self.get_bonus_dates()):
            if bonus_date == None:
                break
            bonus_multiplier = self.bonus_multiplers[i]
            payment_date = bonus_date + \
                           relativedelta(months=1)
            if payment_date > self.final_payment_date:
                payment_date = self.final_payment_date
            loan.add_to_balance(on=payment_date,
                  amount = loan.multiply(loan.interest(bonus_date,
                                self.final_payment_date,
                                loan.remaining_balance()), bonus_multiplier),
                                note=("Required bonus payment %d" % (i+1)))
            loan.payment(on=payment_date,
                  amount = loan.multiply(loan.remaining_balance(),
                                         bonus_multiplier),
                         note=("Required bonus payment %d" % (i+1)))
    def get_bonus_dates(self):
        """This routine returns the dates at which the bonus
        targets are hit."""
        bonus_dates = [None ] * len(self.bonus_targets)
        total_revenue = None
        revenue_idx = 0
        for i in self.revenues:
            if revenue_idx >= len(self.bonus_targets):
                break
            date = i['on']
            if total_revenue == None:
                total_revenue = i['amount']
            else:
                total_revenue = total_revenue + i['amount']
            if total_revenue >= self.bonus_targets[revenue_idx]:
                bonus_dates[revenue_idx] = i['on']
                revenue_idx = revenue_idx + 1
        return bonus_dates
