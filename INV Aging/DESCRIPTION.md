# INV Aging - Case Study & Technical Analysis

## Executive Summary
The **INV Aging** report provides a detailed analysis of inventory age, categorizing on-hand stock into time buckets (e.g., 0-30 days, 31-60 days, 180+ days). This is a critical tool for identifying slow-moving and obsolete inventory (SLOB), calculating inventory reserves, and managing working capital. It helps organizations understand not just *how much* stock they have, but *how old* it is.

## Business Use Cases
*   **Obsolescence Provisioning**: Finance teams use this report to calculate the "Inventory Reserve" or "Write-down" required for old stock (e.g., "Reserve 50% for items older than 1 year").
*   **Warehouse Space Management**: Identifies old stock taking up valuable warehouse space, triggering disposal or discount sales.
*   **Working Capital Optimization**: Highlights capital tied up in non-performing assets.
*   **FIFO/LIFO Analysis**: Helps validate that the First-In-First-Out (FIFO) flow is actually happening physically.

## Technical Analysis

### Core Tables
*   `MTL_ONHAND_QUANTITIES_DETAIL`: The primary source of current on-hand stock.
*   `MTL_MATERIAL_TRANSACTIONS`: Used to trace the receipt date of the items (especially for FIFO logic).
*   `CST_COST_GROUPS`: Used for costing context.
*   `AR_AGING_BUCKETS`: Reuses the AR aging bucket definitions to define the time ranges.

### Key Joins & Logic
*   **FIFO Logic**: The most complex part of this report is determining the "age" of commingled stock. Since Oracle Inventory (without WMS/LPNs) doesn't always track the specific receipt date of a specific unit, the report often uses a **FIFO algorithm**: it looks at the current on-hand quantity and "walks back" through the receipt history (`MTL_MATERIAL_TRANSACTIONS`) to attribute the stock to the most recent receipts.
*   **Bucket Allocation**: Once the age is determined, the quantity and value are allocated to the appropriate bucket (e.g., 0-30, 31-60).
*   **Valuation**: Multiplies the quantity by the current item cost (from `CST_ITEM_COSTS` or `CST_QUANTITY_LAYERS`).

### Key Parameters
*   **Buckets Days**: Defines the aging intervals.
*   **Cost Group**: Filter for specific cost groups (Project Manufacturing).
*   **Category Set**: Filter by item category (e.g., "Finished Goods").
