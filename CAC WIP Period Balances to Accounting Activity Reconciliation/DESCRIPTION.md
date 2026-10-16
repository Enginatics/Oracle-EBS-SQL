# Executive Summary
The **CAC WIP Period Balances to Accounting Activity Reconciliation** report is a forensic accounting tool designed to reconcile the Work in Process (WIP) subledger. It compares the stored WIP Period Balances (the snapshot of WIP value) against the detailed accounting activity (the actual debits and credits) for the period. Ideally, the net activity for the period should exactly match the change in the period balance. Any difference indicates a data corruption or a system bug, making this report essential for ensuring the integrity of the WIP subledger.

# Business Challenge
The WIP subledger is complex, with value flowing in from multiple sources (Material Issues, Resource Transactions, Overheads) and flowing out via Completions and Scrap.
*   **Subledger Integrity**: Sometimes, due to data corruption or patching issues, the summary table (`WIP_PERIOD_BALANCES`) gets out of sync with the detailed transaction tables (`WIP_TRANSACTION_ACCOUNTS`).
*   **Reconciliation**: If the subledger summary doesn't match the detailed accounting entries, the General Ledger balance (which comes from the accounting entries) will not match the WIP Valuation report (which often uses the balances).
*   **Audit Compliance**: Auditors require proof that the subsidiary ledger balances are mathematically correct and supported by transactions.

# Solution
This report performs a three-way match logic (conceptually) to ensure that:
`Beginning Balance + Net Activity = Ending Balance`
It specifically compares the `WIP_PERIOD_BALANCES` for the period against the sum of `WIP_TRANSACTION_ACCOUNTS` (and related tables) for the same period.

**Key Features:**
*   **Difference Detection**: Calculates a "Difference" column. In a healthy system, this should be zero.
*   **Transaction Type Breakdown**: Analyzes activity by type: Material, Resource, Overhead, OSP, Job Close Variance, and Cost Updates.
*   **Job Level Granularity**: Performs the reconciliation at the individual WIP Job level, allowing for precise identification of problem records.

# Architecture
The query aggregates data from the transaction accounting tables and compares it to the period balance table.

**Key Tables:**
*   `WIP_PERIOD_BALANCES`: The summary table holding the value of WIP at the start and end of periods.
*   `WIP_TRANSACTION_ACCOUNTS`: The accounting lines for resource and overhead transactions.
*   `MTL_TRANSACTION_ACCOUNTS`: The accounting lines for material transactions.
*   `WIP_DISCRETE_JOBS`: Job header details.

# Impact
*   **Data Health Monitoring**: Acts as an early warning system for data corruption in the WIP module.
*   **Audit Readiness**: Provides the detailed reconciliation evidence required for financial audits.
*   **Troubleshooting**: Pinpoints exactly which job and which transaction type is causing a balancing issue, significantly reducing the time required to resolve variances.
