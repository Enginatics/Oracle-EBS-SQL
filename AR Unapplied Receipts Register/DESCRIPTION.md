# AR Unapplied Receipts Register - Case Study & Technical Analysis

## Executive Summary

The **AR Unapplied Receipts Register** is a primary operational report for the Cash Application team. It identifies all customer payments that have been recorded in the system but not yet fully applied to specific invoices. Reducing the volume and value of unapplied receipts is a critical Key Performance Indicator (KPI) for the Accounts Receivable department, as it directly impacts the accuracy of customer aging and the efficiency of the collections process.

## Business Challenge

"Unapplied Cash" represents a disconnect in the Order-to-Cash cycle.
*   **Distorted Aging:** A customer may have $1M in open invoices and $1M in unapplied cash. Their net balance is zero, but the aging report shows them as $1M past due, triggering unnecessary dunning actions.
*   **Customer Satisfaction:** Calling a customer to demand payment when they have already paid (but the cash is sitting unapplied) damages the relationship.
*   **Accounting Risk:** Unapplied cash sits in a suspense or liability account. If not cleared promptly, it can hide revenue recognition issues or duplicate payments.

## Solution

The **AR Unapplied Receipts Register** serves as a worklist for resolving these items:
*   **Identification:** Lists every receipt with a non-zero "Unapplied" balance.
*   **Aging:** Shows how long the cash has been sitting unapplied (via Receipt Date), allowing managers to target old items first.
*   **Ownership:** Includes the "Collector" assigned to the customer, enabling the distribution of the workload.

## Technical Architecture

The report focuses on the "Open" portion of the payment schedules associated with receipts.

### Key Tables & Joins

*   **Open Balance:** `AR_PAYMENT_SCHEDULES_ALL` is the driver. The query looks for records where `CLASS = 'PMT'` and `STATUS = 'OP'` (Open). The `AMOUNT_DUE_REMAINING` on a payment schedule represents the unapplied amount.
*   **Receipt Header:** `AR_CASH_RECEIPTS_ALL` provides the Receipt Number, Date, and Currency.
*   **Customer:** `HZ_PARTIES` and `HZ_CUST_ACCOUNTS` identify the payer.
*   **Bank:** `CE_BANK_ACCOUNTS` identifies where the money was deposited.

### Logic

1.  **Selection:** Finds receipts where the unapplied amount is not zero.
2.  **As-Of Logic:** If an "As of Date" is provided, the report must reconstruct the balance. It takes the current balance and "rolls back" any applications that happened *after* the As-Of Date to show what the balance was at that point in time.
3.  **Exclusion:** Typically excludes "Reversed" receipts, as they are no longer valid assets.

## Parameters

*   **As of GL Date:** The most critical parameter for month-end reconciliation. It ensures the report matches the General Ledger balance for the "Unapplied Cash" account.
*   **Customer Name:** Filters for a specific client.
*   **Receipt Number:** Locates a specific payment.
*   **Collector:** Segments the report by the responsible agent.

## FAQ

**Q: What is the difference between "Unapplied" and "On Account"?**
*   **Unapplied:** The cash is in the system, but no decision has been made on how to use it.
*   **On Account:** The cash has been deliberately placed "On Account" (e.g., a prepayment or deposit) to be used later.
*   *Note:* Both result in a negative balance on the customer account, and this report typically includes both unless filtered.

**Q: Why does the report show a receipt that I applied yesterday?**
A: If you run the report with an "As of Date" from *last week*, it will show the receipt as unapplied because it *was* unapplied at that time.

**Q: How do I clear items from this report?**
A: You must "Apply" the receipt to an invoice, a debit memo, or refund it to the customer. Once the `AMOUNT_DUE_REMAINING` on the receipt becomes zero, it drops off the list.
