# INV Item Supply-Demand - Case Study & Technical Analysis

## Executive Summary
The **INV Item Supply-Demand** report is the most comprehensive view of an item's availability. It replicates the logic of the "Supply/Demand" form in Oracle Inventory. It lists **all** incoming supply (On-hand, Approved POs, WIP Jobs, In-transit Shipments) and **all** outgoing demand (Sales Orders, WIP Requirements, Reservations) to calculate the net "Available to Promise" (ATP) quantity over time.

## Business Use Cases
*   **Shortage Analysis**: The first place a planner looks when an item is short. It answers "When is the next PO arriving?" and "Who is consuming the stock?".
*   **ATP Verification**: Validates the system's promise date to customers.
*   **Excess Inventory**: Identifies items where Supply far exceeds Demand.

## Technical Analysis

### Core Tables
*   `MTL_SUPPLY_DEMAND_TEMP`: This is a special temporary table. The report logic (or the form) populates this table on-the-fly by querying `PO_HEADERS_ALL`, `OE_ORDER_LINES_ALL`, `WIP_REQUIREMENT_OPERATIONS`, `MTL_ONHAND_QUANTITIES`, etc.
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

### Key Joins & Logic
*   **Union of Everything**: The underlying logic is a massive `UNION ALL` query that brings together every possible source of supply and demand.
*   **Netting**: It sorts all transactions by date and calculates a running total (Cumulative Quantity).
*   **Cutoff**: Transactions past the cutoff date are ignored.

### Key Parameters
*   **Item**: The specific item to analyze.
*   **Cutoff Date**: How far into the future to look.
*   **Include Onhand Source**: Whether to include current stock as the starting balance.
