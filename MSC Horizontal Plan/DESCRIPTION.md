# MSC Horizontal Plan - Case Study & Technical Analysis

## Executive Summary
The **MSC Horizontal Plan** is the ASCP equivalent of the MRP Horizontal Plan. It provides a time-phased, bucketed view of supply, demand, and projected inventory across the entire supply chain. It is the fundamental tool for visualizing the flow of materials over time.

## Business Challenge
Planners need to see the "big picture" of inventory flow, not just a list of orders.
-   **Inventory Projection:** "What will our stock level be at the end of each week for the next 6 months?"
-   **Supply/Demand Balance:** "Are we consistently producing more than we are selling?"
-   **Safety Stock:** "When do we dip below our safety stock target?"

## Solution
The **MSC Horizontal Plan** aggregates planning data into time buckets.

**Key Features:**
-   **Bucketing:** Aggregates data into Daily, Weekly, and Monthly buckets.
-   **Row Types:** Displays rows for Gross Requirements, Scheduled Receipts, Planned Orders, Projected On Hand, and Safety Stock.
-   **Flexibility:** Can include or exclude specific supply/demand types based on user preference.

## Technical Architecture
The report mimics the Horizontal Plan view in the ASCP Planner's Workbench.

### Key Tables and Views
-   **`MSC_PLANS`**: Defines the plan.
-   **`MSC_SUPPLIES`** / **`MSC_DEMANDS`**: The core tables storing all supply and demand transactions.
-   **`MSC_CAL_WEEK_START_DATES`**: Used to aggregate daily data into weekly buckets.

### Core Logic
1.  **Aggregation:** Sums the quantities of supply and demand for each item within each time bucket.
2.  **Calculation:** Calculates the Projected Available Balance (PAB) cumulatively: `Previous PAB + Supply - Demand`.
3.  **Presentation:** Pivots the data to display time periods as columns.

## Business Impact
-   **Strategic Planning:** Helps identify long-term trends in inventory and capacity.
-   **Inventory Optimization:** Visualizes excess inventory and potential stockouts.
-   **Communication:** Provides a standard format for sharing the plan with stakeholders.
