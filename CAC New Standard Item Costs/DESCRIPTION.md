# Case Study & Technical Analysis: CAC New Standard Item Costs

## Executive Summary
The **CAC New Standard Item Costs** report is a change management tool for Standard Costing. It focuses specifically on the "Standard Cost Update" event—the moment when a "Pending" cost becomes "Frozen". It allows the finance team to review exactly what changed during the last cost roll.

## Business Challenge
*   **Impact Analysis**: "We just updated costs for 5,000 items. Which ones changed the most?"
*   **Audit**: Verifying that the cost update run on January 1st actually captured all the intended items.
*   **History**: Providing a historical record of cost changes for a specific item over time.

## Solution
This report links the Item to the Cost Update history.
*   **Event-Based**: Driven by the `Cost Update Date`, not the transaction date.
*   **Comparison**: Shows the New Cost vs. the Prior Cost (if available in the history tables).
*   **Context**: Includes the "Update Description" (e.g., "2024 Annual Standard Cost Update").

## Technical Architecture
*   **Tables**: `cst_standard_costs` (History), `cst_cost_updates` (Header), `cst_item_costs` (Current).
*   **Logic**: Filters for records linked to a specific Cost Update ID or Date range.

## Parameters
*   **Cost Update Date From/To**: (Mandatory) The date the update program was run.
*   **From Cost Type**: (Optional) The source cost type (e.g., Pending) used for the update.

## Performance
*   **Variable**: Depends on the number of items updated. A full annual roll might have 100,000 rows.

## FAQ
**Q: Does this show manual cost updates?**
A: If the manual update was done via the "Interface" or "Cost Update" screen, yes. If it was done via direct SQL (not recommended), it might not appear here.

**Q: Why is the "Prior Cost" zero?**
A: If it's a new item receiving its first standard cost, the prior cost is zero.
