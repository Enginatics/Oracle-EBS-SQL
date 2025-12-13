# Case Study & Technical Analysis: CAC Item Cost & Routing

## Executive Summary
The **CAC Item Cost & Routing** report is a deep-dive costing tool that provides a granular view of item costs, specifically focusing on the "Make" items where routing and resource costs play a significant role. It allows for a side-by-side comparison of two different Cost Types (e.g., Frozen vs. Pending), making it an essential tool for analyzing the impact of routing changes or resource rate updates.

## Business Challenge
Understanding the cost of a manufactured item requires more than just a total number.
*   **Cost Drivers**: Engineers and Accountants need to know *why* a cost increased. Was it a material price hike? Or did the labor hours in the routing increase?
*   **Routing Validation**: Verifying that the correct resources and usage rates are being rolled up into the standard cost is difficult without a detailed report.
*   **Basis Analysis**: Identifying which costs are driven by Lot size vs. Item quantity is crucial for setting optimal batch sizes.

## Solution
This report exposes the DNA of the item cost.
*   **Detailed Breakdown**: Shows the cost components (Material, Material Overhead, Resource, Outside Processing, Overhead).
*   **Comparison**: The dual-Cost Type parameter allows users to see exactly which component changed between the current standard and a proposed simulation.
*   **Basis Visibility**: Explicitly reports the "Basis Type" (Item, Lot, Total Value), helping users understand the behavior of the cost element.

## Technical Architecture
The report queries the core costing tables:
*   **Cost Details**: `cst_item_cost_details` provides the row-by-row breakdown of the cost.
*   **Item Master**: `mtl_system_items` provides the Make/Buy flag and status.
*   **Logic**: It pivots or joins the cost details for the two selected cost types to present them in a comparative format.

## Parameters
*   **Cost Type**: (Mandatory) The primary cost type to report.
*   **Cost Type 2**: (Optional) A second cost type for comparison.
*   **Make or Buy**: (Optional) Filter to focus on Manufactured items.
*   **Basis Type**: (Optional) Filter for specific cost drivers (e.g., 'Lot').

## Performance
*   **Detail Level**: This report can generate a large volume of data if run for all items, as it outputs multiple rows per item (one for each cost element/level).
*   **Optimization**: Filtering by "Make" items or specific Categories is recommended for performance.

## FAQ
**Q: Does this show the Routing operations?**
A: It shows the *cost* associated with resources, which are derived from the routing. It doesn't show the operation sequence numbers directly, but the resource usage reflects the routing.

**Q: Why is the "Lot" basis cost so high?**
A: Lot-based costs are calculated as `(Resource Rate * Usage) / Costing Lot Size`. If the lot size is small, the unit cost will be high.

**Q: Can I use this for Buy items?**
A: Yes, for Buy items it typically shows the Material cost and any Material Overhead.
