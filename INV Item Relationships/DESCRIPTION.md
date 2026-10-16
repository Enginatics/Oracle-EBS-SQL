# INV Item Relationships - Case Study & Technical Analysis

## Executive Summary
The **INV Item Relationships** report documents the functional links between items. In Oracle Inventory, items can be related for various purposes: Substitutes (if A is out, ship B), Cross-Sells (if buying A, suggest B), Up-Sells, or Service Items (Warranty for Item A). This report is crucial for validating these setups, which directly impact Order Management and Planning.

## Business Use Cases
*   **Substitute Management**: Verifies that discontinued items have valid substitutes defined so orders don't get stuck.
*   **Sales Effectiveness**: Audits the "Cross-Sell" and "Up-Sell" relationships used by the telesales team.
*   **Spare Parts Mapping**: Documents which service parts belong to which finished goods.

## Technical Analysis

### Core Tables
*   `MTL_RELATED_ITEMS`: The table storing the relationship (Item A -> Item B, Relationship Type).
*   `MTL_SYSTEM_ITEMS_VL`: Item details for both the "From" and "To" items.

### Key Joins & Logic
*   **Directionality**: Relationships can be one-way or reciprocal. The report typically shows the "From" item and the "To" item.
*   **Effectiveness**: Relationships have start and end dates; the report can filter for currently active links.

### Key Parameters
*   **Item**: Filter for a specific item.
*   **Organization Code**: Relationships are organization-specific.
