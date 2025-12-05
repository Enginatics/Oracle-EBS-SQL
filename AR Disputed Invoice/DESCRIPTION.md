# AR Disputed Invoice - Case Study & Technical Analysis

## Executive Summary

The **AR Disputed Invoice** report is a vital instrument for the Accounts Receivable and Collections departments. It provides a focused view of all customer invoices that are currently in a "Dispute" status. By isolating these transactions, organizations can prioritize conflict resolution, address customer grievances (such as pricing errors or quality issues), and ultimately accelerate cash collection to reduce Days Sales Outstanding (DSO).

## Business Challenge

In the Order-to-Cash cycle, disputes are a primary bottleneck. When a customer disputes an invoice, they typically withhold payment until the issue is resolved. Common challenges include:

*   **Visibility:** Collections agents may unknowingly chase a customer for payment on an invoice that is already known to be problematic.
*   **Resolution Time:** Without a centralized list, disputes can languish in the system, aging and becoming harder to collect.
*   **Cash Flow Impact:** A significant volume of disputed amounts artificially inflates the Accounts Receivable balance while representing cash that cannot yet be collected.

## Solution

The **AR Disputed Invoice** report addresses these challenges by:

*   **Centralized Tracking:** Listing all disputed items in one place, allowing managers to assess the total value of disputed cash.
*   **Collector Assignment:** Enabling filtering by "Collector," so individual agents can receive a targeted list of disputes they are responsible for resolving.
*   **Detail Availability:** Providing key details such as the original invoice amount, the specific amount in dispute (which may be partial), and the transaction date.

## Technical Architecture

This report is based on the standard Oracle XML Publisher report `ARXDIR_XML`.

### Key Tables & Joins

*   **Transaction Balance:** `AR_PAYMENT_SCHEDULES_ALL` is the core table. The report filters for records where `AMOUNT_IN_DISPUTE` is not null and not zero.
*   **Transaction Header:** `RA_CUSTOMER_TRX_ALL` provides the invoice number, date, and type.
*   **Customer Data:** `HZ_PARTIES` and `HZ_CUST_ACCOUNTS` provide customer names and numbers.
*   **Collectors:** `HZ_CUSTOMER_PROFILES` links the customer to their assigned Collector.
*   **Notes:** `AR_NOTES` (optional) may be joined to retrieve specific comments or reasons entered by the agent regarding the dispute.

### Logic

The query logic focuses on the payment schedule (the open balance record).
1.  **Identification:** It identifies rows in `AR_PAYMENT_SCHEDULES_ALL` where the dispute class or amount indicates an active dispute.
2.  **Currency:** It handles multi-currency reporting, showing amounts in the entered currency.
3.  **Status:** It respects the "Invoice Status" parameter to show Open, Closed, or All transactions, though "Open" is the most common use case for collections.

## Parameters

*   **Operating Unit:** Filters by the specific business entity.
*   **Collector:** Allows generating the report for a specific collections agent.
*   **Customer Name/Number:** Filters for a specific client.
*   **Invoice Status:** Typically set to 'Open' to see currently unpaid disputed invoices.
*   **Order By:** Sorts the output, often by Customer or Invoice Date.

## FAQ

**Q: What constitutes a "Dispute" in Oracle AR?**
A: A dispute is flagged when a user enters a value in the "Dispute Amount" field on the Transaction or Collections window. This removes that amount from the "Amount Due Remaining" for dunning purposes but keeps it on the ledger.

**Q: Does this report show the reason for the dispute?**
A: Standard versions often show the dispute amount. If the report is customized or includes `AR_NOTES`, it can also show the reason code or comments entered by the collector.

**Q: If I credit the invoice, does it disappear from this report?**
A: If the credit memo fully offsets the dispute and the balance is cleared or the dispute amount is updated to zero, it will no longer appear as an open dispute.
