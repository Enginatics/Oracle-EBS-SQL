# Executive Summary
The **DBA AWR CPU Load (active session history)** report is a targeted analysis tool for identifying CPU bottlenecks. By aggregating Active Session History (ASH) data, it highlights specific time intervals where the number of sessions actively using CPU exceeded a defined threshold. This helps DBAs pinpoint "CPU spikes" and drill down into the sessions responsible.

# Business Challenge
*   **Server Sizing**: "Do we need more CPU cores, or is the current usage just inefficient SQL?"
*   **Performance Degradation**: "The system slows down every day at 10 AM. Is it CPU saturation?"
*   **Resource Hog Identification**: Finding the specific user or background process consuming the most CPU cycles.

# Solution
This report aggregates ASH samples where the session state is 'ON CPU'.

**Key Features:**
*   **Threshold Filtering**: The "CPU Sessions From" parameter allows filtering for intervals where CPU demand was high (e.g., > 8 active sessions on an 8-core machine).
*   **Time-Based Aggregation**: Groups data by AWR snapshot time to show the load profile over time.
*   **Drill-Down Capable**: Can be used in conjunction with other ASH reports to find the specific SQL IDs.

# Architecture
The report queries `DBA_HIST_ACTIVE_SESS_HISTORY`.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: The source of session state data.

# Impact
*   **Cost Savings**: Optimizing high-CPU queries can delay or eliminate the need for expensive hardware upgrades.
*   **Stability**: Prevents CPU starvation for critical processes by identifying and tuning aggressive workloads.
*   **Capacity Planning**: Provides empirical data on peak CPU utilization trends.
