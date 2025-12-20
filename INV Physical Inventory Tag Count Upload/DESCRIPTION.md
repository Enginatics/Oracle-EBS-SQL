# INV Physical Inventory Tag Count Upload - Case Study & Technical Analysis

## Executive Summary
The **INV Physical Inventory Tag Count Upload** is a productivity tool that replaces manual data entry. In a typical physical inventory, thousands of tags are written by hand and then manually keyed into Oracle. This tool allows the counts to be entered into Excel (or captured via scanners into Excel) and then uploaded in bulk.

## Business Challenge
Manual data entry of tag counts is:
-   **Slow:** Typing thousands of numbers takes days.
-   **Error-Prone:** Typographical errors (e.g., entering 100 instead of 10) lead to false variances.
-   **Resource Intensive:** Requires a team of data entry clerks during the critical count weekend.

## Solution
The **INV Physical Inventory Tag Count Upload** streamlines the process. Counters can record data electronically, or data entry clerks can type into a spreadsheet (which is faster than the Oracle Forms UI). The sheet is then uploaded directly to the database.

**Key Features:**
-   **Bulk Entry:** Upload thousands of counts in seconds.
-   **Validation:** Checks for valid Item, Subinventory, Locator, and Lot numbers during upload.
-   **New Tag Creation:** Can create "Dynamic Tags" for items found in locations where they weren't expected.
-   **Void/Unvoid:** Supports voiding tags that were not used.

## Technical Architecture
The tool uses an API or interface table approach to insert data into the physical inventory tag tables.

### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORY_TAGS`**: The table where the counts are stored.
-   **`MTL_PHYSICAL_INVENTORIES`**: The parent inventory record.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item validation.
-   **`MTL_ITEM_LOCATIONS_KFV`**: Locator validation.

### Core Logic
1.  **Data Parsing:** Reads the Excel rows containing Tag Number, Quantity, and Attributes.
2.  **Validation:** Verifies that the tag belongs to the specified physical inventory.
3.  **Update/Insert:** Updates the count on existing tags or inserts new tags if they don't exist (and dynamic tags are allowed).

## Business Impact
-   **Speed:** Reduces the "Data Entry" phase of the physical inventory from days to minutes.
-   **Accuracy:** Eliminates transcription errors if data is captured via barcode scanners into Excel.
-   **Cost Savings:** Reduces overtime costs for data entry staff.
