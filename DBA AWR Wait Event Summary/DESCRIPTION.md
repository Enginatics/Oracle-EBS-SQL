# Executive Summary
The **DBA AWR Wait Event Summary** report aggregates wait times by specific wait events and event classes for a defined snapshot interval. It is essential for DBAs to quickly identify the top contributors to database latency, enabling targeted tuning and resource optimization.

# Business Challenge
*   **Identifying Top Waiters:** Struggling to determine which specific events (e.g., `db file scattered read`, `log file sync`) are consuming the most database time.
*   **Resource Contention:** Inability to see if performance issues are due to disk I/O, network latency, or locking mechanisms.
*   **Prioritization:** Difficulty in deciding which performance issues to tackle first for maximum impact.

# The Solution
This Blitz Report solves these problems by:
*   **Aggregated View:** Summarizing wait times to highlight the most significant events over the selected period.
*   **Categorization:** Grouping events by class (e.g., System I/O, Network) for better context.
*   **Flexibility:** Allowing filtering by session type (Foreground/Background) to focus on user-impacting events.

# Technical Architecture
The report joins `DBA_HIST_SNAPSHOT` with `DBA_HIST_SYSTEM_EVENT`. It calculates the sum of `TIME_WAITED_MICRO` and `TOTAL_WAITS` for each event within the selected snapshot range. It filters out idle events (unless requested) to focus on active performance constraints.

# Parameters & Filtering
*   **Date From / Date To:** Specifies the analysis period.
*   **Session Type:** Restricts analysis to Foreground, Background, or All processes.
*   **Include Idle Events:** Option to include or exclude non-critical wait events (e.g., `SQL*Net message from client`).

# Performance & Optimization
*   **Exclude Idle Events:** Always keep "Include Idle Events" to 'No' (default) to avoid cluttering the report with irrelevant data.
*   **Time Restriction:** Use the time parameters to narrow down the analysis to peak business hours.

# FAQ
*   **Q: How does this differ from the "Wait Class by Time" report?**
    *   A: This report provides a summary of *specific events* over the entire period, whereas "Wait Class by Time" shows *classes* of waits broken down by snapshot interval.
*   **Q: Can I use this for a specific SQL ID?**
    *   A: No, this report is at the system/instance level. For SQL-level analysis, use "DBA AWR SQL Performance Summary".
