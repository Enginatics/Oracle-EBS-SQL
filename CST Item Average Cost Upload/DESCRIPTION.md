# Executive Summary
The **CST Item Average Cost Upload** is a utility for mass-updating item costs in an Average Costing organization. In Average Costing environments, costs are typically recalculated automatically by the system based on transactions (PO Receipts, WIP Completions). However, manual adjustments are sometimes necessary (e.g., to correct data entry errors, revalue inventory, or initialize costs). This tool replaces the manual "Average Cost Update" form with an Excel-based bulk loader.

# Business Challenge
*   **Manual Effort**: Updating average costs one by one in the Oracle forms is slow and error-prone.
*   **Cost Corrections**: If a PO was received at the wrong price, it skews the average cost. Correcting this requires a calculated adjustment.
*   **Initial Load**: When migrating to Oracle, thousands of items need their initial average cost set.

# Solution
This tool allows users to download current average costs, modify them in Excel, and upload the changes.

**Key Features:**
*   **Modes**: "Create" (blank template) or "Create, Update" (download existing data).
*   **Granularity**: Supports updates at the Summary Item level or the Detailed Elemental level (Material, Resource, etc.).
*   **Adjustment Types**:
    *   **New Average Cost**: Set the cost to a specific value.
    *   **Percentage Change**: Increase/decrease by X%.
    *   **Value Change**: Adjust the total inventory value (system recalculates unit cost).
*   **Account Override**: Allows specifying a specific Adjustment Account (GL) for the revaluation entry.

# Architecture
The upload likely interfaces with the Oracle Inventory/Costing APIs to process the adjustments, similar to the `MTL_TRANSACTIONS_INTERFACE` or specific Costing APIs.

**Key Concepts:**
*   **Average Costing**: A costing method where the unit cost is a weighted average of the value of on-hand inventory.
*   **Revaluation**: Changing the cost of an item while it is on-hand triggers a revaluation entry to the GL.

# Impact
*   **Data Accuracy**: Ensures average costs reflect the true value of inventory.
*   **Productivity**: Reduces the time required for cost corrections from days to minutes.
*   **Flexibility**: Handles complex elemental cost adjustments that are difficult to calculate manually.
