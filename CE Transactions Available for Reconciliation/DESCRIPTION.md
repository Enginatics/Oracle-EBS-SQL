# Executive Summary
The **CE Transactions Available for Reconciliation** report lists all system transactions (payments, receipts, journal entries) that are eligible to be reconciled against a bank statement but have not yet been matched. This is effectively the "To-Do List" for the reconciliation team. It helps identify transactions that are missing from the bank statement or that need to be manually reconciled due to data mismatches.

# Business Challenge
If a transaction exists in Oracle but hasn't been reconciled, it means either:
1.  It hasn't cleared the bank yet (In Transit).
2.  It has cleared, but the system couldn't auto-match it (e.g., different amount or reference number).
3.  It is a duplicate or erroneous entry.

Distinguishing between "In Transit" and "Problem" items is crucial for keeping the reconciliation current.

# Solution
This report provides a comprehensive list of all unreconciled transactions available in the system.

**Key Features:**
*   **Source Filtering**: Can filter by Source (AP, AR, GL, Payroll) to route issues to the correct department.
*   **Date Range**: Allows users to focus on older items that should have cleared by now.
*   **Detail View**: Shows the Transaction Number, Date, Amount, and Currency for easy comparison with the bank statement.

# Architecture
The report queries the `CE_AVAILABLE_TRANSACTIONS_V` view, which unions all eligible unreconciled items from the subledgers.

**Key Tables:**
*   `CE_AVAILABLE_TRANSACTIONS_V`: The master view for unreconciled items.
*   `AP_CHECKS_ALL`: Unreconciled payments.
*   `AR_CASH_RECEIPTS`: Unreconciled receipts.
*   `GL_JE_LINES`: Unreconciled manual journal entries.

# Impact
*   **Reconciliation Efficiency**: Helps users quickly identify transactions that need manual attention.
*   **Data Cleanup**: Highlights old, stale transactions that may need to be voided or reversed.
*   **Cash Control**: Ensures that every system transaction is eventually accounted for against the bank.
