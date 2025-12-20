# INV Physical Inventory Tags - Case Study & Technical Analysis

## Executive Summary
The **INV Physical Inventory Tags** report is the operational document used during the counting process. It generates the physical "Tags" (cards or stickers) that are placed on the goods in the warehouse. These tags are the primary control mechanism to ensure every item is counted exactly once.

## Business Challenge
A physical inventory without tags is chaotic.
-   **Double Counting:** Without a tag, two different teams might count the same pallet.
-   **Missed Items:** Without a tag left on the shelf, it's hard to know if a section has been counted.
-   **Data Entry:** Counters need a document to write the quantity on.

## Solution
The **INV Physical Inventory Tags** report prints the generated tags. It can be run after the "Generate Physical Inventory Tags" program.

**Key Features:**
-   **Pre-Printed Info:** Prints the Item, Description, Subinventory, Locator, Lot, and Serial (if known) on the tag.
-   **Blank Tags:** Can print blank tags for "Dynamic" counts (items found in unexpected places).
-   **Sorting:** Tags are usually sorted by Subinventory and Locator to match the walking path of the counters.

## Technical Architecture
The report queries the tag table which is populated by the "Generate Physical Inventory Tags" snapshot process.

### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORY_TAGS`**: The master list of tags generated for the inventory.
-   **`MTL_PHYSICAL_INVENTORIES`**: The parent inventory record.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item descriptions.

### Core Logic
1.  **Retrieval:** Selects tags for the specified Physical Inventory ID.
2.  **Formatting:** Formats the output to be suitable for printing on card stock or sticker paper (often requires BI Publisher layout customization).
3.  **Sorting:** Orders the output by location to facilitate distribution.

## Business Impact
-   **Control:** The physical tag is the legal record of the count.
-   **Efficiency:** Pre-printing known information speeds up the counting process (counters only need to write the quantity).
-   **Organization:** Ensures a structured and systematic counting process.
