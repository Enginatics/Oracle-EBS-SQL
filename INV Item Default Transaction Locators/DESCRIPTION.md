# INV Item Default Transaction Locators - Case Study & Technical Analysis

## Executive Summary
The **INV Item Default Transaction Locators** report documents the default physical locations (Locators) assigned to items for specific transaction types (Shipping, Receiving, Move Order Receipt). Setting these defaults automates warehouse processes by pre-populating the locator field during transactions, reducing data entry errors and speeding up receiving and picking.

## Business Use Cases
*   **Receiving Efficiency**: Ensures that when the dock team receives "Item A", the system automatically suggests "Bin B-01" as the putaway location.
*   **Picking Optimization**: Defines the primary pick face for an item.
*   **Warehouse Reorganization**: Used as a baseline export before performing a mass update of default locations during a warehouse layout change.

## Technical Analysis

### Core Tables
*   `MTL_ITEM_LOC_DEFAULTS`: The table storing the default locator ID for a given item and subinventory.
*   `MTL_ITEM_LOCATIONS_KFV`: The locator definitions (Row, Rack, Bin).
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

### Key Joins & Logic
*   **Scope**: Defaults are defined at the Item + Subinventory level.
*   **Type**: The `DEFAULT_TYPE` column indicates the purpose (e.g., 1=Shipping, 2=Receiving).
*   **Hierarchy**: These defaults are often overridden by more specific rules (like WMS Rules Engine), but serve as the base logic for standard Inventory organizations.

### Key Parameters
*   **Item**: Filter for a specific item.
*   **Subinventory**: Filter for a specific area.
