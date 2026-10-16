# Case Study & Technical Analysis: CAC Inventory Out-of-Balance

## Executive Summary
The **CAC Inventory Out-of-Balance** report is a critical integrity check for the Inventory module. It compares the "Period Close Snapshot" (the official subledger balance) against the cumulative value of the inventory accounting entries. Any difference indicates a corruption or data integrity issue where the General Ledger (fed by accounting entries) does not match the physical inventory value (fed by the snapshot).

## Business Challenge
Data integrity issues in ERP systems can lead to financial misstatements.
*   **Phantom Variance**: If the GL says we have $1M but the subledger detail only lists $900k of items, there is a $100k "phantom" asset that cannot be explained.
*   **Audit Failure**: Auditors expect the subledger and GL to match exactly. Unexplained variances are a red flag.
*   **Root Cause Analysis**: Finding the specific item or transaction causing the drift is like finding a needle in a haystack without a targeted tool.

## Solution
This report acts as a precision diagnostic tool.
*   **Item-Level Variance**: It doesn't just show a total difference; it identifies the specific *Item Number* and *Subinventory* where the mismatch exists.
*   **Threshold Filtering**: The "Minimum Value Difference" parameter allows users to ignore rounding errors (e.g., < $1.00) and focus on material variances.
*   **Snapshot vs. Accounting**: Explicitly compares the `CST_PERIOD_CLOSE_SUMMARY` value against the calculated value of on-hand + transactions.

## Technical Architecture
The report relies on the fundamental equation of inventory accounting:
*   **Equation**: `Beginning Balance + Transactions = Ending Balance`.
*   **Comparison**: It compares the stored Ending Balance (Snapshot) with the derived Ending Balance (calculated from transactions).
*   **Tables**: `cst_period_close_summary` vs. `mtl_material_transactions` (aggregated).

## Parameters
*   **Period Name**: (Mandatory) The closed period to validate.
*   **Minimum Value Difference**: (Mandatory) Filter to suppress noise (default is usually 1).

## Performance
*   **Heavy Processing**: To verify the balance, the report may need to sum millions of transactions. It is a resource-intensive report.
*   **Strategic Run**: Should be run immediately after period close, or when a variance is detected in the high-level reconciliation.

## FAQ
**Q: What causes an out-of-balance?**
A: Common causes include: Data corruption, manual SQL updates to tables, code bugs in custom interfaces, or changing the cost of an item without running the proper update process.

**Q: How do I fix it?**
A: If the variance is real, it usually requires a "Data Fix" from Oracle Support or a manual journal entry to align the GL with the physical reality.

**Q: Does this check the GL?**
A: No, it checks the *internal consistency* of the Inventory module (Snapshot vs. Transactions). Reconciling to the GL is a separate step.
