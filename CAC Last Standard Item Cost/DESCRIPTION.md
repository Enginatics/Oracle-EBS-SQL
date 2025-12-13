# Case Study & Technical Analysis: CAC Last Standard Item Cost

## Executive Summary
The **CAC Last Standard Item Cost** report is a forensic costing tool. It reconstructs the history of the "Frozen" (Standard) cost by identifying the last time a Standard Cost Update was successfully run for each item. This is crucial for year-end audits and for understanding the provenance of the current standard cost.

## Business Challenge
In a Standard Costing environment, the "Frozen" cost is static until explicitly updated.
*   **Stale Costs**: An item might have a cost that was set 5 years ago. Management needs to know *how old* the cost is.
*   **Audit Trail**: Auditors often ask, "When was this cost established and who approved it?"
*   **Process Validation**: Did the annual cost roll/update process actually update *all* items, or were some skipped?

## Solution
This report links the current cost back to the update event.
*   **Timestamp**: Shows the `Cost Update Date` for the most recent update.
*   **Source**: Identifies the `Cost Update Description` (e.g., "2023 Annual Roll").
*   **Status**: Confirms that the update status was "Completed".
*   **Context**: Shows the cost value at that time compared to the current Frozen cost.

## Technical Architecture
The report joins the item cost to the standard cost history tables:
*   **Tables**: `cst_item_costs` (Current), `cst_standard_costs` (History), `cst_cost_updates` (The Event).
*   **Logic**: It finds the `MAX(cost_update_date)` for each item to pinpoint the latest revision.
*   **Outer Joins**: Handles cases where an item might have a cost but no update history (e.g., direct SQL insert or legacy migration).

## Parameters
*   **Cost Update Date To**: (Mandatory) The cutoff date for the analysis.
*   **Organization Code**: (Optional) The inventory org.
*   **Item Status**: (Optional) To exclude obsolete items.

## Performance
*   **Historical Data**: The `cst_standard_costs` table can be very large. The report uses the `Cost Update Date` to limit the scan, but performance depends on the volume of historical updates.

## FAQ
**Q: Why is the "Last Update" date blank?**
A: If the item was created and costed via a direct interface or data load that didn't use the standard "Cost Update" concurrent program, there may be no record in `cst_cost_updates`.

**Q: Does this show the *previous* cost?**
A: It shows the cost *as of* the update. To see the previous cost, you would need to look at the history prior to that update.

**Q: Is this useful for Average Costing?**
A: No, this is specific to Standard Costing (`cst_standard_costs`). Average costs change with every transaction.
