# INV Item Default Transaction Subinventories - Case Study & Technical Analysis

## Executive Summary
The **INV Item Default Transaction Subinventories** report lists the default subinventory assigned to an item. Similar to the Locator report, this defines the "Home" subinventory for an item. It is used to restrict where an item can be transacted or to provide a default value during receiving and miscellaneous transactions.

## Business Use Cases
*   **Putaway Logic**: Defines the primary storage area for an item (e.g., "Cold Storage" vs. "Dry Goods").
*   **Transaction Control**: Can be used in conjunction with "Restrict Subinventories" flag on the Item Master to prevent users from putting items in the wrong place.
*   **Min-Max Planning**: Often used to define which subinventory is replenished for a specific item.

## Technical Analysis

### Core Tables
*   `MTL_ITEM_SUB_DEFAULTS`: The table storing the default subinventory code for an item.
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

### Key Joins & Logic
*   **Organization Specific**: Defaults are specific to an Inventory Organization.
*   **Relationship**: This is a simple 1:Many relationship (One Item can have defaults in multiple Orgs, but usually one default per Org/Type).

### Key Parameters
*   **Item**: Filter for a specific item.
*   **Subinventory**: Filter for a specific subinventory.
