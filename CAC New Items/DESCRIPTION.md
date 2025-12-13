# Case Study & Technical Analysis: CAC New Items

## Executive Summary
The **CAC New Items** report is a Master Data governance tool. It lists all items created within a specified date range, providing a comprehensive view of their setup status: Costing, Accounting, Categories, and Inventory Controls. It is the "New Hire Orientation" for your Inventory Master.

## Business Challenge
*   **Data Quality**: New items are the most common source of errors. Users forget to assign a Category, set the "Costed" flag, or define the COGS account.
*   **Process Control**: "Did the Engineering team finish setting up the new product line?"
*   **Costing Gaps**: Identifying items that have been created but have a zero cost (or haven't been costed yet).

## Solution
This report provides a 360-degree view of the new item.
*   **Attributes**: Lists Status, Make/Buy, UOM, and Asset Flag.
*   **Financials**: Shows the current Unit Cost and the default GL accounts.
*   **Activity**: Shows the "Last Transaction Date" to see if the item is already being used.
*   **Stock**: Shows current On-hand quantity.

## Technical Architecture
*   **Primary Driver**: `mtl_system_items.creation_date`.
*   **Joins**: Links to `cst_item_costs` (for cost), `gl_code_combinations` (for accounts), and `mtl_onhand_quantities` (for stock).

## Parameters
*   **Creation Date From/To**: (Mandatory) The window of time to audit.
*   **Include Uncosted Items**: (Mandatory) "Yes" allows you to find items that missed the costing process.

## Performance
*   **Fast**: Filtering by Creation Date is highly efficient.

## FAQ
**Q: Does it show who created the item?**
A: Yes, it typically includes the "Created By" user ID.

**Q: Can I use this to find "Changed" items?**
A: No, this only looks at the *Creation* date. To find changed items, you would need to query the `last_update_date` or use an audit trail report.
