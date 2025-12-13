# Case Study & Technical Analysis: CAC WIP Accounts Setup

## Executive Summary
The **CAC WIP Accounts Setup** report is a configuration audit tool. It documents the General Ledger accounts assigned to each "WIP Accounting Class". This setup dictates where costs flow during production (e.g., which account captures Material Usage Variance).

## Business Challenge
*   **Segmentation**: "We want R&D jobs to hit a different Expense account than Production jobs." This requires separate WIP Accounting Classes.
*   **Variance Analysis**: "Why is the Labor Efficiency Variance mixed in with the Material Usage Variance?" (Answer: They are mapped to the same GL account).
*   **New Org Setup**: Verifying that the new plant has the correct account mappings before go-live.

## Solution
This report lists the mapping.
*   **Class**: The WIP Accounting Class (e.g., "Discrete", "Rework").
*   **Accounts**: Material, Material Overhead, Resource, OSP, Overhead.
*   **Variances**: Material Variance, Resource Variance, etc.
*   **Valuation**: The WIP Asset account.

## Technical Architecture
*   **Tables**: `wip_accounting_classes`, `gl_code_combinations`.
*   **Logic**: Simple dump of the class definition.

## Parameters
*   **Organization Code**: (Optional) Filter by plant.

## Performance
*   **Fast**: Configuration data.

## FAQ
**Q: Can I change these accounts while jobs are open?**
A: Generally No. The accounts are stamped on the job at creation. Changing the setup only affects *new* jobs.
