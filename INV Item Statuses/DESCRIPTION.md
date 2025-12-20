# INV Item Statuses - Case Study & Technical Analysis

## Executive Summary
The **INV Item Statuses** report is a configuration audit document for the "Item Status" codes (e.g., Active, Inactive, Obsolete, Prototype). In Oracle, the Status controls a set of functional flags (Is it Stockable? Is it Purchasable? Is it Orderable?). This report lists these definitions, ensuring that an "Obsolete" item, for example, is correctly blocked from being purchased or sold.

## Business Use Cases
*   **Lifecycle Management**: Verifies that the "End of Life" status correctly disables all transaction flags to prevent accidental use.
*   **New Product Introduction (NPI)**: Ensures that "Prototype" items are transactable in Engineering but not visible to Sales.
*   **Master Data Governance**: Audits the consistency of status rules across the enterprise.

## Technical Analysis

### Core Tables
*   `MTL_ITEM_STATUS_VL`: The header definition of the status code.
*   `MTL_STAT_ATTRIB_VALUES_ALL_V`: The values of the individual attributes (flags) for that status.

### Key Joins & Logic
*   **Attribute Control**: The report shows the state of key attributes like `STOCK_ENABLED_FLAG`, `PURCHASING_ENABLED_FLAG`, `CUSTOMER_ORDER_ENABLED_FLAG`.
*   **Pending Changes**: Some versions of this report may show pending status changes (future dated).

### Key Parameters
*   **Display Style**: How to format the output.
