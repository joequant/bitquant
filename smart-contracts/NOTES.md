// Copyright (c) 2014, Bitquant Research Laboratories (Asia) Ltd.
// Licensed under the Simplified BSD License
// NO WARRANTIES AND REPRESENTATIONS

JURISDICTION
Why Hong Kong?

Hong Kong contract law is basically English contract law with a few
small differences, so the reason that this is done under HK law is so
that it can be used as a template for a contract in any other common
law jurisidiction (i.e. Australia, Canada, UK, and US).  This
advantage of common law over continental civil law systems is that in
continental civil law systems (Germany, France, Mainland China,
Taiwan), the power of the contract comes from a legislative enactment.
This means that the format and the details of the contract have to be
written specifically according to the national law.

As far as why Hong Kong and not English law.  HK is a small
jurisdiction, and so the courts are very fast and efficient.  The US,
UK, or Australia is so large that it can take years for a case to
reach the supreme courts, and the supreme courts are so busy with
other things that ruling on these issues is not a high priority.


Because Hong Kong is smaller, cases move through the courts much more
quickly.  Instead taking over a decade for a case to move all the way
to the top, in HK, even huge cases can reach the CfA in a matter of
months.  Any contract disputes can be quickly resolved, and it is
hoped that as Hong Kong courts rule on smart contracts, there will be
a set of case law which originates in Hong Kong which other
jurisdictions can use.  One of the goals of this project is for Hong
Kong to be to smart contracts what Delaware is to corporate law.

CHOICE OF LANGUAGE

We ended up using javascript for the language.  Originally, we were
going to use python because that is the standard language in banks.
However, the lenders stated that they prefered javascript, which makes
sense because javascript is very well known in web development, and
allowed us to create a web app.

One problem with javascript is that all numbers are floats, and you
don't have operator overloading.  In Python, you can create a money
class which makes multicurrency easy.  Also in javascript, all dates
have time zone associated with them which is something a bad thing.

For libraries what wanted to remove any libraries from the term sheet
itself.  Also we used requirejs to make it work with both nodejs and
with a web browser.  I considered having a javascript compiled
language like coffeescript, but the extra overhead in the compiler was
problematic.

WORDS TO AVOID THE WORD 

Default - has completely different meanings in law and in computer
programming.  This meant that I needed to avoid using that word.
Default parameters can mean "the parameters used when someone doesn't
fill in the form" or "the parameters used when someone doesn't perform
the terms of the contract."

Penalty or bonus - Contract drafter want to avoid the word bonus and
really, really want to avoid the word penalty.  The trouble is that if
you describe something as a bonus or penalty, you may run into legal
limits as to what you can put as a bonus or penalty.  In particular,
English contract law prohibits penalty clauses.  There are clauses
that you can provide a penalty without a penalty clause.  Liquidated
damages.  In this contract, the extra money is terms an accelerated
payment. 

STANDARD TERMS IN ENGLISH CONTRACT LAW

Much of the agreement are designed to change certain standard
provisions of English contract law.  English contract law has evolved
over the last several hundred years, and there are some areas in which
English contract law causes things that are unexpected unless the
parties agree otherwise.  This include:

The meaning of the term "including" - The word include is ambigious.
If you say "X include Y and Z", that can be interpreted as meaning
*only* Y and Z or things like Y and Z, and this is the way that
"including" is usually interpreted by lawyers.  However, including can
also mean "X, for example Y and Z."  Defining "including" or
"includes" is important because that fixes the definition.  Note that
the definition in this contract says "X including Y and Z" means X,
however, if I say "including Y and Z" then anything that is not in Y
and Z is listed.

Postbox rule - The rule in English contract law is that if you give
notice of something, the notice is valid when you put the letter in
the post office.  What does that mean of e-mail?  There isn't a clear
rule, so rather than have the court guess, you want to put the rule
into the contract.

Severability - If one part of the contract becomes impossible to
execute, do you want the whole contract to be invalid, or to you want
to try to work around the issue?  You can do both ways, but English
courts tend to assume that if you can't perform part of a contract,
that the whole thing becomes invalid.  This changes that assumption.

Is e-mail writing? - If a contract requires "written notice" does that
include e-mail, and fax.  You don't want to have a court guess, and
English contract law provides no rule.  In this contract we have
defined e-mail and fax was constituting "writing."  Note here that
chat and SMS is *NOT* included as "writing".


ANNOYANCES

Markdown uses two spaces to separate paragraphs.

COMMENTS

One of the legal issues was to carefully divide what is commentary and
what is legally enforceable.  In particular, the TermSheet.js file
does not contain any comments, because this would create confusion
over whether the code is the contract or the comments are in the
contract.

To deal with this issue, all of the comments are in a side notes.  The
side note contains representations from from the borrower to the
lender regarding the content of the code.  However this agreement is
separate from the contract itself.

What we expect to happen is that if there is a substantive conflict
between the terms of the contract and the notes, that this would be
handled under the law of mistake or misrepresentation.  However, this
would only cover the original borrower and lender.  If the loan is
resold, any representations would not cover that situation.

It's also important that the contract analyzer is not part of the
contract itself.

IP OF CONTRACT

One conflict was between software conventions for IP rights and lawyer
conventions.  In software, the IP rights are always very clear.
Either there is an open source license or the license is proprietary.
Also software developers are very careful about IP issues and there is
invariably an agreement as to who owns IP rights to the work.

With lawyers the question of who owns the IP to the contract text is
usually not explicitly stated, and the practice seems to be that
lawyers allow a text to circulate, but never renounce ownership of
copyright, and reserve the right to assert IP at a later time.
Lawyers will also rarely explicitly define IP rights for contract
text, as the contract is often not reusable anyway, and you end up
with "meta"-problems (i.e. who do you consult to negotiate a contract
with a lawyer).

This practice will not work for software products, as it create a
situation in which IP is unclear.  This creates an problem with "clean
title."

Unfortunately, the statuory law is unclear about what happens in this
situation.  The issue is that different jurisdictions have different
legal systems.  In Hong Kong, this is covered under section ?? of the
Copyright Ordinance and is clearly a commissioned work in which the
lawyer retains copyright ownership, whereas the person that
commissioned the work retains an *exclusive* license to use the work.
There are two issues here.  The first is that this is an HK only
situation, this would clearly not be a commissioned work under US or
UK law and the Berne Convention is silent on this issue.

It's also unclear how moral rights play into this.  Under HK law,
software is not subject to moral rights.  However, is this software?

The solution in this case was that the lender paid the legal firm that
drafted the contract a large sum of money in exchange for an
assignment of copyright, which allows for a template contract to be
published under a BSD license.  It's worth noting that the executed
contract will not be BSD licensed, because you explicitly *don't* want
to disclaim liability.

PRIVACY ISSUES

One problem is what is public and what is private.  The fact that a
company is getting a loan is sensitive information that you won't want
to spread around.  So what we did was to pus t the public template
contract on github.  The exact amounts and the identities of the
borrower and lender are not included.

BUGS

It's worth noting that writing the contract in javascript allowed for
removing some ambiguity in the contract.  For example, in calculating
the accelerated payment, you run into the question of what happens if
you hit two targets on the same day.  Also, when writing up the
contract, you have the question of what happens if someone pays off
the contract, can they keep the credit limit?  If someone has a late
interest rate, does this apply to only the late balance or the whole
balance?

WHY BUCKAROO BANZAI?

His rock band is the Hong Kong Caviliers.

Also BB is very interesting from an IP point of view.  Because the
rights to the character are a mess, it will be impossible for anyone
to finance or use the intellectual property.  This is an illustration
with the problem of "clouded title."

