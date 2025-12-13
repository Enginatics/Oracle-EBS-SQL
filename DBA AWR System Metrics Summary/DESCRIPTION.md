# Executive Summary
The **DBA AWR System Metrics Summary** report provides a high-level dashboard of the database's vital signs over time. It summarizes key system-wide metrics like CPU Load, Wait Percentage, and I/O Throughput (MB/s). This report is ideal for spotting trends, identifying peak load windows, and correlating system behavior with user complaints.

# Business Challenge
*   **Health Check**: "Is the database healthy right now? How does it compare to last week?"
*   **Bottleneck Identification**: "Are we CPU bound (high CPU%) or I/O bound (high Wait% and Phys Read)?"
*   **Throughput Analysis**: "What is our peak I/O throughput? Do we need a faster SAN?"

# Solution
This report aggregates system metrics from AWR snapshots.

**Key Features:**
*   **CPU %**: Total CPU utilization.
*   **Wait %**: Percentage of time sessions spent waiting.
*   **I/O Metrics**: Buffer Read (Logical), Physical Read, and Physical Write in MB/s.
*   **Snapshot Granularity**: Shows how these metrics evolve hour by hour.

# Architecture
The report queries `DBA_HIST_SYSMETRIC_SUMMARY` (or similar views depending on version).

**Key Tables:**
*   `DBA_HIST_SYSMETRIC_SUMMARY`: Summarized system metrics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

# Impact
*   **Executive Reporting**: Provides simple, understandable charts for management (e.g., "CPU usage is up 20% year-over-year").
*   **Proactive Sizing**: Helps predict when the system will hit hardware limits.
*   **Incident Correlation**: Helps correlate "slow system" tickets with actual server load metrics.
