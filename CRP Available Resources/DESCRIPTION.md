# Executive Summary
The **CRP Available Resources** report is a fundamental tool for Capacity Requirements Planning (CRP). It provides a detailed view of the available capacity for manufacturing resources (machines and labor) over a specified date range. By showing the daily hours and unit capacity for each resource, this report helps production planners identify potential bottlenecks and validate that the shop floor has the necessary bandwidth to meet the production schedule.

# Business Challenge
Manufacturing efficiency depends on balancing demand (production orders) with supply (resource capacity).
*   **Overbooking**: Scheduling more work than a machine can handle leads to missed deadlines and overtime costs.
*   **Underutilization**: Idle machines represent wasted capital and lost revenue potential.
*   **Visibility**: Planners need to know exactly how many hours a specific resource is available on a specific day, accounting for shifts, holidays, and maintenance.

# Solution
This report queries the CRP tables to present the calculated availability of resources.

**Key Features:**
*   **Daily Granularity**: Shows availability day-by-day, allowing for precise scheduling.
*   **Resource Specificity**: Drills down to the individual resource level within a department.
*   **Capacity Metrics**: Displays both "Daily Hours" (time available) and "Unit Capacity" (throughput potential).

# Architecture
The report pulls data from `CRP_AVAILABLE_RESOURCES`, which is populated by the planning engine (ASCP or MRP). It links to `BOM_DEPARTMENTS` and `BOM_RESOURCES` for descriptive details.

**Key Tables:**
*   `CRP_AVAILABLE_RESOURCES`: The core table storing the calculated capacity.
*   `BOM_DEPARTMENTS`: The manufacturing department owning the resource.
*   `BOM_RESOURCES`: The specific machine or labor code.

# Impact
*   **Realistic Scheduling**: Ensures that production plans are feasible based on actual shop floor constraints.
*   **Bottleneck Identification**: Highlights resources with limited availability that may constrain total output.
*   **Shift Management**: Helps managers decide if additional shifts or overtime are needed to meet demand.
