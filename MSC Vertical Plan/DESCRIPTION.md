# MSC Vertical Plan - Case Study & Technical Analysis

## Executive Summary
The **MSC Vertical Plan** provides a bucketed view of the plan, similar to the Horizontal Plan, but typically oriented to show the detailed composition of supply and demand within each bucket. It is often used to analyze the specific transactions that make up the totals seen in the Horizontal Plan.

## Business Challenge
Planners see a total number in the Horizontal Plan (e.g., "Demand: 500") and need to know what comprises it.
-   **Drill-Down:** "The Horizontal Plan shows a huge spike in demand in Week 4. What orders are causing that?"
-   **Composition:** "How much of this week's supply is coming from Purchase Orders versus Work Orders?"

## Solution
The **MSC Vertical Plan** lists the bucketed totals and can be used to drill down into details.

**Key Features:**
-   **Bucketed View:** Shows data in time periods (Days/Weeks).
-   **Detailed Rows:** Can break down the totals by transaction type or specific order.
-   **Comparison:** Useful for comparing supply vs. demand side-by-side for each period.

## Technical Architecture
The report queries the vertical plan view in ASCP.

### Key Tables and Views
-   **`MSC_VERTICAL_PLAN_V`**: A view specifically designed to aggregate and present plan data in a vertical format.
-   **`MSC_PLANS`**: Plan definition.
-   **`MSC_PERIOD_START_DATES`**: Defines the time buckets.

### Core Logic
1.  **Aggregation:** Groups supply and demand data by Item, Organization, and Date Bucket.
2.  **Presentation:** Lists the buckets vertically (hence the name), allowing for more detailed columns than the horizontal pivot.

## Business Impact
-   **Root Cause Analysis:** Helps planners quickly identify the specific orders driving aggregate plan results.
-   **Plan Validation:** Used to verify that the bucketing logic is working as expected.
