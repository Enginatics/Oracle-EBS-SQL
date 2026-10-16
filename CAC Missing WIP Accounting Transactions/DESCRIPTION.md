# Case Study & Technical Analysis: CAC Missing WIP Accounting Transactions

## Executive Summary
The **CAC Missing WIP Accounting Transactions** report is a diagnostic tool for the Work in Process (WIP) module. It identifies WIP transactions—such as Component Issues, Resource Transactions, and Assembly Completions—that have been processed but failed to generate the corresponding accounting entries in the `WIP_TRANSACTION_ACCOUNTS` table.

## Business Challenge
*   **WIP Valuation**: If a resource is charged to a job ($100 debit to WIP) but no accounting is generated, the WIP General Ledger balance will be understated compared to the operational reality.
*   **Period Close**: Unaccounted transactions can prevent the accounting period from closing or lead to "Sweep" transactions that distort future periods.
*   **Cost Accuracy**: Missing entries mean the job cost is incomplete, leading to incorrect variance calculations upon job close.

## Solution
This report identifies the gaps.
*   **Logic**: Compares `wip_transactions` to `wip_transaction_accounts`.
*   **Resource Filter**: Can optionally ignore "Uncosted" resources (resources set up to not generate costs), reducing false positives.
*   **Scope**: Covers all WIP transaction types.

## Technical Architecture
*   **Tables**: `wip_transactions` (WT), `wip_transaction_accounts` (WTA).
*   **Join**: `WT.transaction_id = WTA.transaction_id (+)`.
*   **Condition**: `WTA.transaction_id IS NULL`.

## Parameters
*   **Transaction Date From/To**: (Mandatory) Period.
*   **Only Costed Resources**: (Mandatory) "Yes" is recommended to avoid seeing transactions for resources that are *designed* to be free.
*   **Minimum Amount**: (Optional) To filter out zero-dollar transactions.

## Performance
*   **Efficient**: Uses standard anti-join logic.
*   **Volume**: WIP transaction volume can be high in manufacturing environments, so date filtering is important.

## FAQ
**Q: How do I fix these?**
A: These often require a data fix from Oracle Support or a specialized script to re-trigger the "WIP Cost Manager".

**Q: Does this include "Move" transactions?**
A: Only if the Move transaction includes a "Resource" charge (Shop Floor Move). Pure moves often do not generate accounting unless they trigger a resource or overhead charge.
