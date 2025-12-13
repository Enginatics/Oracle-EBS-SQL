# Case Study & Technical Analysis: CAC Item vs. Component Include in Rollup Controls

## Executive Summary
The **CAC Item vs. Component Include in Rollup Controls** report is a specialized diagnostic tool for the Cost Rollup process. It identifies a specific configuration conflict: items where the "Include in Rollup" flag on the Item Master contradicts the settings on the Bill of Materials (BOM). This mismatch is a common cause of incorrect standard costs.

## Business Challenge
The Cost Rollup process relies on clear instructions: "Should I calculate the cost of this sub-assembly?"
*   **The Conflict**: The Item Master says "Yes, roll me up," but the BOM Component line says "No, don't include me."
*   **The Result**: The system might skip the item during the rollup, resulting in a zero cost or an outdated cost for the parent assembly.
*   **Root Cause**: Often happens when items are copied or when engineering changes (ECOs) are applied inconsistently.

## Solution
This report finds the contradictions.
*   **Logic**: It looks for items where `mtl_system_items.default_include_in_rollup_flag` does not match the effective component usage in `bom_components_b`.
*   **Scope**: Focuses on "Make" items and active BOMs.
*   **Actionable**: The output provides a "To Do" list for the Cost Accountant or Master Data team to align the settings.

## Technical Architecture
The report joins the Item Master to the BOM structure:
*   **Tables**: `mtl_system_items`, `bom_structures_b`, `bom_components_b`.
*   **Filter**: It specifically looks for the condition where the flags differ.
*   **Context**: Includes Cost Type and Category information to help prioritize the fix.

## Parameters
*   **Cost Type**: (Mandatory) The cost type being analyzed.
*   **Organization Code**: (Optional) The manufacturing org.

## Performance
*   **Targeted**: Because it filters for a specific error condition, the output is usually small and the report runs quickly.
*   **Complex Join**: It does traverse the BOM hierarchy, so it's more complex than a simple item list.

## FAQ
**Q: Which setting wins?**
A: The Cost Rollup generally respects the *Component* flag when rolling up a specific structure, but the *Item* flag controls whether the item *itself* is selected for rollup. A mismatch creates ambiguity and unexpected results.

**Q: Should they always match?**
A: In 99% of cases, yes. If an item is a phantom or a sub-assembly that needs costing, both flags should be consistent.

**Q: Does this fix the data?**
A: No, it is a reporting tool. You must manually update the Item Master or the BOM to resolve the conflict.
