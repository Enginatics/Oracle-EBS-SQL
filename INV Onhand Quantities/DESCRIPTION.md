# INV Onhand Quantities - Case Study & Technical Analysis

## Executive Summary
The **INV Onhand Quantities** report is the definitive "Stock Status" report for Oracle Inventory. It provides a detailed snapshot of exactly what is in the warehouse right now. Unlike simple stock lists, this report exposes the rich attributes of on-hand inventory, including Lot numbers, Serial numbers, Reservations, LPNs (License Plates), and Statuses.

## Business Challenge
Knowing "we have 100 units" is rarely enough. Operations teams need to know:
-   **Availability:** "We have 100, but how many are already reserved for other orders?"
-   **Location:** "Which specific bin are they in?"
-   **Quality:** "Are any of them expired or on Quality Hold?"
-   **Traceability:** "Do we have the specific serial number the customer is asking for?"

## Solution
The **INV Onhand Quantities** report provides a multi-dimensional view of stock. It joins the core quantity tables with all the attribute tables to provide a complete picture of inventory health.

**Key Features:**
-   **Granularity:** Shows stock at the Subinventory, Locator, Lot, and Serial level.
-   **Availability Calculation:** Displays "Quantity on Hand" vs. "Quantity Available to Transact" (Onhand - Reserved).
-   **Attribute Visibility:** Includes Expiration Dates, Material Status, and Cost Group information.

## Technical Architecture
The report queries the live on-hand balance tables, which are the most critical and heavily indexed tables in the Inventory schema.

### Key Tables and Views
-   **`MTL_ONHAND_QUANTITIES_DETAIL`**: The primary table storing current stock balances.
-   **`MTL_RESERVATIONS`**: Used to calculate the "Reserved" quantity.
-   **`MTL_LOT_NUMBERS`**: Lot attributes.
-   **`MTL_SERIAL_NUMBERS`**: Serial attributes.
-   **`WMS_LICENSE_PLATE_NUMBERS`**: Container (LPN) details.

### Core Logic
1.  **Balance Retrieval:** Selects from `MTL_ONHAND_QUANTITIES_DETAIL`.
2.  **Reservation Netting:** Subqueries `MTL_RESERVATIONS` to determine how much of that stock is hard-allocated.
3.  **Status Check:** Checks `MTL_MATERIAL_STATUSES` to see if the stock is transactable.
4.  **Costing:** Can join to `CST_ITEM_COSTS` to provide the value of the on-hand stock.

## Business Impact
-   **Customer Service:** Enables accurate promising of orders by showing true availability.
-   **Warehouse Efficiency:** Reduces "search time" by pinpointing exact locations.
-   **Waste Reduction:** Helps identify expiring lots before they become unsalable.
