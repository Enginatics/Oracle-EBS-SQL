# INV Transaction Historical Summary - Case Study & Technical Analysis

## Executive Summary
The **INV Transaction Historical Summary** report is a retrospective analysis tool. It allows users to "roll back" the clock and see what the inventory value or quantity was at a specific point in the past. This is essential for audit reconstruction and trend analysis.

## Business Challenge
Standard on-hand reports only show the *current* balance. But businesses often ask:
-   **Audit:** "What was the inventory value on December 31st at midnight?"
-   **Investigation:** "Why did we run out of stock last Tuesday? How much did we have on Monday?"
-   **Trend:** "What was our average inventory level for Q1 vs Q2?"

## Solution
The **INV Transaction Historical Summary** report reconstructs the past balance by taking the current balance and "reversing" all transactions that happened since the target date.

**Key Features:**
-   **Rollback Logic:** Calculates the balance as of a specific past date.
-   **Valuation:** Can report on both Quantity and Value.
-   **Flexibility:** Supports pivoting by Category or Subinventory.

## Technical Architecture
This report uses a complex calculation engine (often involving temporary tables) to perform the rollback.

### Key Tables and Views
-   **`MTL_MATERIAL_TRANSACTIONS`**: The history of all movements.
-   **`CST_INV_QTY_TEMP`**: Temporary table used to store the calculated past quantities.
-   **`CST_INV_COST_TEMP`**: Temporary table used to store the calculated past costs.

### Core Logic
1.  **Current Balance:** Starts with the current on-hand quantity.
2.  **Reverse Transactions:** Subtracts (or adds) the quantities of all transactions that occurred *after* the "Rollback Date".
    *   *Formula:* `Historical Qty = Current Qty - (Sum of Inflows since Date) + (Sum of Outflows since Date)`
3.  **Costing:** Applies the cost that was active at that historical date (for Standard Costing) or the calculated layer cost (for Average/FIFO).

## Business Impact
-   **Audit Defense:** The primary tool for proving the inventory balance at year-end if the period was not closed exactly on time.
-   **Performance Analysis:** Helps analyze inventory turnover trends over time.
-   **Dispute Resolution:** Resolves "he said, she said" arguments about stock availability in the past.
