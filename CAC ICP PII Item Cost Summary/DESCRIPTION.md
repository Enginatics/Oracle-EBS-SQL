# Case Study & Technical Analysis: CAC ICP PII Item Cost Summary

## Executive Summary
The **CAC ICP PII Item Cost Summary** report is a specialized costing tool designed to provide transparency into the composition of item costs, specifically isolating the **Intercompany Profit (ICP)** or **Profit in Inventory (PII)** component. While standard cost reports show the total value, this report breaks down the cost into "Gross Cost," "Profit Portion," and "Net Cost" (True Manufacturing Cost). This is essential for transfer pricing analysis and validating that profit margins are correctly embedded in the standard costs.

## Business Challenge
In multi-entity supply chains, items are often transferred between subsidiaries at a markup. The receiving organization sees this markup as part of their standard material cost.
*   **Visibility Gap:** Standard Oracle reports show the total cost (e.g., $110) but don't easily show how much of that is the original manufacturing cost ($100) vs. the intercompany markup ($10).
*   **Validation:** Finance teams need to verify that the profit amount (PII) stored in the system matches the agreed-upon transfer pricing policy.
*   **Audit Compliance:** Auditors require proof that the profit elimination calculations are based on accurate per-unit profit data.

## The Solution
This report solves the visibility gap by performing a dual-lookup for every item:
1.  **Standard Cost Retrieval:** It pulls the standard cost components (Material, Overhead, Resource, etc.) from the primary Cost Type.
2.  **Profit Isolation:** It simultaneously queries a specific "PII Cost Type" or looks for a specific "PII Sub-Element" to quantify the profit portion.
3.  **Net Cost Calculation:** It mathematically derives the Net Cost (Gross Cost - Profit) to show the underlying value of the inventory.

## Technical Architecture (High Level)
The query is a direct join against the Item Master and Costing tables, with a specific sub-query logic for PII.
*   **Primary Data Source:** `CST_ITEM_COSTS` (CIC) provides the main standard cost data.
*   **Profit Logic:** A correlated sub-query against `CST_ITEM_COST_DETAILS` (CICD) is used to fetch the specific value associated with the `PII Cost Type` and `PII Sub-Element`.
*   **Item Master Context:** Joins to `MTL_SYSTEM_ITEMS_VL` and various lookup tables provide context like Make/Buy codes, Item Status, and Category assignments.

## Parameters & Filtering
*   **Cost Type:** The primary cost type to report (usually "Frozen" or "Standard").
*   **PII Cost Type:** The specific cost type where the profit component is stored (or the cost type used for the sub-element lookup).
*   **PII Sub-Element:** The specific material overhead or resource sub-element that represents the profit (e.g., "ICP").
*   **Include Uncosted Items:** A flag to include items that exist in the item master but have zero cost, useful for identifying missing cost setups.
*   **Include Inactive Items:** Allows reporting on obsolete items that may still have residual inventory value.

## Performance & Optimization
*   **Efficient Joins:** The query uses standard joins between `CST_ITEM_COSTS` and `MTL_SYSTEM_ITEMS_B`, which are indexed and highly optimized in Oracle EBS.
*   **Scalar Sub-query:** The PII calculation is handled via a scalar sub-query in the SELECT clause, which is generally efficient when fetching a single aggregated value per row.

## FAQ
**Q: What if my profit is not stored in a specific sub-element?**
A: This report is designed for the common configuration where profit is tracked as a distinct cost element (usually Material Overhead). If profit is just "baked in" to the material cost without a separate tag, this report cannot isolate it without a reference "True Cost" cost type to compare against.

**Q: Can I use this for "What-If" analysis?**
A: Yes. By pointing the "Cost Type" parameter to a simulation cost type (e.g., "Pending"), you can see what the PII values *will be* after a cost update.

**Q: Why do I see "Net Item Cost"?**
A: Net Item Cost = Total Standard Cost - PII Amount. This represents the cost to the consolidated entity (the group), stripping out the internal artificial profit.
