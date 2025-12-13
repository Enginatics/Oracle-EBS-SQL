# Case Study & Technical Analysis: CAC WIP Account Value

## Executive Summary
The **CAC WIP Account Value** report is the standard "WIP Inventory Value" report. It calculates the value of Work in Process as of a specific period end. This value represents the "Asset" on the balance sheet—materials issued, labor charged, and overheads absorbed, minus any completions or scrap.

## Business Challenge
*   **Balance Sheet Validation**: The Controller needs a detailed list of jobs that make up the $10M "WIP Inventory" asset.
*   **Aging**: "Why is this job from 2019 still open and carrying value?" (Stale WIP).
*   **Costing Method**: Works for both Standard (Variance based) and Average (Actual Cost based) costing.

## Solution
This report calculates the balance.
*   **Formula**: `Costs In (Material + Resource + Overhead) - Costs Out (Completion + Scrap) = Ending Balance`.
*   **Status**: Shows if the job is Open, Complete, or Closed (if run for a prior period).
*   **Breakdown**: Columns for Material, Labor, Overhead, OSP, etc.

## Technical Architecture
*   **Tables**: `wip_period_balances`, `wip_discrete_jobs`.
*   **Logic**: Uses the snapshot table `wip_period_balances` which stores the value at the end of each period.

## Parameters
*   **Period Name**: (Mandatory) The target period.
*   **Include Expense WIP**: (Optional) Toggle to show non-asset jobs (e.g., Maintenance).

## Performance
*   **Fast**: Queries summary tables rather than summing individual transactions.

## FAQ
**Q: Why is my WIP value negative?**
A: Usually timing. You completed the assembly (Credit) *before* you issued the components (Debit). This is a process error called "Negative WIP".
