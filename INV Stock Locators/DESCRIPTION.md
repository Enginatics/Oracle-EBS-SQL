# INV Stock Locators - Case Study & Technical Analysis

## Executive Summary
The **INV Stock Locators** report is a warehouse layout document. It lists all the defined storage locations (Locators) within the subinventories. It includes critical attributes like dimensions, weight capacities, and picking order. This report is essential for warehouse mapping and capacity planning.

## Business Challenge
A warehouse is a physical space that needs to be mapped digitally.
-   **Capacity Planning:** "Do we have enough empty bins to receive the incoming shipment?"
-   **Route Optimization:** "Are the bins numbered in a way that makes sense for a picker walking the aisle?"
-   **Status Control:** "Which bins are damaged and should be blocked from use?"

## Solution
The **INV Stock Locators** report provides a complete list of valid addresses in the warehouse. It exposes the configuration details of each bin.

**Key Features:**
-   **Address Breakdown:** Shows the segments of the locator (e.g., Aisle-Row-Bin-Level).
-   **Physical Constraints:** Lists the max weight, volume, and dimensions of the bin.
-   **Operational Flags:** Shows the Picking Order (sequence) and Status (Active/Inactive).

## Technical Architecture
The report queries the locator definition table.

### Key Tables and Views
-   **`MTL_ITEM_LOCATIONS`**: The table storing the locator definitions.
-   **`MTL_SECONDARY_INVENTORIES`**: The subinventory the locator belongs to.
-   **`MTL_MATERIAL_STATUSES`**: The status of the locator (e.g., "Quarantine").

### Core Logic
1.  **Retrieval:** Selects from `MTL_ITEM_LOCATIONS` (often joined with `MTL_ITEM_LOCATIONS_KFV` for the concatenated segments).
2.  **Filtering:** Can filter by Subinventory, Locator Type, or Status.
3.  **Sorting:** Usually sorted by Subinventory and then Picking Order.

## Business Impact
-   **Warehouse Optimization:** Used to analyze and optimize the picking path (by adjusting the Picking Order field).
-   **Space Management:** Helps identify underutilized or over-utilized areas of the warehouse.
-   **Master Data Management:** Ensures the digital map matches the physical labels on the racks.
