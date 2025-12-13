# Executive Summary
The **CST Inventory Value - Multi-Organization (Element Costs) 11i** report is a powerful inventory valuation tool designed for multi-org environments. It calculates the value of on-hand inventory as of a specific date (historical or current), broken down by Cost Element (Material, Labor, Overhead, etc.). This "Element" view is crucial for financial reporting, as it allows the inventory balance to be split into its raw material content vs. value-added content (labor/overhead).

# Business Challenge
Standard inventory reports often just give a total value. However, finance needs more detail:
*   **Capitalization**: "How much of our inventory value is capitalized labor and overhead?"
*   **Reconciliation**: Reconciling the GL inventory account requires knowing the split between different sub-accounts (if Material and Overhead are booked to different GL codes).
*   **Multi-Org Analysis**: Aggregating values across multiple warehouses (Organizations) usually requires running separate reports and merging them manually.

# Solution
This report provides a unified view of inventory value across multiple organizations, summarized by Cost Element.

**Key Features:**
*   **As-Of Date Reporting**: Can rollback inventory quantities and costs to show the value at a past point in time (e.g., last month-end).
*   **Cost Element Pivot**: Presents data with columns for Material, Material Overhead, Resource, OSP, and Overhead.
*   **Subinventory Detail**: Can drill down to the subinventory level to value specific storage locations (e.g., "FGI" vs. "Stores").

# Architecture
The report uses a complex logic (often involving temporary tables `CST_INV_QTY_TEMP` and `CST_INV_COST_TEMP`) to calculate the "As-Of" quantity by taking current on-hand and reversing transactions back to the target date. It then applies the item cost.

**Key Tables:**
*   `MTL_ONHAND_QUANTITIES`: Current stock.
*   `MTL_MATERIAL_TRANSACTIONS`: History of moves (used for rollback).
*   `CST_ITEM_COSTS`: Unit costs.
*   `CST_ITEM_COST_DETAILS`: Cost element breakdown.

# Impact
*   **Financial Reporting**: Provides the detailed data needed for the "Inventory" note in the financial statements.
*   **Audit Support**: Allows for the precise validation of inventory balances at any historical date.
*   **Operational Insight**: Helps identify organizations holding excessive amounts of value-added inventory (WIP/Finished Goods) vs. Raw Materials.
