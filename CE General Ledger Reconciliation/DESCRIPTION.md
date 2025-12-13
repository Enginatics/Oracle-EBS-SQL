# Executive Summary
The **CE General Ledger Reconciliation** report is the primary month-end report for reconciling the General Ledger cash balance to the Bank Statement balance. It highlights the differences caused by unposted journals, unreconciled transactions, and transactions in the subledger that haven't been transferred to GL. This report is the "bridge" that proves the financial statements accurately reflect the cash position.

# Business Challenge
Reconciling the GL to the Bank is a multi-step process involving three balances:
1.  **Bank Balance**: What the bank says we have.
2.  **Subledger Balance**: What AP/AR says we have.
3.  **GL Balance**: What the Trial Balance says we have.

Discrepancies can arise from manual journals, unposted batches, or timing differences. Identifying the root cause of a variance is often the most stressful part of the month-end close.

# Solution
This report compares the GL Account Balance (for the designated cash account) against the Bank Statement Balance and itemizes the reconciling items.

**Key Features:**
*   **Three-Way Match**: Conceptually links Bank, Subledger, and GL.
*   **Variance Identification**: Explicitly lists "Transactions in GL but not in Bank" and "Transactions in Bank but not in GL".
*   **Period-End Focus**: Designed to be run for a specific accounting period to support the close process.

# Architecture
The report aggregates `GL_BALANCES` for the cash account and compares it to the `CE_STATEMENT_HEADERS` closing balance, adjusting for unreconciled items in `CE_STATEMENT_LINES` and `CE_AVAILABLE_TRANSACTIONS`.

**Key Tables:**
*   `GL_BALANCES`: The official GL balance.
*   `CE_STATEMENT_HEADERS`: The official bank balance.
*   `CE_RECONCILIATION_ERRORS`: Any system errors preventing reconciliation.
*   `XLA_AE_LINES`: Subledger accounting entries (to check for posting status).

# Impact
*   **Financial Integrity**: Validates the accuracy of the Cash line item on the Balance Sheet.
*   **Audit Compliance**: Serves as the primary evidence of cash control for external auditors.
*   **Process Improvement**: Highlights recurring reconciling items (e.g., manual journals) that should be automated.
