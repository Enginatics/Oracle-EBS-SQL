# AR Unaccounted Transaction Sweep - Case Study & Technical Analysis

## Executive Summary

The **AR Unaccounted Transaction Sweep** is a specialized period-close utility in Oracle Receivables. Its primary purpose is to unblock the period closing process. Oracle enforces a strict rule: an accounting period cannot be closed if it contains transactions that have not been successfully accounted (transferred to the General Ledger). This report identifies such transactions and offers the option to "sweep" them—i.e., move their accounting date—to the next open period.

## Business Challenge

The financial close is a time-sensitive process.
*   **The Blocker:** A single unaccounted invoice (e.g., due to a missing exchange rate or invalid account code) can prevent the entire AR period from closing.
*   **The Deadline:** If the accounting team cannot resolve the error before the corporate deadline, they risk delaying the entire company's financial reporting.
*   **The Fix:** Fixing the root cause (e.g., defining a new tax rule) might take days, which is time the team doesn't have.

## Solution

The **AR Unaccounted Transaction Sweep** provides a tactical solution:
*   **Identification:** First, run in "Review" mode (Sweep Now = No) to list all stuck transactions and the associated error messages (from Subledger Accounting).
*   **Resolution (Sweep):** If the errors cannot be fixed immediately, run in "Execute" mode (Sweep Now = Yes). This updates the GL Date of the problematic transactions to the first day of the *next* period.
*   **Result:** The current period is now clean and can be closed. The transactions remain in the system but will be processed in the following month.

## Technical Architecture

The tool interacts with the Subledger Accounting (SLA) engine and the core AR transaction tables.

### Key Tables & Logic

*   **Exception Table:** `AR_PERIOD_CLOSE_EXCPS_GT` is a global temporary table populated by the sweep program. It aggregates exceptions from various sources.
*   **Sources Checked:**
    *   **Invoices:** Checks `RA_CUST_TRX_LINE_GL_DIST_ALL` for unposted distributions.
    *   **Receipts:** Checks `AR_DISTRIBUTIONS_ALL` (Cash/Misc Receipts).
    *   **Adjustments:** Checks `AR_ADJUSTMENTS_ALL`.
*   **Error Details:** Links to `XLA_ACCOUNTING_ERRORS` to retrieve the specific reason why the accounting failed (e.g., "Code Combination ID not found").

### The Sweep Action

When "Sweep Now" is enabled, the program executes an `UPDATE` statement:
$$ \text{GL\_DATE} = \text{Start Date of 'Sweep To Period'} $$
This applies to the distribution lines of the affected transactions.

## Parameters

*   **Period Name:** The period you are trying to close (e.g., 'Oct-23').
*   **Sweep Now:**
    *   *No:* Report mode only. Lists the exceptions.
    *   *Yes:* Action mode. Moves the transactions.
*   **Sweep To Period Name:** The target period (e.g., 'Nov-23'). Must be Open or Future-Entry.

## FAQ

**Q: Is sweeping recommended?**
A: It is a fallback mechanism. The best practice is to resolve the accounting error in the correct period to ensure expenses/revenue are matched to the right month. Sweeping moves the P&L impact to the next month.

**Q: Can I sweep a transaction that has been partially accounted?**
A: Generally, no. If part of a transaction (e.g., the Revenue line) is already posted, you cannot change the GL date of the whole transaction. The sweep program typically handles completely unaccounted events.

**Q: What happens if I don't sweep?**
A: You simply cannot close the AR period until the transactions are either fixed (and accounted) or deleted.
