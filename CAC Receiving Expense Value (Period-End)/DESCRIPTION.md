# Case Study & Technical Analysis: CAC Receiving Expense Value (Period-End)

## Executive Summary
The **CAC Receiving Expense Value (Period-End)** report focuses on the valuation of "Expense" destination items. In Oracle EBS, you can configure expense items (like Office Supplies) to "Accrue on Receipt". This means they hit the Balance Sheet (Receiving Inspection) upon receipt and only move to the Expense account upon Delivery. This report values that specific slice of inventory.

## Business Challenge
*   **Hidden Liabilities**: Expense accruals are often overlooked. A large delivery of computers (expensed assets) can sit in receiving, representing a significant liability.
*   **Period-End Rollback**: You need to know what the value was *as of* the last day of the month, even if you are running the report on the 5th of the new month.
*   **Account Offset**: Verifying that the offset account (the eventual Expense account) is correct.

## Solution
This report provides "As Of" valuation.
*   **Rollback Logic**: Starts with current quantities and reverses transactions that happened after the "As Of" date.
*   **Scope**: Filters specifically for `Destination Type Code = 'EXPENSE'`.
*   **Valuation**: Uses the PO Price (since expense items often don't have a standard cost).

## Technical Architecture
*   **Tables**: `rcv_transactions`, `po_lines_all`.
*   **Logic**: Complex "As Of" logic using `transaction_date` vs. `p_period_end_date`.

## Parameters
*   **Period Name**: (Mandatory) The target period for valuation.

## Performance
*   **Complex**: Rollback logic requires scanning history, but the volume of Expense receipts is usually lower than Inventory receipts.

## FAQ
**Q: Why not just use the standard Receiving Value report?**
A: The standard report often excludes Expense destinations or mixes them in. This report isolates them for specific accrual reconciliation.
