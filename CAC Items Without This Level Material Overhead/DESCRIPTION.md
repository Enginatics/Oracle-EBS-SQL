# Case Study & Technical Analysis: CAC Items Without This Level Material Overhead

## Executive Summary
The **CAC Items Without This Level Material Overhead** report is a revenue leakage prevention tool. It identifies items that are missing "Material Overhead" (MOH). For many manufacturing and distribution companies, MOH is the mechanism used to recover freight, handling, and procurement costs. If an item lacks this cost element, the company is effectively subsidizing these expenses.

## Business Challenge
*   **Under-Costing**: If you pay 5% for freight but don't add it to the item cost, your margin analysis is inflated.
*   **Inconsistency**: Some items might have the overhead applied automatically, while others (perhaps manually created) were missed.
*   **Compliance**: Government contracting or transfer pricing rules often require a consistent application of overheads.

## Solution
This report acts as a "completeness check".
*   **Filter**: It looks for items where the `Material Overhead` cost element at `This Level` is zero or null.
*   **Scope**: Can be run for Buy items (where MOH is most common) or Make items.
*   **Basis Analysis**: Helps verify if the missing overhead is due to a missing "Basis" (e.g., Item vs. Lot).

## Technical Architecture
The report queries the detailed cost table:
*   **Table**: `cst_item_cost_details`.
*   **Condition**: Checks for the absence of `cost_element_id = 2` (Material Overhead) or where the value is 0.
*   **Join**: Links to `mtl_system_items` to filter by Make/Buy code.

## Parameters
*   **Cost Type**: (Mandatory) The cost type to check.
*   **Make or Buy**: (Optional) Usually set to 'Buy' to focus on purchased parts.
*   **Organization Code**: (Optional) The inventory org.

## Performance
*   **Efficient**: It uses standard indexing on the cost tables.
*   **Output**: Returns a list of items requiring attention.

## FAQ
**Q: Is Material Overhead mandatory?**
A: No, it depends on your company's costing policy. Some companies expense freight and handling directly to the P&L rather than capitalizing it into inventory.

**Q: Can I use this for OPM?**
A: This report is designed for Discrete Costing. OPM handles overheads through a different mechanism (Cost Factors).

**Q: What if I use Total Value basis?**
A: The report checks for the *existence* of the cost element. If you use Total Value basis, the element should still exist, even if the calculated amount varies.
