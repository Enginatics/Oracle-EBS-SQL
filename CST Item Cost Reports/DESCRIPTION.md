# Executive Summary
The **CST Item Cost Reports** is a versatile, multi-purpose reporting tool designed to analyze item costs from various angles. Instead of having ten separate reports for "Cost by Activity", "Cost by Department", "Cost by Operation", etc., this single report uses a "Report Name" parameter to pivot the data dynamically. It is invaluable for deep-dive cost analysis in manufacturing environments.

# Business Challenge
Different users need to see cost data in different ways:
*   **Production Manager**: "How much does the 'Assembly' department contribute to the cost of this widget?" (View: Element by Department)
*   **Process Engineer**: "Which specific operation is the most expensive?" (View: Operation Summary)
*   **Cost Accountant**: "What is the breakdown of overheads?" (View: Sub-Element)

# Solution
A single SQL report that changes its output columns and grouping based on the user's selection.

**Key Views (Report Names):**
*   **Activity Summary**: Costs grouped by Activity (ABC Costing).
*   **Element**: The classic Material/Labor/Overhead breakdown.
*   **Operation Summary**: Costs grouped by Routing Operation Sequence.
*   **Sub-Element**: Detailed breakdown (e.g., "Gold" vs. "Silver" material, or "Setup" vs. "Run" labor).

# Architecture
The report queries the `CST_DETAIL_COST_VIEW`, a standard Oracle view that joins `CST_ITEM_COSTS` and `CST_ITEM_COST_DETAILS` with related master data tables like `BOM_DEPARTMENTS` and `BOM_OPERATION_SEQUENCES`.

**Key Tables:**
*   `CST_DETAIL_COST_VIEW`: The primary source of cost details.
*   `CST_COST_TYPES`: Defines the cost scenario (Frozen, Pending, etc.).
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

# Impact
*   **Decision Support**: Provides the specific data slice needed for make-vs-buy decisions, process improvements, and pricing.
*   **Simplicity**: Reduces the number of distinct reports users need to learn and maintain.
*   **Granularity**: Offers the deepest possible view into the components of a standard cost.
