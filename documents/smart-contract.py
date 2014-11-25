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
        self.total_loan_amount = Money('100000.00', 'HKD')
        self.final_payment_date = self.initial_loan_date + \
                                       relativedelta(years=1)
    def set_events(self, events):
        self.kickstarter_success = events['kickstarter_success']
        self.kickstarter_start_date = events['kickstarter_start_date'] 
        self.kickstarter_payment_date = events['kickstarter_payment_date']
        self.kickstarter_revenue = events['kickstarter_revenue']
        self.early_payments = events['early_payments']
        
    def interest(self, from_date, to_date, principal):
        """The interest will be 10 percent per annum compounded monthly
        using the 30/360 US day count convention ."""
        yearfrac = findates.daycount.yearfrac(from_date,
                                              to_date,
                                              "30/360 US")
        months = yearfrac * 12
        return principal * Decimal((1.0 + \
               self.annual_interest_rate / 12.0) ** months - 1.0) 
        
    def payments(self, loan_engine):
        """The lender agrees to provide the borrower half of the loan amount
        on the initial loan on the initial date"""
        loan_engine.fund(on=self.initial_loan_date,
                         amount=self.total_loan_amount * \
                         Decimal(0.5))
        """The lender agrees to pledge the remaining loan amount toward
        the kickstarter campaign of the borrower."""
        loan_engine.fund(on=self.kickstarter_payment_date,
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
            loan_engine.payment(on=payment_date,
                  amount = self.remaining_principal(payment_date))
            loan_engine.payment(on=payment_date,
                  amount = self.remaining_interest(payment_date))
        elif (self.kickstarter_revenue > Money(58000, "USD")):
            payment_date = self.kickstarter_payment_date + \
                           relativedelta(months=2)
            loan_engine.payment(on=payment_date,
            amount = self.remaining_principal(payment_date),
            payment_type="HKD")
        else:
            start_payment_date = self.kickstarter_payment_date + \
                           relativedelta(months=4)
            for i in range(0,7):
                loan_engine.payment(on=start_payment_date + \
                     relativedelta(months=i),
                     amount=self.total_loan_amount / Decimal(8))
        """The borrower agrees to pay back the any remaining principal
        and accrued interest one year after the loan is issued.  The
        principal amount will be paid in Hong Kong dollars.  Any accured
        interest shall be paid in the form of Bitcoin with the interest rate
        calculated in Hong Kong dollars"""
        loan_engine.payment(on=self.final_payment_date,
                amount= loan_engine.remaining_principal(self.final_payment_date))
        loan_engine.payment(
            on=self.final_payment_date,
                amount= loan_engine.accrued_interest(self.final_payment_date))
        

class LoanCalculator(object):
    def __init__(self):
        self.principal = None
        self.interest = None
    def calculate(self, contract):
        self.currency = contract.currency
        self.principal = Money(0.0, self.currency)
        self.interest = Money(0.0, self.currency)
        self.prev_event_date = None
        self.contract = contract
        contract.payments(self)
    def show_payments(self, contract):
        self.calculate(contract)
    def fund(self, on, amount,
             payment_type=None):
        if callable(amount):
            payment = amount()
        else:
            payment = amount
        if self.prev_event_date != None:
            self.interest = self.interest + \
                 self.contract.interest(self.prev_event_date,
                                   on,
                                   (self.principal + self.interest))
        self.prev_event_date = on
        self.principal = self.principal + payment
        print "Funding"
        print on, payment, self.principal, self.interest
    def payment(self, on,
                amount,
                payment_type=["principal"],
                settlement_ccy=None,
                optional=False):
        if callable(amount):
            payment = amount()
        else:
            payment = amount
        print on, payment, self.principal, self.interest
        if self.prev_event_date != None:
            self.interest = self.interest + \
                 self.contract.interest(self.prev_event_date,
                                   on,
                                   (self.principal + self.interest))
        self.prev_event_date = on
        if "principal" in payment_type:
            self.principal = self.principal - payment
        if "interest" in payment_type:
            self.interest = self.interest - interest
        print "Repayment"

    def remaining_principal(self, d2):
        return lambda : self.principal
    def accrued_interest(self, d1):
        return lambda : self.interest

if __name__ == "__main__":
    my_contract = LoanContract()
    my_contract.set_events({"kickstarter_success":True,
                            "kickstarter_start_date": date(2015,1,1),
                            "kickstarter_payment_date":date(2015,1,15),
                            "kickstarter_revenue":50000,
                            "early_payments":[]})
    calculator = LoanCalculator()
    calculator.show_payments(my_contract)
    
