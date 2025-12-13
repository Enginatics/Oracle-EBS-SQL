# Executive Summary
The **DBA AWR System Wait Time Summary** report combines CPU usage and Wait times to provide a holistic view of system load. It often calculates "Average Active Sessions" (AAS), which is the single most important metric for Oracle performance. AAS represents the average number of sessions either working (CPU) or waiting (Wait) at any given moment. If AAS exceeds the number of CPU cores, the system is bottlenecked.

# Business Challenge
*   **Load Assessment**: "Is the database overloaded? Do we have more active sessions than CPU cores?"
*   **CPU vs. Wait**: "Are we slow because the CPU is maxed out, or because we are waiting on disk?"
*   **Scalability Analysis**: "Can we add more users, or are we already hitting the limit?"

# Solution
This report summarizes the total DB Time (CPU + Wait) and normalizes it by the elapsed time to calculate AAS.

**Key Features:**
*   **DB CPU**: Time spent on CPU.
*   **Non-Idle Wait**: Time spent waiting for resources (excluding idle waits like "SQL*Net message from client").
*   **AAS (Average Active Sessions)**: The fundamental measure of database load.

# Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL` and `DBA_HIST_SNAPSHOT`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Source of CPU time.
*   `DBA_HIST_SYSTEM_EVENT`: Source of Wait time.

# Impact
*   **Capacity Management**: The primary metric for deciding when to upgrade hardware (add cores).
*   **Performance Monitoring**: The basis for "Performance Tuning Methodology" (tuning the biggest component of AAS).
*   **Alerting**: Setting thresholds on AAS is the most effective way to alert on database performance issues.
