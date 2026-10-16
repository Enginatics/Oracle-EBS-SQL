# Executive Summary
The **DBA AWR SQL Performance Summary** report is the "Top SQL" report for the database. It aggregates performance metrics from AWR to identify the SQL statements that are consuming the most resources (CPU, I/O, Time) over a specific period. This is the primary tool for identifying candidates for SQL tuning.

# Business Challenge
*   **Resource Hogs**: "Which 5 queries are consuming 80% of our CPU?"
*   **I/O Bottlenecks**: "Which reports are doing the most physical reads and slowing down the storage array?"
*   **Inefficiency**: "Which queries are executed millions of times a day (e.g., inside a loop)?"

# Solution
This report summarizes execution statistics for SQL statements.

**Key Features:**
*   **Multi-Dimensional Sorting**: Can sort by Elapsed Time, CPU Time, Buffer Gets (Logical I/O), or Disk Reads (Physical I/O).
*   **Per-Execution Metrics**: Calculates "Time per Exec" and "I/O per Exec" to identify inefficient code regardless of execution count.
*   **Module Identification**: Shows which EBS module (e.g., "GL", "OE") executed the SQL.

# Architecture
The report queries `DBA_HIST_SQLSTAT` and `DBA_HIST_SQLTEXT`.

**Key Tables:**
*   `DBA_HIST_SQLSTAT`: Performance statistics per snapshot.
*   `DBA_HIST_SQLTEXT`: The actual SQL code.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

# Impact
*   **Performance ROI**: Tuning the top 5 SQLs often yields a greater system-wide benefit than upgrading hardware.
*   **Code Quality**: Highlights poorly written custom code (e.g., missing indexes, Cartesian products).
*   **Capacity Management**: Reducing the load from top SQLs frees up headroom for growth.
