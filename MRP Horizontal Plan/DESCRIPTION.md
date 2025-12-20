# MRP Horizontal Plan - Case Study & Technical Analysis

## Executive Summary
The **MRP Horizontal Plan** is the classic "spreadsheet" view of the material plan. It displays supply, demand, and projected available balance (PAB) in time buckets (days, weeks, periods) across the horizon. It is the fundamental tool for planners to visualize the supply/demand balance for an item over time.

## Business Challenge
Planners need to see the "story" of an item's inventory. A simple list of orders isn't enough; they need to see how the inventory level fluctuates.
-   **Trend Analysis:** "Are we consistently running low on stock at the end of the month?"
-   **Capacity Planning:** "Do we have a huge spike in demand in Week 40 that we need to prepare for?"
-   **Safety Stock Visibility:** "When does our projected balance dip below the safety stock level?"

## Solution
The **MRP Horizontal Plan** provides a time-phased view of all planning elements.

**Key Features:**
-   **Time Buckets:** Aggregates data into daily, weekly, or monthly columns.
-   **Row Types:** Displays separate rows for Gross Requirements, Scheduled Receipts, Planned Orders, and Projected Available Balance.
-   **BOM Explosion:** Can optionally explode the bill of materials to show requirements for components.

## Technical Architecture
The report mimics the "Horizontal Plan" form in the Planner's Workbench.

### Key Tables and Views
-   **`MRP_MATERIAL_PLANS`**: The core table storing the time-phased data (bucketed quantities) for the plan.
-   **`MRP_WORKBENCH_BUCKET_DATES`**: Defines the start and end dates for the time buckets.
-   **`MRP_SYSTEM_ITEMS`**: Stores plan-specific item attributes (like safety stock levels for that specific plan).

### Core Logic
1.  **Bucketing:** The system aggregates individual supply/demand records into the defined time buckets.
2.  **Calculation:** It calculates the Projected Available Balance (PAB) for each bucket: `Previous PAB + Supply - Demand`.
3.  **Presentation:** Pivots the data so that time periods are columns and data types (Supply, Demand) are rows.

## Business Impact
-   **Visual Planning:** Makes it easy to spot trends and potential issues at a glance.
-   **Communication:** Provides a clear, standard format for discussing inventory plans with suppliers or production managers.
-   **Stability:** Helps planners smooth out production by visualizing peaks and valleys in demand.
