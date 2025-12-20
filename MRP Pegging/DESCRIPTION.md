# MRP Pegging - Case Study & Technical Analysis

## Executive Summary
The **MRP Pegging** report provides a comprehensive view of the supply-demand links established by the planning engine. Unlike the "End Assembly Pegging" report which focuses on the final product, this report details the immediate parent-child relationships for any item, showing exactly what demand is driving a specific supply order.

## Business Challenge
Planners need to justify every supply order.
-   **Justification:** "Why is the system telling me to buy 500 units of Part X? What is it used for?"
-   **Allocation:** "I have 100 units of stock. Which work orders are claiming that stock?"
-   **Impact Assessment:** "If this Purchase Order is late, which specific Work Orders will be delayed?"

## Solution
The **MRP Pegging** report exposes the "pegging" tree.

**Key Features:**
-   **Upstream/Downstream:** Can show what demand is driving a supply (Upstream) or what supply is satisfying a demand (Downstream).
-   **Order Details:** Includes specific order numbers (PO #, Job #, SO #).
-   **Delay Analysis:** Highlights cases where the supply date is later than the demand date (Plan Delay).

## Technical Architecture
The report queries the pegging data generated during the MRP run.

### Key Tables and Views
-   **`MRP_FULL_PEGGING`**: The core table storing the links between transaction IDs (Supply ID -> Demand ID).
-   **`MRP_GROSS_REQUIREMENTS`**: Details the demand side (Sales Orders, Forecasts, WIP Component Demand).
-   **`MRP_RECOMMENDATIONS`**: Details the supply side (Planned Orders, Reschedule Recommendations).
-   **`PO_HEADERS_ALL` / `WIP_DISCRETE_JOBS`**: Provides details for existing supply orders.

### Core Logic
1.  **Root Identification:** Starts with a specific item or order.
2.  **Traversal:** Follows the `PEGGING_ID` links in `MRP_FULL_PEGGING` to find the related transactions.
3.  **Enrichment:** Joins to source tables (PO, WIP, OE) to get human-readable details like Order Numbers and Customer Names.

## Business Impact
-   **Inventory Reduction:** Helps identify "orphan" supply (supply with no pegging) that can be cancelled.
-   **Expediting:** Pinpoints exactly which supply orders are critical for meeting customer demand.
-   **Transparency:** Removes the "black box" mystery of MRP by showing the exact logic behind every recommendation.
