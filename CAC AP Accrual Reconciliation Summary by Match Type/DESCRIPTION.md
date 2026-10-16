# Case Study & Technical Analysis: CAC AP Accrual Reconciliation Summary by Match Type

## Executive Summary
The **CAC AP Accrual Reconciliation Summary by Match Type** is a strategic financial report designed to streamline the month-end closing process for Oracle Cost Management. It provides a high-level aggregation of the Accounts Payable (AP) Accrual liability, categorized by **Match Type** (e.g., PO Match, Consignment, Miscellaneous). This summary view allows Finance teams to quickly understand the composition of their accrual balance without getting lost in the details of thousands of individual transactions.

## Business Challenge
The "Received Not Invoiced" (RNI) account is often one of the most difficult accounts to reconcile.
*   **Data Volume:** A typical organization may have thousands of open receipts at any given time. Standard reports often list these line-by-line, making it difficult to spot trends or anomalies.
*   **Source Identification:** When the General Ledger balance doesn't match the Subledger, it's hard to know where to look. Is the variance due to standard Purchase Orders, Consignment inventory, or manual journal entries?
*   **Efficiency:** Reviewing detailed reports for high-level variance analysis is inefficient and delays the period close.

## Solution
This report solves these challenges by summarizing the data already present in the Oracle Accrual Reconciliation tables.
*   **Categorization:** Groups transactions by `Accrual Match Type`, instantly showing how much of the balance is due to standard PO matching vs. other sources.
*   **Drill-Down Path:** Serves as the starting point for reconciliation. Users can identify a high-value category (e.g., "Miscellaneous Accrual") and then run detailed reports for just that category.
*   **Multi-Org Support:** Aggregates data by Operating Unit and Inventory Organization, providing a clear view of liabilities across the enterprise.

## Technical Architecture
The report leverages the standard Oracle Accrual Reconciliation architecture:
*   **Data Source:** Queries `CST_AP_PO_RECONCILIATION` and `CST_MISC_RECONCILIATION`. These tables are populated by the standard **Accrual Reconciliation Load Run** concurrent program.
*   **Integration:** Joins with `HR_ALL_ORGANIZATION_UNITS` and `GL_LEDGERS` to provide meaningful organizational context.
*   **Logic:** The SQL focuses on aggregation, summing the `AMOUNT` columns based on the `ACCRUAL_MATCH_TYPE` code.

## Parameters & Filtering
*   **Transaction Date From/To:** (Mandatory) Defines the period for the reconciliation. These dates should align with your accounting period.
*   **Operating Unit:** (Optional) Filter by specific Operating Unit to reconcile one entity at a time.
*   **Ledger:** (Optional) Filter by Ledger for higher-level financial reporting.

## Performance & Optimization
*   **Prerequisite:** The **Accrual Reconciliation Load Run** program must be executed *before* running this report. If the load program hasn't run, this report will return no data or outdated data.
*   **Speed:** Extremely fast. Since it queries a dedicated reporting table (`CST_AP_PO_RECONCILIATION`) rather than raw transaction tables, it typically completes in seconds.

## FAQ
**Q: Why is the report output empty?**
A: This report relies on the `CST_AP_PO_RECONCILIATION` table. You must run the **Accrual Reconciliation Load Run** concurrent request for the specific Operating Unit and period before running this report.

**Q: What does "Match Type" mean?**
A: The Match Type indicates the nature of the accrual entry. Common types include:
*   **PO Match:** Standard accrual from a Purchase Order receipt.
*   **Consignment:** Accrual related to consigned inventory consumption.
*   **Write-Off:** Entries that have been written off but are still in the history tables.

**Q: Can I use this for "On Receipt" and "Period End" accruals?**
A: This report is designed for **On Receipt** accruals (Perpetual Accruals). Period End accruals are typically handled differently in the General Ledger.
