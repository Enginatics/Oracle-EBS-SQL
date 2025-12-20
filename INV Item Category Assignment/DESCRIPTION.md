# INV Item Category Assignment - Case Study & Technical Analysis

## Executive Summary
The **INV Item Category Assignment** report provides a detailed listing of which items are assigned to which categories within a specific Category Set. Since an item can belong to multiple category sets (e.g., one for Sales, one for Purchasing, one for Planning), this report allows users to view the specific assignments for a targeted purpose.

## Business Use Cases
*   **Catalog Management**: Used to review and clean up item classifications (e.g., "Show me all items in the 'Electronics' category").
*   **New Item Setup Verification**: Ensures that new items have been assigned to the correct categories, which often drives account derivation and reporting.
*   **Sourcing Analysis**: Procurement teams use this to group items by purchasing category to analyze spend.

## Technical Analysis

### Core Tables
*   `MTL_ITEM_CATEGORIES`: The intersection table linking Items to Categories.
*   `MTL_CATEGORIES_B`: The category definitions.
*   `MTL_CATEGORY_SETS_B`: The category set definitions.
*   `MTL_SYSTEM_ITEMS_B`: The item master.

### Key Joins & Logic
*   **Category Set Context**: The query MUST filter by `CATEGORY_SET_ID`. Without this, the results would be a meaningless mix of different classification schemes.
*   **Organization Context**: Category assignments can be Master Level (same for all orgs) or Org Level (specific to an org). The report respects this control level.

### Key Parameters
*   **Category Set**: The specific classification scheme to report on (Mandatory).
*   **Category From/To**: Range of categories to include.
*   **Item From/To**: Range of items.
