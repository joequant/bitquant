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
    def set_events(self, events):
        self.revenue_event_date1 = events['revenue_event_date1']
        self.revenue_event_date2 = events['revenue_event_date2']
        self.early_payments = events['early_payments']
        self.credit_draws = events['credit_draws']
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
                         amount=self.initial_loan_amount)
        """The lender agrees to provide up the the line of credit amount
        for the duration of the loan."""
        for i in self.credit_draws:
            loan.fund(on=i['on'],
                      amount=i['amount'])

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
                      interval=relativedelta(months=1))


        """ Bonus #1 - The borrower agrees to pay back
        50% of the outstanding balance in addition to 50% of the
        interest that would have accrued to the final payment date
        within one month after the gross revenue of the product
        exceeds HKD 1.0 million or the final payment date whichever
        is earlier"""
        if self.revenue_event_date1 != None:
            payment_date = self.revenue_event_date1 + \
                           relativedelta(months=1)
            if payment_date > self.final_payment_date:
                payment_date = self.final_payment_date
            loan.add_to_balance(on=self.revenue_event_date1,
                  amount = loan.multiply(loan.interest(self.revenue_event_date1,
                                self.final_payment_date,
                                loan.remaining_balance()), 0.5))
            loan.payment(on=payment_date,
                  amount = loan.multiply(loan.remaining_balance(),
                                         0.5))
            
        """ Bonus #2 - The borrower agrees to pay back
        50% of the outstanding balance in addition to 50% of the
        interest that would have accrued to the final payment date
        within one month after the gross revenue of the product
        exceeds HKD 1.5 million or the final payment date whichever
        is earlier"""
        if self.revenue_event_date2 != None:
            payment_date = self.revenue_event_date2 + \
                           relativedelta(months=1)
            if payment_date > self.final_payment_date:
                payment_date = self.final_payment_date
            loan.add_to_balance(on=self.revenue_event_date2,
                  amount = loan.interest(self.revenue_event_date2,
                                self.final_payment_date,
                                loan.remaining_balance()))
            loan.payment(on=payment_date,
                  amount = loan.remaining_balance())

        """The borrower agrees to pay back the any remaining principal
        and accrued interest one year after the loan is issued."""
        loan.payment(on=self.final_payment_date,
                            amount= loan.remaining_balance())

        """The borrower make early payments at any time."""
        for i in self.early_payments:
            loan.payment(on=i['on'],
                         amount=i['amount'])
        
