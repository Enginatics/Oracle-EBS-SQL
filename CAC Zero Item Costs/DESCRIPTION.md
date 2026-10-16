# Executive Summary
The **CAC Zero Item Costs** report is an inventory master data audit tool designed to identify items that have a standard cost of zero. While some items (like expense items or new parts) legitimately have zero cost, a "make" or "buy" part with zero cost in a standard costing environment can lead to significant accounting errors, such as zero-value inventory transactions and incorrect margins. This report helps the Cost Accounting team proactively monitor and fix missing costs before they cause transaction issues.

# Business Challenge
In an ERP system, if an item has a cost of zero:
*   **Valuation Errors**: Inventory on hand will have zero value on the balance sheet.
*   **Margin Errors**: Sales of the item will show 100% margin (Sales Price - 0 Cost), overstating profit.
*   **Transaction Errors**: Issues to WIP or shipments will carry zero value, distorting job costs and COGS.

It is critical to identify these items *before* they are transacted. However, with thousands of items created automatically or manually, it is easy for cost setup to be missed.

# Solution
This report scans the Item Master and Cost tables to find items where the total cost in the specified Cost Type (usually "Frozen" or "Standard") is zero. It provides context such as the item's creation date, last transaction date, and on-hand quantity to help prioritize which items need immediate attention.

**Key Features:**
*   **Zero Cost Detection**: Filters specifically for items with `ITEM_COST = 0` or no cost record.
*   **Activity Context**: Shows the "Last Transaction Date" and "On-hand Quantity". A zero-cost item with stock or recent activity is a high-priority fix.
*   **Creation Date Filtering**: Allows users to focus on recently created items (e.g., "Show me all items created this week with zero cost").
*   **Category Filtering**: Supports filtering by item categories (e.g., Product Line) to route the missing cost requests to the appropriate analysts.

# Architecture
The query joins `MTL_SYSTEM_ITEMS` (Item Master) with `CST_ITEM_COSTS` (Cost table). It typically uses an outer join to find items that might not even have a record in the cost table yet.

**Key Tables:**
*   `MTL_SYSTEM_ITEMS`: Defines the item and its attributes (Make/Buy, Asset/Expense).
*   `CST_ITEM_COSTS`: Stores the standard cost for the item.
*   `MTL_ONHAND_QUANTITIES`: (Aggregated) to show if the item is currently in stock.
*   `MTL_MATERIAL_TRANSACTIONS`: To find the last transaction date.

# Impact
*   **Data Quality**: Ensures the integrity of the item master and cost data.
*   **Financial Accuracy**: Prevents the recording of zero-value transactions that distort financial statements.
*   **Proactive Management**: Enables the cost team to catch missing costs immediately after item creation, rather than waiting for a month-end error report.
