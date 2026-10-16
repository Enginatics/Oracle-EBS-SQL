# Executive Summary
The **CST Inventory Value Report - by Subinventory (Item Cost)** is a direct extraction of the standard Oracle "Inventory Value Report - by Subinventory". It provides a valuation of on-hand inventory, grouped and subtotaled by Subinventory (storage location). This view is essential for warehouse managers and cost accountants who need to validate the value of goods in specific physical areas (e.g., "Finished Goods" vs. "Raw Materials" vs. "Quarantine").

# Business Challenge
While the General Ledger shows the total inventory balance, it doesn't explain *where* that value sits physically.
*   **Location Analysis**: "Why is the value in the 'Scrap' subinventory so high?"
*   **Account Reconciliation**: Different subinventories often map to different GL asset accounts. This report helps reconcile those specific sub-ledger accounts.
*   **Audit**: Auditors often select specific subinventories for physical counts and valuation testing.

# Solution
This report lists items and their values within each subinventory.

**Key Features:**
*   **Subinventory Grouping**: The primary sort key is the Subinventory, allowing for easy subtotaling.
*   **Cost Type Flexibility**: Can report based on Frozen (Standard) costs or other simulation cost types.
*   **Granularity**: Shows Quantity, Unit Cost, and Total Value for each item.

# Architecture
This is a Blitz Report import of the standard Oracle XML Publisher report `CSTRINVR_XML`. It uses the package `BOM_CSTRINVR_XMLP_PKG`.

**Key Tables:**
*   `MTL_SECONDARY_INVENTORIES`: Defines the subinventories.
*   `CST_INV_QTY_TEMP`: Calculates on-hand quantities.
*   `CST_ITEM_COSTS`: Retrieves unit costs.
*   `MTL_SYSTEM_ITEMS_VL`: Item details.

# Impact
*   **Asset Protection**: Helps identify high-value items sitting in unsecured or inappropriate subinventories.
*   **Financial Accuracy**: Supports the detailed reconciliation of inventory GL accounts.
*   **Operational Control**: Provides visibility into the distribution of inventory value across the warehouse layout.
