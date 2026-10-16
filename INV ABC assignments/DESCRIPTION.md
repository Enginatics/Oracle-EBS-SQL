# INV ABC assignments - Case Study & Technical Analysis

## Executive Summary
The **INV ABC assignments** report documents the classification of inventory items into ABC classes (A, B, C) based on their value, usage, or frequency. ABC analysis is a standard supply chain technique where 'A' items are high-value/high-priority, and 'C' items are low-value. This report shows which class each item has been assigned to, which drives cycle counting frequencies and inventory control policies.

## Business Use Cases
*   **Cycle Count Planning**: Verifies that high-value ('A') items are assigned to frequent count schedules (e.g., monthly) while low-value ('C') items are counted less often (e.g., annually).
*   **Inventory Policy Review**: Helps managers analyze if the current ABC thresholds are appropriate (e.g., "Are too many items falling into Class A?").
*   **Stocking Strategy**: 'A' items might be stocked in more secure or accessible locations; this report helps validate those location assignments.
*   **Obsolete Inventory Identification**: Items that have moved from 'A' to 'C' (or 'D') over time may be candidates for obsolescence review.

## Technical Analysis

### Core Tables
*   `MTL_ABC_ASSIGNMENTS`: The table linking an item to an ABC class within an assignment group.
*   `MTL_ABC_CLASSES`: Defines the classes (A, B, C, etc.).
*   `MTL_ABC_ASSIGNMENT_GROUPS`: Defines the group (e.g., "Cycle Count Group", "Planning Group").
*   `MTL_ABC_COMPILES`: Stores the compilation header that calculated the ABC values.

### Key Joins & Logic
*   **Assignment Logic**: The query joins `MTL_ABC_ASSIGNMENTS` to `MTL_SYSTEM_ITEMS` (via `INVENTORY_ITEM_ID`) and `MTL_ABC_CLASSES` (via `ABC_CLASS_ID`).
*   **Group Context**: Assignments are always within the context of an `ASSIGNMENT_GROUP_ID`. An item can be Class 'A' for Cycle Counting but Class 'B' for Planning.
*   **Scope**: Filters by Organization, as ABC analysis is organization-specific.

### Key Parameters
*   **ABC Group**: The specific assignment group to report on.
*   **Sort Option**: Sort by Item, Class, or Value.
