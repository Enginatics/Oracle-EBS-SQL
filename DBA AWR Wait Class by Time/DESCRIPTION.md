# Executive Summary
This report provides a comprehensive analysis of non-idle session wait times categorized by wait class over a specified time range. It is a critical tool for Database Administrators (DBAs) to identify system-wide performance bottlenecks and understand the distribution of database time across different activity types such as I/O, Concurrency, or Application logic.

# Business Challenge
*   **Performance Degradation:** Difficulty in pinpointing the exact time periods when database performance suffers.
*   **Root Cause Analysis:** Challenges in distinguishing between I/O-bound, CPU-bound, or contention-related issues.
*   **Capacity Planning:** Lack of historical data trends to forecast future resource requirements.

# The Solution
The **DBA AWR Wait Class by Time** Blitz Report addresses these challenges by:
*   **Time-Series Visualization:** Presenting wait class data per AWR snapshot interval, allowing for precise correlation with reported slow periods.
*   **Drill-Down Capabilities:** Enabling users to isolate specific wait classes (e.g., "User I/O") to see their impact over time.
*   **Pluggable Database Support:** Fully compatible with Oracle Multitenant architecture, allowing analysis at the PDB level.

# Technical Architecture
The report queries the Oracle Automatic Workload Repository (AWR) tables, specifically `DBA_HIST_SNAPSHOT` and `DBA_HIST_SYSTEM_EVENT`. It aggregates the `TIME_WAITED_MICRO` metric by `WAIT_CLASS` for each snapshot interval. The logic handles the delta calculation between snapshots to show the wait time incurred during each specific interval rather than cumulative totals.

# Parameters & Filtering
*   **Date From / Date To:** Defines the time window for the analysis.
*   **Session Type:** Filters data for 'Foreground', 'Background', or 'All' sessions. Foreground is typically most relevant for user experience.
*   **Container Data:** For multitenant environments, allows selection of specific containers.

# Performance & Optimization
*   **Date Range:** Keep the date range focused (e.g., 1-2 days) for high-resolution analysis, as AWR data can be voluminous.
*   **Snapshot Interval:** Ensure AWR snapshot intervals are appropriate (typically 15-60 minutes) for the level of granularity required.

# FAQ
*   **Q: Why do I see no data for my PDB?**
    *   A: Ensure that `awr_pdb_autoflush_enabled` is set to `true` and you are connected to the correct container.
*   **Q: What is "DB CPU"?**
    *   A: While not a "wait class" in the traditional sense, this report often includes CPU time to provide a complete picture of DB time.
