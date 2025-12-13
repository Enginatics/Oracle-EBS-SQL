# Case Study & Technical Analysis: CAC Number of Item Costs by Cost Type

## Executive Summary
The **CAC Number of Item Costs by Cost Type** report is a simple but vital utility for Cost Accountants. It provides a count of how many items exist in one Cost Type versus another. This is primarily used during the "Cost Copy" process to verify that the copy was successful and complete.

## Business Challenge
*   **Completeness Check**: You have 10,000 items in your "Frozen" cost type. You copy them to "Pending" to simulate a price increase. Did all 10,000 copy over? Or did 50 fail?
*   **Multi-Org Validation**: Did the copy process work for all 5 inventory organizations, or did one fail?

## Solution
This report provides a side-by-side count.
*   **Comparison**: Count(Cost Type A) vs. Count(Cost Type B).
*   **Granularity**: Breaks down the count by Organization.
*   **Variance**: Ideally, the counts should match (or match the expected subset).

## Technical Architecture
*   **Query**: `SELECT count(*) FROM cst_item_costs GROUP BY organization_id, cost_type_id`.
*   **Logic**: Simple aggregation.

## Parameters
*   **From Cost Type**: (Mandatory) Source.
*   **To Cost Type**: (Mandatory) Target.
*   **Org Code**: (Optional) Filter.

## Performance
*   **Instant**: Counting rows is extremely fast in Oracle.

## FAQ
**Q: Why would the counts differ?**
A: The "Cost Copy" program has options to "Copy Only Based on Rollup" or "Copy Only Buy Items". If you used these filters, the target count will be lower. Also, if an item already exists in the target, it's an update, not an insert, so the count might not change.
