# AR Past Due Invoice - Case Study & Technical Analysis

## Executive Summary

The **AR Past Due Invoice** report is a targeted collections tool designed to identify and list specific customer invoices that have exceeded their payment terms. Unlike summary aging reports that group debts into time buckets, this report provides a granular, line-item view of delinquent transactions, calculating the exact number of days each invoice is overdue. It is essential for prioritizing collection efforts and improving cash flow.

## Business Challenge

Effective cash collection requires knowing exactly which debts are overdue and by how much.
*   **Prioritization:** Collections agents have limited time. They need to know whether to focus on a large invoice that is 5 days late or a smaller one that is 90 days late.
*   **Precision:** When calling a customer, the agent needs specific invoice numbers and dates to dispute excuses and demand payment.
*   **DSO Management:** Reducing Days Sales Outstanding (DSO) requires immediate visibility into invoices as soon as they cross the "due" threshold.

## Solution

The **AR Past Due Invoice** report empowers the collections team by:
*   **Exact Aging:** Calculating the precise "Days Late" for every open item.
*   **Segmentation:** Allowing filters by "Days Late" (e.g., 1-30 days vs. 60+ days) to drive different dunning strategies (e.g., email reminder vs. phone call).
*   **Assignment:** Filtering by "Collector" to generate personalized worklists for each team member.

## Technical Architecture

The report focuses on the payment schedule of open transactions.

### Key Tables & Joins

*   **Schedule:** `AR_PAYMENT_SCHEDULES_ALL` is the core table. It holds the `DUE_DATE`, `AMOUNT_DUE_REMAINING`, and `STATUS`.
*   **Transaction Header:** `RA_CUSTOMER_TRX_ALL` provides the invoice number and original transaction details.
*   **Customer:** `HZ_PARTIES` and `HZ_CUST_ACCOUNTS` identify the debtor.
*   **Collector:** `AR_COLLECTORS` (linked via `HZ_CUSTOMER_PROFILES`) allows the report to be segmented by the assigned agent.
*   **Salesperson:** `RA_SALESREPS` is included to allow sales teams to assist in collecting from their accounts.

### Logic

1.  **Filter:** Selects transactions where `STATUS = 'OP'` (Open) and `AMOUNT_DUE_REMAINING > 0`.
2.  **Time Check:** Filters where `DUE_DATE < :As_Of_Date`.
3.  **Calculation:**
    $$ \text{Days Late} = \text{As Of Date} - \text{Due Date} $$
4.  **Sorting:** Typically ordered by Customer and then by Days Late (descending) to highlight the worst offenders.

## Parameters

*   **As of Date:** The reference date for calculating lateness (defaults to today).
*   **Days Late Low / High:** Defines the range of delinquency (e.g., Low=31, High=60 for a specific dunning campaign).
*   **Balance Due Low / High:** Filters out small, immaterial balances to focus on high-value debts.
*   **Collector:** Generates the report for a specific agent.
*   **Customer Name:** Targets a specific account for detailed review.

## FAQ

**Q: Does this report show invoices that are due today?**
A: Typically, "Past Due" implies `Due Date < As of Date`. If an invoice is due today, it is usually not considered past due until tomorrow.

**Q: Are disputed invoices included?**
A: Yes, unless specifically excluded by customization. A disputed invoice is still legally past due until the dispute is resolved or a credit is issued.

**Q: What happens if I run this for a past date?**
A: The report will show what *was* past due on that date, based on the open balance at that time (if the query logic supports historical "As of" reconstruction, though standard versions often look at current open items relative to a past date).
