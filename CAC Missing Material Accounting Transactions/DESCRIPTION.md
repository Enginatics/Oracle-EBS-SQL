# Case Study & Technical Analysis: CAC Missing Material Accounting Transactions

## Executive Summary
The **CAC Missing Material Accounting Transactions** report is a critical health check for the Costing process. It identifies "Costed" material transactions that failed to generate accounting entries. In a healthy system, this report should be empty. If rows appear, it indicates data corruption or a stuck process that requires immediate IT intervention.

## Business Challenge
*   **Financial Integrity**: If a shipment occurs ($100 credit to Inventory) but no accounting is generated, the GL Inventory balance will remain $100 higher than reality.
*   **Period Close**: You cannot close the inventory period if transactions are uncosted, but "Missing Accounting" transactions often slip through the standard close check because they are technically flagged as "Costed".
*   **Root Cause**: Often caused by code bugs, database triggers, or severe performance issues during the Cost Manager run.

## Solution
This report finds the gap.
*   **Logic**: Looks for rows in `mtl_material_transactions` where `costed_flag IS NULL` (meaning costed) BUT no rows exist in `mtl_transaction_accounts`.
*   **Filters**: Can ignore "Expense" items (which might not generate accounting depending on setup) and zero-cost items.
*   **Context**: Shows the Transaction Type and ID to help the DBA investigate.

## Technical Architecture
*   **Tables**: `mtl_material_transactions` (MMT), `mtl_transaction_accounts` (MTA).
*   **Join**: `MMT.transaction_id = MTA.transaction_id (+)`.
*   **Condition**: `MTA.transaction_id IS NULL`.

## Parameters
*   **Transaction Date From/To**: (Mandatory) Period to check.
*   **Only Costed Items**: (Optional) To filter out items that shouldn't have accounting anyway (Asset = No).

## Performance
*   **Efficient**: Uses an anti-join pattern (NOT EXISTS or Outer Join IS NULL) which is generally efficient on indexed transaction IDs.

## FAQ
**Q: How do I fix these?**
A: You typically cannot fix them from the front end. You may need to "Uncost" the transaction (set `costed_flag = 'N'`) via SQL to force the Cost Manager to try again.

**Q: Are expense items included?**
A: By default, yes, but the "Only Costed Items" parameter allows you to exclude them if your policy is not to account for expense item movements.
