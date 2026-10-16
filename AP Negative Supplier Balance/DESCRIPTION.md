# Case Study & Technical Analysis: AP Negative Supplier Balance

## 1. Executive Summary

### Business Problem
In Accounts Payable, a "Negative Balance" indicates that the company has overpaid a supplier or has outstanding Credit Memos that exceed the value of unpaid invoices. These debit balances represent:
*   **Cash Leakage:** Capital tied up with vendors that could be used elsewhere.
*   **Financial Risk:** If a supplier goes bankrupt or the relationship ends, these funds may be unrecoverable.
*   **Reporting Compliance:** For statutory reporting (GAAP/IFRS), significant debit balances in AP must often be reclassified as Current Assets (Receivables) rather than netting against total Liabilities.

### Solution Overview
The **AP Negative Supplier Balance** report is a critical financial control tool. It scans the supplier subledger to identify third parties with a net debit position as of a specific date. This allows the AP Manager to instruct the team to either request a refund check or ensure the credit is applied to future invoices immediately.

### Key Benefits
*   **Cash Recovery:** Directly identifies opportunities to request refunds from vendors.
*   **Audit Compliance:** Provides the necessary documentation for reclassifying AP debit balances during quarter-end or year-end close.
*   **Vendor Management:** Highlights suppliers with frequent credit memos or billing errors.

## 2. Technical Analysis

### Core Tables and Views
Unlike simple operational reports, this report is typically built on the **Subledger Accounting (SLA)** architecture to ensure it matches the General Ledger:
*   **`XLA_TRIAL_BALANCES`**: The primary source for "As Of" balance reporting in R12. It stores the remaining balance of every liability transaction.
*   **`AP_INVOICES_ALL`**: Provides the operational details (Invoice Number, Date) for the transactions making up the balance.
*   **`PO_VENDORS` / `HZ_PARTIES`**: Supplier master data.

### SQL Logic and Data Flow
The report leverages the Oracle "Open Account Balances" definition (`XLA_TB_AP_REPORT_PVT`).
*   **Balance Calculation:** It sums the `ACCOUNTED_DR` and `ACCOUNTED_CR` from the SLA distribution links or trial balance snapshot to derive the net remaining liability.
*   **Filtering:** The `HAVING SUM(balance) < 0` clause is the core filter, isolating only those suppliers/sites where the credits outweigh the debits.
*   **As-Of Logic:** The query must reconstruct the balance back to the requested "As Of Date" by excluding transactions or applications that occurred after that date.

### Integration Points
*   **General Ledger:** The report output should reconcile with the AP Liability account balance in GL (specifically the debit portion).
*   **SLA:** Relies on the "Open Account Balances Data Manager" program to be current.

## 3. Functional Capabilities

### Parameters & Filtering
*   **As of Date:** The "cut-off" date for the analysis. Essential for historical reconciliation.
*   **Supplier Name:** Run for a specific partner or leave blank for all.
*   **Show Transaction Detail:**
    *   *Yes:* Lists the specific Credit Memos and Overpayments causing the negative balance.
    *   *No:* Shows one line per Supplier/Site with the total amount.

### Performance & Optimization
*   **SLA Dependency:** This report is most efficient when the standard Oracle "Open Account Balances Data Manager" process has been run recently, as it relies on pre-calculated balances rather than summing millions of raw transactions on the fly.

## 4. FAQ

**Q: Why doesn't this match my "Invoice Aging" report?**
A: The Aging report is often based on *Invoice Date* or *Due Date*, whereas this report is based on *Accounting Date* and SLA balances. Unaccounted transactions will not appear here.

**Q: How do I clear a negative balance?**
A: You have two options:
1.  **Refund:** Ask the supplier for a check, record it as a "Refund" in AP, which debits Cash and credits the Liability (clearing the negative).
2.  **Offset:** Enter a new Standard Invoice for new goods and "Apply" the Credit Memo to it.

**Q: Does this include unvalidated invoices?**
A: Generally, no. It includes only "Accounted" transactions that have hit the Trial Balance.
