# Case Study & Technical Analysis: AR Refund Upload

## Executive Summary
This upload refunds customer credit balances in Oracle Receivables. Each row refunds either an open credit memo or the unapplied, on-account portion of a customer cash receipt, by applying it against the operating unit's Credit Memo Refund Receivables Activity. Collections and cash-application teams use it to clear customer credits in bulk, with a review step before any money leaves. It runs in Excel through Blitz Report™ in Create, Update mode.

## Business Challenge
*   **Idle customer credits:** Overpayments held as credit memos or unapplied receipts sit on accounts until someone arranges a refund.
*   **Candidate selection:** Refunding a credit while the customer still has open invoices can distort collections, so the rule that excludes such accounts has to be applied consistently.
*   **Two refund sources:** Credit memos and unapplied receipts follow different candidate rules and must be handled on one worksheet.
*   **Payment control:** A refund is a disbursement, so selection is separated from the Payables steps that follow.

## The Solution
*   Pre-populates the download with every eligible credit memo and every unapplied receipt for the chosen parameters, showing customer name and open balance.
*   Processes only the rows where Refund is set to Yes, and defaults the refund amount to the source open balance, which can be overridden with a smaller positive amount for a partial refund.
*   Applies each refund through the Oracle Receivables public APIs.
*   Hands over to Accounts Payable, where a Payment Request invoice is created for the customer's party, followed by standard Invoice Validation and the Payment Process Request.

## Technical Architecture (High Level)
### Primary Tables
*   `AR_PAYMENT_SCHEDULES_ALL`: the open CM installments with their amount due remaining, and the open INV installments used by the safety filter.
*   `RA_CUSTOMER_TRX_ALL`: the credit memo transaction number.
*   `AR_CASH_RECEIPTS_ALL`: the unapplied and on-account customer receipts, identified by receipt number and status UNAPP.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: the applications whose UNAPP or ACC amounts give the open balance of a receipt.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer account and the customer name.
*   `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the operating unit and the organizations the user can access.

### Logical Relationships
1.  The credit memo branch joins open CM installments to transactions, operating unit, customer and party.
2.  A NOT EXISTS test removes a credit memo when the same customer has an open invoice, unless Include accounts with open invoices is Yes.
3.  When that override is set, the open invoice due-date test excludes only customers with an open invoice due within the number of days entered.
4.  The receipt branch joins unapplied receipts (status UNAPP) to their customer, and keeps those with a positive amount in an UNAPP or ACC application.
5.  The two branches are combined with UNION ALL, and each row carries a refund source of Credit Memo or Unapplied Receipt.
6.  Each row is numbered with ROWNUM as its upload row.

## Parameters & Filtering
*   **Upload Mode:** Create, Update is the default, so the eligible candidates pre-populate the template.
*   **Operating Unit:** filters both the credit memo and the receipt branch.
*   **Customer Name:** limits the candidates to customers with an eligible refund in the operating unit.
*   **GL Date From** and **GL Date To**, **Credit Memo Number** and **Batch Name:** filter the credit memo branch only, because the receipt branch always lists all unapplied receipts in the chosen operating unit.
*   **Include accounts with open invoices:** turns off the safety filter for credit memos; it does not apply to receipts.
*   **Open Invoice Due Within Days:** applies only when Include accounts with open invoices is Yes, and hides a credit memo only when an open invoice is due within that many days.

## Performance & Optimization
*   The open invoice test is a NOT EXISTS subquery on `AR_PAYMENT_SCHEDULES_ALL`.
*   The receipt open balance is a scalar subquery, evaluated only for receipts that passed the EXISTS filter.
*   Both branches are restricted through `MO_GLOB_ORG_ACCESS_TMP` before the customer and party joins.
*   Candidates come from the database, so the spreadsheet carries only rows the refund rules allow.

## FAQ
**Q: When should a refund come from a credit memo rather than an unapplied receipt?**
A: Use a credit memo refund when the customer holds an open credit memo from an overpayment, and an unapplied receipt refund when the customer paid more than owed or paid against the account with no specific invoice.

**Q: Why might a credit memo not appear in the download?**
A: By default a credit memo is hidden when its customer has any open invoice, so the customer must have no open invoices unless Include accounts with open invoices is set to Yes.

**Q: What happens after the refund row is uploaded with Refund set to Yes?**
A: The upload creates the refund application in Receivables and a Payment Request invoice in Accounts Payable, which still needs Invoice Validation and the Payment Process Request before any payment is issued.
