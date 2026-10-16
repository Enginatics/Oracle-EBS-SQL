# Case Study & Technical Analysis: CAC Cost vs. Planning Item Controls

## Executive Summary
The **CAC Cost vs. Planning Item Controls** report is a comprehensive diagnostic tool designed to validate the integrity of standard cost rollups. It cross-references item master settings (Make/Buy codes, Asset flags) with Costing controls (Based on Rollup, Lot Size) and Manufacturing data (BOMs, Routings, Sourcing Rules). By identifying conflicting configurations—such as "Make" items with no BOMs, or "Buy" items set to roll up—this report helps prevent zero-cost items, incorrect valuations, and manufacturing variances.

## Business Challenge
In complex manufacturing environments, item attributes often drift out of sync with their physical reality or financial intent. Common issues include:
*   **Incomplete Setups:** A new "Make" item is created but the BOM is missing, leading to a zero standard cost.
*   **Conflicting Flags:** An item is set to "Based on Rollup" but is purchased from a supplier, causing the system to overwrite the purchase price with a calculated (and likely zero) value.
*   **Asset Mismatches:** An item is flagged as an Asset in the Item Master but as an Expense in the Costing table, causing accounting discrepancies.
*   **Lot Size Errors:** Using a Lot Size of 1 for items with Lot-Based resources results in massively inflated unit costs (allocating a full setup charge to a single unit).

## The Solution
This report acts as a "Health Check" for the costing process. It categorizes errors into 12 distinct types, allowing users to systematically fix data quality issues before running the Cost Rollup.
*   **Pre-Rollup Validation:** Running this report *before* a standard cost update prevents "garbage in, garbage out."
*   **Root Cause Analysis:** It pinpoints exactly *why* a cost might be wrong (e.g., "No Routing" vs. "No BOM").
*   **Policy Enforcement:** It ensures that financial policies (e.g., "All Make items must have a BOM") are technically enforced.

## Technical Architecture (High Level)
The report uses a Common Table Expression (CTE) named `rept` to gather all relevant item attributes and existence checks (BOM, Routing, Sourcing Rule) in one pass. It then uses a massive `UNION ALL` structure to classify items into specific error buckets.
*   **Data Gathering (CTE):**
    *   Joins `MTL_SYSTEM_ITEMS_VL`, `CST_ITEM_COSTS`, and `CST_COST_TYPES`.
    *   Performs scalar subqueries to check for the existence of BOMs (`BOM_STRUCTURES_B`), Routings (`BOM_OPERATIONAL_ROUTINGS`), and Sourcing Rules (`MRP_SOURCING_RULES`).
*   **Error Classification (Main Query):**
    *   **Logic:** Each `SELECT` statement in the `UNION ALL` represents a specific business rule violation.
    *   **Example:** `Based on Rollup Yes - No BOMs` selects items where `BASED_ON_ROLLUP_FLAG = 1` AND `PLANNING_MAKE_BUY_CODE = 1` (Make) AND `BOM = 'N'`.

## Parameters & Filtering
*   **Cost Type:** The target cost type to validate (e.g., "Pending" or "Frozen").
*   **Assignment Set:** Required to validate Sourcing Rules correctly.
*   **Category Sets:** Optional filters to focus on specific product lines.
*   **Item/Org/Operating Unit:** Standard filters for scope control.

## Performance & Optimization
*   **CTE Usage:** The `WITH` clause (CTE) is used to calculate the expensive existence checks (BOM/Routing lookups) once per item, rather than repeating them for every error condition.
*   **Scalar Subqueries:** The existence checks use `SELECT DISTINCT ...` with specific `WHERE` clauses to efficiently return 'Y'/'N' (or Organization Code in the latest version) without joining the full tables in the main body.
*   **Indexed Access:** The query relies on standard indexes for `INVENTORY_ITEM_ID` and `ORGANIZATION_ID` across all joined tables.

## FAQ
**Q: Why is "Lot Size 1" a problem?**
A: If you have a Setup resource (e.g., $100 per run) and a Lot Size of 1, the system calculates the unit cost as $100/1 = $100 per unit. If the typical run size is 1000, the unit cost *should* be $0.10. This is a common cause of massive cost overstatements.

**Q: What does "Based on Rollup" mean?**
A: This flag tells the Cost Rollup program, "Do not just copy the cost; calculate it by adding up the BOM and Routing." If this is set to Yes, the system *ignores* any manually entered cost and tries to calculate it.

**Q: Why do I see "Based on Rollup Yes - No Rollup"?**
A: This means the item *should* have rolled up (it's set to Yes), but the rollup process failed to generate a cost, likely because the BOM exists but has no active components, or the components themselves have no cost.

**Q: Can I ignore "Based on Rollup No - With BOMs"?**
A: Technically yes, but it's wasteful. If you have a BOM, you usually want the system to calculate the cost. If you set "Based on Rollup" to No, you are manually maintaining a cost for an item that could be calculated automatically.
