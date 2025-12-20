# INV Transaction Register - Case Study & Technical Analysis

## Executive Summary
The **INV Transaction Register** is the most detailed audit report in Oracle Inventory. It lists every single material movement (Receipt, Issue, Transfer, Adjustment) within a specified date range. It is the "Bank Statement" for the warehouse, showing every debit and credit to the stock.

## Business Challenge
When inventory numbers don't add up, high-level summaries aren't enough. You need the raw details.
-   **Forensics:** "Who moved this stock? When? And why?"
-   **Traceability:** "Where did Lot #123 go? Did it ship to Customer A or Customer B?"
-   **Reconciliation:** "The GL shows a $500 variance. Which specific transaction caused it?"

## Solution
The **INV Transaction Register** provides a line-by-line listing of `MTL_MATERIAL_TRANSACTIONS`. It includes all the "Who, What, Where, When, Why" details.

**Key Features:**
-   **Comprehensive:** Includes PO Receipts, WIP Issues, Sales Order Shipments, and Miscellaneous Transactions.
-   **Attribute Rich:** Shows Lot Numbers, Serial Numbers, Reason Codes, and Reference fields.
-   **Source Linkage:** Links the transaction back to the source document (e.g., PO Number, Sales Order Number).

## Technical Architecture
The report is a direct dump of the transaction history table, often joined with 10+ other tables to resolve IDs to names.

### Key Tables and Views
-   **`MTL_MATERIAL_TRANSACTIONS`**: The core transaction table.
-   **`MTL_TRANSACTION_TYPES`**: Defines the action (e.g., "PO Receipt").
-   **`MTL_UNIT_TRANSACTIONS`**: Serial number details.
-   **`MTL_TRANSACTION_LOT_NUMBERS`**: Lot number details.

### Core Logic
1.  **Filtering:** Selects transactions based on Date Range, Item, and Transaction Type.
2.  **Joins:** Joins to `PO_HEADERS_ALL`, `OE_ORDER_HEADERS_ALL`, `WIP_ENTITIES` to get the source document numbers.
3.  **Detailing:** If requested, joins to the Lot and Serial tables to show the specific units moved.

## Business Impact
-   **Loss Prevention:** The first place to look when investigating theft or unexplained shrinkage.
-   **Quality Control:** Traces the movement of potentially defective lots.
-   **Operational Visibility:** Provides a granular view of warehouse activity for any given period.
