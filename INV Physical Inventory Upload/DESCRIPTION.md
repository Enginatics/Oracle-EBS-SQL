# INV Physical Inventory Upload - Case Study & Technical Analysis

## Executive Summary
The **INV Physical Inventory Upload** is a setup and maintenance tool for the physical inventory process. It allows users to create the "Header" definition of a physical inventory and assign subinventories to it in bulk. This is particularly useful for large organizations that run multiple physical inventories simultaneously or have hundreds of subinventories to assign.

## Business Challenge
Setting up a physical inventory in Oracle involves:
1.  Defining the name and date.
2.  Manually selecting which subinventories are included.
3.  Freezing the inventory (taking the snapshot).
Doing this manually for 50 warehouses is tedious and prone to setup errors (e.g., forgetting to include the "Returns" subinventory).

## Solution
The **INV Physical Inventory Upload** automates the definition phase. Users can define the scope of the count in Excel and upload it.

**Key Features:**
-   **Header Creation:** Creates the Physical Inventory definition (Name, Date, Org).
-   **Scope Definition:** Assigns specific subinventories to the count.
-   **Snapshot Trigger:** Can optionally trigger the "Freeze" process immediately after upload.
-   **Update Mode:** Can update existing definitions (e.g., adding a missed subinventory) before the freeze.

## Technical Architecture
The tool interacts with the physical inventory definition tables and submits concurrent requests.

### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORIES`**: The header table.
-   **`MTL_PHYSICAL_SUBINVENTORIES`**: The table linking subinventories to the physical inventory.
-   **`MTL_PARAMETERS`**: Organization validation.

### Core Logic
1.  **Upload:** Reads the configuration from Excel.
2.  **Creation:** Inserts records into `MTL_PHYSICAL_INVENTORIES` and `MTL_PHYSICAL_SUBINVENTORIES`.
3.  **Process Submission:** If "Freeze" is selected, it submits the `INV_PHY_INV_SNAPSHOT` concurrent program.

## Business Impact
-   **Standardization:** Ensures all warehouses are set up with consistent naming conventions and parameters.
-   **Completeness:** Reduces the risk of missing subinventories during the count.
-   **Efficiency:** Allows a central inventory team to set up counts for remote sites without logging into each org individually.
