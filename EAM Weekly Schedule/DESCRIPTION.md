```markdown
# Case Study & Technical Analysis: EAM Weekly Schedule

## Executive Summary
The **EAM Weekly Schedule** report is a tactical planning tool for Maintenance Planners and Supervisors. It provides a Gantt-chart-style view of the upcoming week's workload, broken down by Work Order, Operation, and Resource.
Unlike a simple list of open work orders, this report focuses on *scheduling*: who is doing what, when they are starting, and how long it will take. It is essential for:
1.  **Resource Leveling:** Ensuring that mechanics and electricians are not overbooked on Tuesday and idle on Friday.
2.  **Shutdown Planning:** Identifying work orders that require a machine shutdown (`Shutdown Type`) to coordinate production downtime.
3.  **Execution Tracking:** Monitoring the progress of scheduled work against the plan.

## Business Challenge
Maintenance scheduling is a dynamic puzzle.
*   **Resource Constraints:** You have 5 mechanics, but 50 hours of work scheduled for Monday.
*   **Asset Availability:** You can't service the conveyor belt while it's running.
*   **Prioritization:** When an emergency breakdown occurs, the schedule must be shuffled. Planners need a clear view of the "Firm Planned" work vs. the backlog to make these decisions.

## The Solution
This report replicates the standard Oracle EAM Weekly Schedule logic but exposes it in a flexible SQL format.
*   **Detailed Resource View:** It drills down to the `WIP_OP_RESOURCE_INSTANCES` level. This means it doesn't just say "Mechanic Required"; it says "John Smith is assigned."
*   **Capacity Planning Columns:** The columns `CP_1` through `CP_8` (likely representing days of the week or capacity buckets) allow for a pivot-table style view of daily load.
*   **Operational Context:** It includes critical execution flags:
    *   **Material Shortage:** Warns if parts are missing (don't schedule the job if you don't have the parts!).
    *   **Shutdown Type:** Indicates if the asset must be stopped (Required) or if work can be done while running.
    *   **Warranty Status:** Alerts the planner if the asset is under warranty (maybe call the vendor instead of fixing it internally).

## Technical Architecture (High Level)
The query joins the Work Order header (`WIP_DISCRETE_JOBS`) to its operations and resources.
*   **Resource Explosion:** The inline view `worp` (Work Order Resource Pivot) joins `WIP_OPERATIONS` -> `WIP_OPERATION_RESOURCES` -> `WIP_OP_RESOURCE_INSTANCES`. This ensures that every specific person or machine assigned to a task gets a row.
*   **Instance Resolution:** The complex `UNION` in the `instance_name` column logic resolves the generic "Instance ID" into a human-readable name.
    *   If `Resource_Type = 2` (Person), it looks up `PER_ALL_PEOPLE_F`.
    *   If `Resource_Type = 1` (Machine), it looks up `MTL_SYSTEM_ITEMS` (Equipment Item).
*   **Package Logic:** The query calls `eam_eamwsrep_xmlp_pkg` functions (e.g., `cp_1_p`). These are standard Oracle Reports packages that likely calculate the hours allocated to specific days based on the `Week Starting` parameter.

## Parameters & Filtering
*   **Week Starting:** The anchor date for the schedule.
*   **Owning vs. Assigned Department:** Allows filtering by who *owns* the asset vs. who is *doing* the work.
*   **Shutdown Type:** Critical for production coordination.
*   **Sort By:** Flexible sorting (Start Date, Priority, Asset) to match the planner's workflow.

## Performance & Optimization
*   **Distinct Selection:** The use of `SELECT DISTINCT` suggests that the underlying joins (especially around resource instances) might produce duplicates that need to be flattened for the report.
*   **Date Math:** Duration calculations (`res_completion_date - res_start_date`) are done in the database, providing immediate visibility into job length without external calculation.

## FAQ
**Q: Why is the "Instance Name" blank?**
A: If a resource requirement is defined at the *Group* level (e.g., "Any Mechanic") but not assigned to a specific *Instance* (e.g., "John Doe"), the instance ID will be null. This is common for unassigned backlog work.

**Q: What does "Firm Planned" mean?**
A: A "Firm" work order is locked in the schedule. MRP or auto-scheduling tools will not automatically move it. This report highlights these locked jobs so planners know what is non-negotiable.

**Q: How does it handle multi-day jobs?**
A: The `Duration` column shows the total hours. The package functions (`cp_1`...`cp_7`) likely distribute these hours across the days of the week, though the exact logic depends on the package code (which is wrapped in the database).
```