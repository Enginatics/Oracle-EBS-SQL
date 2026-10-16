# Case Study & Technical Analysis: CAC Recost Cost of Goods Sold

## Executive Summary
The **CAC Recost Cost of Goods Sold** report is a powerful financial simulation tool. It allows Cost Accountants to answer "What If" questions regarding margins. Specifically, it compares the COGS recorded in the General Ledger (based on the active Standard Cost) against a theoretical COGS calculated using a different Cost Type (e.g., "Proposed 2024 Standard").

## Business Challenge
*   **Margin Analysis**: "If we had used the new raw material prices, what would our Q1 margins have looked like?"
*   **Correction**: "We set the standard cost of Item A to $10 by mistake. It should have been $100. How much COGS do we need to adjust manually?"
*   **Budgeting**: Validating the impact of next year's standard costs on historical sales volumes.

## Solution
This report performs a retrospective valuation.
*   **Input**: Historical Sales Transactions (COGS Recognition, Sales Order Issue).
*   **Calculation**:
    *   Actual COGS = Qty * Frozen Cost.
    *   Simulated COGS = Qty * Recost Cost Type (e.g., Pending).
*   **Output**: The variance between Actual and Simulated COGS, grouped by Account and Item.

## Technical Architecture
*   **Tables**: `mtl_material_transactions`, `cst_item_costs` (joined twice: once for Frozen, once for Recost).
*   **Logic**: Filters for Transaction Action 'Issue from Stores' and Source Type 'Sales Order'.

## Parameters
*   **Recost Cost Type**: (Mandatory) The "What If" cost type.
*   **Transaction Date From/To**: (Mandatory) The historical period to analyze.
*   **Minimum Value Difference**: (Mandatory) Threshold to filter out noise.

## Performance
*   **Heavy**: Recalculating costs for millions of sales lines is intensive. Use tight date ranges.

## FAQ
**Q: Does this update the GL?**
A: No, it is a reporting tool only. Any adjustments must be booked via manual journal entries.
**Q: Can it handle RMA?**
A: Yes, Return Material Authorizations (Credits) are included to give a net COGS impact.
