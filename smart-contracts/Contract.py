#!/usr/bin/python
from datetime import date
from money import Money
from dateutil.relativedelta import relativedelta
from decimal import Decimal
import findates
import collections

class LoanContract(object):
    def __init__(self):
        """The constants in this section are terms which have been
        agreed to between the borrower and the lender."""
        self.annual_interest_rate = 10.0 / 100.0
        self.initial_loan_date = date(2014, 12, 1)
        self.currency = 'HKD'
        self.total_loan_amount = Money('100000.00', 'HKD')
        self.final_payment_date = self.initial_loan_date + \
                                       relativedelta(years=1)
    def set_events(self, events):
        self.kickstarter_success = events['kickstarter_success']
        self.kickstarter_start_date = events['kickstarter_start_date'] 
        self.kickstarter_payment_date = events['kickstarter_payment_date']
        self.kickstarter_revenue = events['kickstarter_revenue']
        self.early_payments = events['early_payments']
        
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
#        loan.process_payment(loan.settle_interest_with("XBT"))
        
        """The lender agrees to provide the borrower half of the loan amount
        on the initial loan on the initial date"""
        loan.fund(on=self.initial_loan_date,
                         amount=self.total_loan_amount * \
                         Decimal(0.5))
        """The lender agrees to pledge the remaining loan amount toward
        the kickstarter campaign of the borrower."""
        loan.fund(on=self.kickstarter_payment_date,
                         amount=self.total_loan_amount * \
                         Decimal(0.5))
        """ Standard payment schedule - The borrower intends to
        payback period will be separated into 8 installments and
        completed in 8 months.  The payback will begin in the 5th
        month.  However, unless the special conditions are triggered,
        the borrower is required to only pay the interest on the loan
        until the final payment date."""

        """ Special payment schedule - If First campaign funded over
        USD 65,000, the borrower must pay back entire loan including
        one year interest within the two months after Crowd Funding
        Platform pay the fund."""

        """ If First campaign funded over USD 58,000, will pay back 4
        Installment in advance, after Crowd Funding Platform pay the
        fund.  The rest of the loan will keep paying followed the
        standard schedule until all loan including interest is paid
        back."""

        if (self.kickstarter_revenue > Money(65000, "USD")):
            payment_date = self.kickstarter_payment_date + \
                           relativedelta(months=2)
            loan.add_to_balance(on=payment_date,
                  amount = loan.interest(payment_date,
                                                self.final_payment_date,
                                                loan.remaining_balance()))
            loan.payment(on=payment_date,
                  amount = loan.remaining_balance())
        else:
            if (self.kickstarter_revenue > Money(58000, "USD")):
                payment_date = self.kickstarter_payment_date + \
                               relativedelta(months=2)
                loan.payment(on=payment_date,
                        amount = lambda : loan.remaining_principal()() * Decimal(0.5))
            start_payment_date = self.initial_loan_date + \
                           relativedelta(months=4)
            loan.amortize(on=start_payment_date,
                    amount = loan.remaining_balance(),
                                 payments=8,
                                 interval=relativedelta(months=1))
        """The borrower agrees to pay back the any remaining principal
        and accrued interest one year after the loan is issued."""
        loan.payment(on=self.final_payment_date,
                            amount= loan.remaining_balance())
