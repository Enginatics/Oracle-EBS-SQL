# Executive Summary
The **CRP Resource Plan** report is the counterpart to the "Available Resources" report. While the former shows *supply* (capacity), this report shows *demand* (load). It details the specific work scheduled for each resource, including the start/end dates, hours required, and the specific job or sales order driving the demand. This allows planners to see exactly what is consuming the shop floor's capacity.

# Business Challenge
Knowing that a machine is "busy" isn't enough. Planners need to know *what* it is busy doing.
*   **Prioritization**: If a machine is overbooked, which jobs should be moved? Planners need to see the pegged demand (e.g., "This job is for a critical customer order").
*   **Load Balancing**: Identifying periods where demand exceeds supply allows for proactive rescheduling.
*   **Pegging**: Tracing the resource requirement back to the source demand (Sales Order -> Job -> Operation -> Resource).

# Solution
This report provides a detailed schedule of resource requirements.

**Key Features:**
*   **Detailed Pegging**: Links the resource load to the specific WIP Job, Assembly, and even the Sales Order.
*   **Time Phasing**: Shows the specific date and time the resource is required.
*   **Flexible Filtering**: Allows filtering by Planner, Job, Assembly, or Department to focus on specific problem areas.

# Architecture
The report queries `CRP_RESOURCE_PLAN` (or `MRP_GROSS_REQUIREMENTS` linked to resource data) to show the load. It joins to `WIP_DISCRETE_JOBS` and `OE_ORDER_LINES_ALL` to provide the context of *why* the resource is needed.

**Key Tables:**
*   `CRP_RESOURCE_PLAN`: The calculated load on resources.
*   `WIP_DISCRETE_JOBS`: The production order.
*   `WIP_OPERATIONS`: The specific routing step requiring the resource.
*   `OE_ORDER_LINES_ALL`: The customer demand driving the production.

# Impact
*   **Conflict Resolution**: Enables planners to make informed decisions about which jobs to reschedule when capacity is tight.
*   **Customer Service**: Helps predict if a resource constraint will cause a customer order to be late.
*   **Resource Optimization**: Ensures that high-value resources are working on high-priority orders.
