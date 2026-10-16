# Case Study & Technical Analysis: CAC Missing Receiving Accounting Transactions

## Executive Summary
The **CAC Missing Receiving Accounting Transactions** report is the Receiving equivalent of the Material Missing Accounting report. It identifies Receiving transactions (Receipts, Deliveries, Returns) that have been processed but failed to generate the necessary accounting entries in the Receiving Subledger (`rcv_receiving_sub_ledger`).

## Business Challenge
*   **Accrual Reconciliation**: The "Received Not Invoiced" (Accrual) account relies on these entries. If they are missing, the Accrual Reconciliation report will be wrong.
*   **Inventory Value**: A "Delivery" transaction moves cost from Receiving Inspection to Inventory. If the accounting is missing, the Inspection account won't clear.
*   **Compliance**: Every financial event must have a GL impact.

## Solution
This report identifies the orphans.
*   **Logic**: Checks `rcv_transactions` against `rcv_receiving_sub_ledger`.
*   **Scope**: Includes PO Receipts, RMAs, and OSP receipts.
*   **Exclusions**: Filters out transaction types that don't generate accounting (e.g., some internal moves).

## Technical Architecture
*   **Tables**: `rcv_transactions` (RT), `rcv_receiving_sub_ledger` (RRSL).
*   **Join**: `RT.transaction_id = RRSL.rcv_transaction_id (+)`.
*   **Condition**: `RRSL.rcv_transaction_id IS NULL`.

## Parameters
*   **Transaction Date From/To**: (Mandatory) Period.
*   **Minimum Transaction Amount**: (Optional) To ignore zero-dollar receipts.

## Performance
*   **Fast**: Receiving volumes are typically lower than Material volumes.

## FAQ
**Q: Why does this happen?**
A: Often due to the "Receiving Transaction Processor" failing or the "Create Accounting - Receiving" program not picking up the event.

**Q: Does it include "Correct" transactions?**
A: Yes, corrections should generate accounting (reversing the original entry), so they are checked as well.
