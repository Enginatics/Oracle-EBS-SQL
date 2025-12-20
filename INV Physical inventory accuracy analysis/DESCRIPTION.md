# INV Physical inventory accuracy analysis - Case Study & Technical Analysis

## Executive Summary
The **INV Physical inventory accuracy analysis** report is a key performance indicator (KPI) tool for warehouse management. It measures the effectiveness of the physical inventory process by comparing the system's "Book Quantity" against the actual "Count Quantity." It calculates accuracy percentages to help management understand how reliable their inventory data is.

## Business Challenge
Inventory accuracy is critical for supply chain planning. If the system says you have 100 units but you only have 80, you will promise orders you can't fulfill. Conversely, if you have 120 but the system says 100, you are carrying excess stock.
-   **Trust:** "Can we trust the system numbers, or do we need to double-check every time?"
-   **Root Cause Analysis:** "Are we consistently losing stock in a specific subinventory or for a specific item category?"
-   **Audit Compliance:** Auditors require proof that the variance between book and physical inventory is within acceptable limits.

## Solution
The **INV Physical inventory accuracy analysis** report provides a statistical breakdown of the count results. It highlights the absolute and relative variance for items and categories.

**Key Features:**
-   **Variance Calculation:** Shows the difference between system quantity and counted quantity.
-   **Value Impact:** Calculates the financial impact of the variance (Variance Quantity * Item Cost).
-   **Accuracy Metrics:** Provides an overall accuracy percentage for the organization or category.

## Technical Architecture
The report analyzes the results stored in the physical inventory tables after the count is completed but before (or after) adjustments are posted.

### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORIES`**: The header definition of the physical inventory event.
-   **`MTL_PHY_ADJ_COST_V`**: A view that calculates the cost of adjustments.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item definitions.

### Core Logic
1.  **Data Retrieval:** Fetches count records linked to the specified Physical Inventory ID.
2.  **Comparison:** Compares `SYSTEM_QUANTITY` vs. `COUNT_QUANTITY`.
3.  **Costing:** Multiplies the variance by the item's current cost to determine financial impact.

## Business Impact
-   **Process Improvement:** Identifies areas (e.g., specific aisles or product lines) with poor accuracy, targeting them for process review.
-   **Financial Integrity:** Provides the backup documentation for the inventory write-off or write-on entries in the General Ledger.
-   **Planning Reliability:** Improves the quality of MRP/ASCP plans by ensuring the starting inventory position is accurate.
