# Executive Summary
The **DBA AWR Tablespace Usage** report tracks the historical growth of database storage. Unlike real-time checks that only show current usage, this report uses AWR history to show *trends*. This is essential for capacity planning, allowing DBAs to predict when a tablespace will fill up based on its growth rate over the last month or year.

# Business Challenge
*   **Capacity Planning**: "When will we need to buy more disk storage?"
*   **Budgeting**: "How much storage did the 'Archive' tablespace consume last year?"
*   **Anomaly Detection**: "Why did the UNDO tablespace suddenly grow by 50GB yesterday?"

# Solution
This report displays the used size of tablespaces over time.

**Key Features:**
*   **Used Space**: The amount of space actually occupied by data.
*   **Allocated Space**: The size of the datafiles.
*   **Growth Trend**: By comparing snapshots, you can calculate the daily growth rate.

# Architecture
The report queries `DBA_HIST_TBSPC_SPACE_USAGE`.

**Key Tables:**
*   `DBA_HIST_TBSPC_SPACE_USAGE`: Historical tablespace usage metrics.
*   `TS$`: Tablespace metadata.

# Impact
*   **Uptime**: Prevents outages caused by tablespaces reaching 100% capacity.
*   **Cost Control**: Helps justify storage purchases and identify wasted space.
*   **Proactive Management**: Allows DBAs to add space during maintenance windows rather than in a panic during business hours.
