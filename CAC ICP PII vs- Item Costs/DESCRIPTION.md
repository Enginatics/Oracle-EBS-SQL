# Case Study & Technical Analysis: CAC ICP PII vs. Item Costs

## Executive Summary
The **CAC ICP PII vs. Item Costs** report is a strategic validation tool used to audit the relationship between standard inventory costs and their embedded intercompany profit (PII) components. It serves two primary functions: validating that PII is correctly defined as a percentage of the total cost, and providing a valuation snapshot that compares "Gross Inventory Value" (with profit) vs. "Net Inventory Value" (without profit). This report is essential for ensuring that transfer pricing policies are correctly reflected in the system's cost data.

## Business Challenge
In complex supply chains, items may have PII components that are supposed to represent a specific margin (e.g., 10% of the total cost). However, due to manual errors, cost rollups, or currency fluctuations, the actual PII amount in the system might drift.
*   **Policy Compliance:** Finance needs to verify if the PII stored in the system matches the corporate transfer pricing policy.
*   **Valuation Analysis:** For management reporting, companies often need to see inventory value at "Standard Cost" vs. "Consolidated Cost" (Standard - PII).
*   **Data Integrity:** Identifying items where PII > Total Cost (which is impossible and indicates a data error) or where PII exists for "Buy" items that shouldn't have it.

## The Solution
This report provides a side-by-side comparison of the total item cost and its PII component.
*   **Cost Breakdown:** It displays `Item Cost` (Standard), `PII Item Cost` (Profit), and `Net Item Cost` (Cost Basis).
*   **Percentage Check:** It calculates the `PII Percent` (`PII / Total Cost`), allowing users to quickly spot outliers (e.g., sorting by percentage to find items with 0% or >50% profit).
*   **Dual-Mode Quantity:**
    *   **Historical Mode:** If a `Period Name` is entered, it pulls quantities from the month-end snapshot (`CST_PERIOD_CLOSE_SUMMARY`), matching the official closing balances.
    *   **Real-Time Mode:** If `Period Name` is blank, it pulls current on-hand quantities (`MTL_ONHAND_QUANTITIES_DETAIL`), useful for mid-month auditing.

## Technical Architecture (High Level)
The query joins the standard cost definition table with a specialized PII calculation subquery.
*   **Cost Type Join:** It joins `CST_ITEM_COSTS` (for the main Cost Type, usually "Frozen" or "Average") with a subquery on `CST_ITEM_COST_DETAILS` (for the specific PII Cost Type and Sub-Element).
*   **Dynamic Quantity Logic:** A complex `LEFT JOIN` structure determines the source of the quantity data (Snapshot vs. Real-Time) based on the presence of the `:p_period_name` parameter.
*   **Net Calculation:** The report performs the math `Total Cost - (Sign * PII Cost)` dynamically, handling the `Numeric Sign for PII` parameter to ensure correct netting regardless of whether PII is stored as a positive or negative value.

## Parameters & Filtering
*   **Cost Type:** The primary costing method (e.g., Frozen, Average) to compare against.
*   **PII Cost Type & Sub-Element:** The specific cost bucket holding the profit value.
*   **Period Name (Closed):** The switch that toggles between historical snapshot data and real-time on-hand data.
*   **Category Sets:** Allows for analysis by Product Line or Cost Category.

## Performance & Optimization
*   **Snapshot Utilization:** When running for a closed period, using `CST_PERIOD_CLOSE_SUMMARY` is significantly faster than summing transaction history.
*   **Inactive Item Exclusion:** The report automatically filters out inactive items to keep the output focused on relevant inventory.

## FAQ
**Q: Why is the "Net Item Cost" higher than the "Item Cost"?**
A: This happens if your `Numeric Sign for PII` parameter is set incorrectly. If PII is stored as a negative number (contra-asset) but you tell the report it's positive, the math will add it instead of subtracting it.

**Q: Can I use this to check Pending Costs before a standard cost update?**
A: Yes. Set the `Cost Type` parameter to "Pending" (or whatever your simulation cost type is named) to validate the new costs and PII values before they are frozen.

**Q: Why do some items show 0 Quantity?**
A: If you run in Real-Time mode, it shows items even if they have 0 on-hand, as long as they have a cost defined. This is useful for checking master data setup even for items currently out of stock.
