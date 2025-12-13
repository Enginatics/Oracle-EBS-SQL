# Case Study & Technical Analysis: CAC Item Cost Out-of-Balance

## Executive Summary
The **CAC Item Cost Out-of-Balance** report is a technical integrity check for the Costing module. It verifies that the summary unit cost stored in the header table (`cst_item_costs`) matches the sum of the detailed cost elements stored in the detail table (`cst_item_cost_details`). Any discrepancy here indicates data corruption that can lead to serious accounting errors.

## Business Challenge
Oracle Costing stores costs in two places: a Header (Total) and Details (Breakdown).
*   **Data Corruption**: Bugs, manual SQL updates, or failed processes can cause these two to get out of sync.
*   **Accounting Impact**: Inventory valuation reports often use the Header, while accounting distributions often use the Details. If they differ, the GL will not match the Subledger.
*   **Hidden Errors**: These errors are invisible on standard screens, which usually display the Detail sum.

## Solution
This report hunts for these "impossible" errors.
*   **Math Check**: Calculates `Header Cost - Sum(Detail Costs)`.
*   **Variance Reporting**: Lists any item where the difference is not zero.
*   **Scope**: Checks all items in the selected organization and cost type.

## Technical Architecture
The report is a direct database integrity query:
*   **Tables**: `cst_item_costs` (Header) and `cst_item_cost_details` (Detail).
*   **Aggregation**: Groups the details by `inventory_item_id` and sums the `item_cost`.
*   **Comparison**: Compares the summed detail to the stored header `item_cost`.

## Parameters
*   **Organization Code**: (Optional) The org to check.
*   **Item Number**: (Optional) Specific item.

## Performance
*   **Fast**: It performs a simple aggregation and comparison.
*   **Zero Rows**: In a healthy system, this report should return **zero rows**.

## FAQ
**Q: How does this happen?**
A: It is rare. It usually happens after a custom data migration, a patch application that failed mid-stream, or a manual update to the database tables by a DBA.

**Q: How do I fix it?**
A: You usually need to run a "Cost Update" or "Cost Rollup" for the affected items to force the system to recalculate and resave the data correctly. In severe cases, an Oracle Data Fix is required.

**Q: Is a small difference okay?**
A: No. Even a $0.00001 difference is a sign of corruption. The system is designed to be exact.
