# INV Item Reservations - Case Study & Technical Analysis

## Executive Summary
The **INV Item Reservations** report details the "hard allocations" of inventory. A reservation guarantees that a specific quantity of an item is held for a specific demand source (like a high-priority Sales Order or a WIP Job) and cannot be used by anyone else. This report is essential for troubleshooting "Available to Promise" (ATP) issues where stock exists physically but the system says "None Available".

## Business Use Cases
*   **Order Fulfillment**: Investigating why a Sales Order is backordered when there is plenty of stock on hand (answer: it's reserved for someone else).
*   **WIP Material Availability**: Ensuring that critical components are reserved for production jobs to prevent line stoppages.
*   **Warehouse Management**: Reservations often lock stock to a specific locator; this report helps find where that stock is.

## Technical Analysis

### Core Tables
*   `MTL_RESERVATIONS`: The primary table storing the reservation link between Supply (Inventory) and Demand (Order/Job).
*   `MTL_DEMAND`: Legacy view often used for reporting.
*   `OE_ORDER_HEADERS_ALL` / `WIP_ENTITIES`: The demand sources.

### Key Joins & Logic
*   **Supply vs. Demand**: The reservation links a `SUPPLY_SOURCE` (On-hand, PO) to a `DEMAND_SOURCE` (Sales Order, Account, Account Alias).
*   **Level**: Reservations can be at the Organization, Subinventory, Locator, or Lot level. High-level reservations (Org level) guarantee quantity but not specific units.

### Key Parameters
*   **Item**: The item to check.
*   **Required Date**: When the material is needed.
*   **Transaction Source Type**: Filter by Sales Order, WIP Job, etc.
