# Case Study & Technical Analysis: CAC PO Receipt History for Actual Costing

## Executive Summary
The **CAC PO Receipt History for Actual Costing** report is essential for organizations using Average, FIFO, or LIFO costing. In these methods, the "Item Cost" is dynamic—it updates with every receipt. This report provides the audit trail explaining *why* the cost changed, by showing the receipt quantity and price that drove the update.

## Business Challenge
*   **Cost Volatility**: "Why did the cost of Widget A jump from $5 to $8 yesterday?"
*   **Audit Trail**: In Standard Costing, costs only change once a year. In Actual Costing, they change daily. Tracing the specific receipt that caused a spike is difficult without a dedicated report.
*   **Inventory Valuation**: Validating that the weighted average calculation was performed correctly.

## Solution
This report reconstructs the cost update logic.
*   **Sequence**: Lists receipts in chronological order.
*   **Calculation**: Shows `Prior Onhand`, `Prior Cost`, `Receipt Qty`, `Receipt Price` -> `New Onhand`, `New Cost`.
*   **Scope**: Includes PO Receipts and Inter-Org Transfers (which also update average cost).

## Technical Architecture
*   **Tables**: `mtl_material_transactions` (MMT), `rcv_transactions`.
*   **Logic**: Links the inventory transaction (MMT) to the receiving transaction (RCV) to get the PO price details.
*   **Complexity**: Actual Costing history is stored in `mtl_cst_actual_cost_details` and `mtl_material_txn_allocations`, which are complex to join.

## Parameters
*   **Transaction Date From/To**: (Mandatory) Period to analyze.
*   **Item Number**: (Optional) Specific item to trace.

## Performance
*   **High Volume**: MMT is often the largest table in the database. Filtering by Date and Item is crucial for performance.

## FAQ
**Q: Can I use this for Standard Costing?**
A: You can, but the "Prior Cost" and "New Cost" columns might not be relevant as Standard Cost doesn't change on receipt. Use the "Item Costing" version instead.

**Q: Does it include freight?**
A: If "Landed Cost Management" (LCM) is used, the receipt price will include estimated landed costs.
