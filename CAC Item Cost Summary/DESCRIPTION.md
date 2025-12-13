# Case Study & Technical Analysis: CAC Item Cost Summary

## Executive Summary
The **CAC Item Cost Summary** report is the workhorse of cost reporting. It provides a straightforward, comprehensive list of item costs for a specified Cost Type and Organization. It is the "go-to" report for answering basic questions about inventory value, standard costs, and item attributes.

## Business Challenge
Users need a simple, reliable way to extract cost data.
*   **Accessibility**: Navigating screen-by-screen to check costs is inefficient.
*   **Attribute Context**: Knowing the cost is not enough; users also need to know the Item Status, Make/Buy code, and Default Accounts to understand the context.
*   **Uncosted Items**: Identifying items that have been created but not yet costed (Cost = 0) is a critical maintenance task.

## Solution
This report provides a flat, filterable list of item costs.
*   **Comprehensive**: Includes Unit Cost, Material Cost, Material Overhead, Resource, OSP, and Overhead buckets.
*   **Context Rich**: Includes Inventory Asset Flag, Planning Make/Buy Code, and Default COGS/Sales accounts.
*   **Maintenance Aid**: The "Include Uncosted Items" parameter helps identify gaps in the costing setup.

## Technical Architecture
The report queries the primary costing view:
*   **Core Table**: `cst_item_costs`.
*   **Item Details**: Joins to `mtl_system_items` for descriptions and control flags.
*   **Account Resolution**: Joins to `gl_code_combinations` to show the default accounts associated with the item.

## Parameters
*   **Cost Type**: (Mandatory) The cost type to display (e.g., Frozen, Pending, Average).
*   **Include Uncosted Items**: (Mandatory) Toggle to show items with no cost record.
*   **Item Status to Exclude**: (Optional) Filter out Inactive or Obsolete items.

## Performance
*   **Scalable**: Designed to handle large item masters.
*   **Indexed**: Efficiently filters by Organization and Cost Type.

## FAQ
**Q: Does this show the breakdown of resources?**
A: No, it shows the *total* Resource cost. For a breakdown by specific resource (e.g., Labor vs. Machine), use the "Item Cost & Routing" report.

**Q: Why is the cost zero?**
A: Either the item is new and hasn't been costed, or it is an Expense item (Inventory Asset Flag = No) which is not tracked with a value in inventory.

**Q: Can I use this for Average Costing?**
A: Yes, simply select the "Average" cost type.
