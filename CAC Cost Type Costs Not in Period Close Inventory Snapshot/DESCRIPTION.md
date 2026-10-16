# Case Study & Technical Analysis: CAC Cost Type Costs Not in Period Close Inventory Snapshot

## Executive Summary
The **CAC Cost Type Costs Not in Period Close Inventory Snapshot** report is a reconciliation and audit tool designed to identify discrepancies between the official period-end inventory records and a target Cost Type (such as "Frozen" or "Pending"). Specifically, it finds items that held inventory balances at the time of period close but are completely missing a cost definition in the specified Cost Type. This is critical for ensuring that all inventory is properly valued and that there are no "uncosted" items lurking in the system which could lead to zero-value transactions or margin errors.

## Business Challenge
In Oracle EBS, inventory value at period end is captured in a snapshot table (`CST_PERIOD_CLOSE_SUMMARY`). However, organizations often maintain multiple Cost Types (e.g., Frozen for standard costing, Pending for future updates, or simulation types). A common issue arises when:
*   **New Items:** Items are received and transacted but the finance team hasn't yet defined a standard cost in the "Frozen" cost type.
*   **Cost Type Synchronization:** A simulation or "Pending" cost type is being prepared for a standard cost update, but it doesn't contain all the items that currently have on-hand balances.
*   **Zero Value Risk:** If an item has quantity but no cost record, it effectively has a zero value, which distorts financial reporting and profit margins.

## The Solution
This report solves these problems by:
*   **Snapshot Comparison:** It looks at the *actual* period-end snapshot (what was physically/logically on hand when the period closed).
*   **Gap Analysis:** It compares this snapshot against a user-selected Cost Type to find missing cost records.
*   **Asset Focus:** It automatically filters out expense items, focusing only on asset inventory that impacts the balance sheet.
*   **Valuation Impact:** It displays the on-hand quantity and the *snapshot* value (based on the cost at the time of the snapshot), allowing users to assess the materiality of the missing costs.

## Technical Architecture (High Level)
The report employs a "Set Difference" logic using a `NOT EXISTS` clause to identify the gaps.
*   **Primary Source (The "Left" Side):** An aggregated view of `CST_PERIOD_CLOSE_SUMMARY` (joined with `ORG_ACCT_PERIODS` and `MTL_SYSTEM_ITEMS_VL`). This represents the "truth" of what was on hand at period close.
*   **Comparison Target (The "Right" Side):** `CST_ITEM_COSTS` filtered by the user's chosen Cost Type parameter.
*   **The Filter:** The query selects items from the Primary Source where a corresponding record does *not exist* in the Comparison Target.

## Parameters & Filtering
*   **Period Name (Closed):** The inventory accounting period to analyze (must be closed to have a snapshot).
*   **Cost Type:** The cost type to check against (e.g., "Frozen", "Pending", "FY2024 Standard").
*   **Item Number:** Optional filter for specific items.
*   **Organization Code:** Filter by specific inventory organization.

## Performance & Optimization
*   **Pre-Aggregated Data:** By using `CST_PERIOD_CLOSE_SUMMARY`, the report avoids summing up millions of individual transactions (`MTL_MATERIAL_TRANSACTIONS`), making it extremely fast even for large databases.
*   **Efficient Filtering:** The inner query filters out zero-quantity records early, reducing the volume of data processed in the main join.
*   **Indexed Lookups:** The `NOT EXISTS` check against `CST_ITEM_COSTS` leverages standard indexes on `INVENTORY_ITEM_ID` and `COST_TYPE_ID`.

## FAQ
**Q: Why does this report require a closed period?**
A: The table `CST_PERIOD_CLOSE_SUMMARY` is only populated by the "Period Close" process. If the period is open, this table may not contain up-to-date data for that period.

**Q: What does "Rollback Value" mean?**
A: In the context of the period close summary, "Rollback" refers to the quantity and value calculated back to the period end date. However, since this table *is* the snapshot, it represents the static value at that point in time.

**Q: Does this report show items with Zero Cost?**
A: No, it shows items with *No Cost Record*. An item with a cost record of $0.00 is technically "costed" (at zero). This report finds items that are completely missing from the `CST_ITEM_COSTS` table for the selected Cost Type.

**Q: Can I use this for Average Costing?**
A: Yes, but in Average Costing, the "Cost Type" concept is less fluid than in Standard Costing. You would typically compare against the "Average" cost type to ensure integrity, though the system usually enforces cost creation automatically in Average Costing. This is most useful for Standard Costing environments.
