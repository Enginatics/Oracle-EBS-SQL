# Executive Summary
The **DBA AWR CPU vs Wait Time Summary** report provides a high-level "health check" of the database workload. It compares the time spent on CPU (doing work) versus the time spent waiting (for I/O, locks, network, etc.). This ratio is the fundamental starting point for any performance tuning exercise: "Is the problem that we are doing too much work (CPU), or that we are waiting too long for resources (Wait)?"

# Business Challenge
*   **Problem Classification**: "Is the database slow because of slow disks (Wait) or inefficient code (CPU)?"
*   **Workload Profiling**: Understanding if the system is "CPU Bound" or "I/O Bound".
*   **Trend Analysis**: Seeing how the workload profile changes over time (e.g., after a storage migration).

# Solution
This report summarizes the "System Time Model" statistics from AWR.

**Key Features:**
*   **DB Time Breakdown**: Shows the total "DB Time" split into CPU Time and Wait Time.
*   **Average Active Sessions (AAS)**: Calculates the AAS metric, a key indicator of system load relative to capacity.
*   **PDB Support**: Can report on Pluggable Databases (PDBs) if configured.

# Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Stores system-wide time statistics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing details.

# Impact
*   **Strategic Tuning**: Directs tuning efforts to the right area (e.g., don't buy faster disks if the problem is 90% CPU).
*   **Performance Baselines**: Establishes a baseline for "normal" behavior to compare against during incidents.
*   **Executive Reporting**: Provides a simple, high-level metric (CPU vs. Wait) that is easy to explain to management.
