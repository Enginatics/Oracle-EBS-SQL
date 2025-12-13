# Executive Summary
The **DBA AWR System Wait Event Summary** report provides the granular details behind the high-level wait classes. Once a bottleneck class (e.g., "User I/O") is identified, this report reveals the specific *events* causing the delay (e.g., "db file scattered read" vs. "db file sequential read"). This is the level of detail required for root cause analysis and specific tuning actions.

# Business Challenge
*   **Root Cause Analysis**: "We know it's I/O, but is it full table scans (scattered read) or index lookups (sequential read)?"
*   **Locking Issues**: "Are we waiting on 'enq: TX - row lock contention' (application logic) or 'enq: TM - real time' (unindexed foreign keys)?"
*   **Log File Tuning**: "Is 'log file sync' high because of commit frequency or slow disks?"

# Solution
This report lists the top wait events by time for a specific interval.

**Key Features:**
*   **Total Wait Time**: The cumulative time spent waiting for the event.
*   **Average Wait**: The average time per occurrence (latency). High latency usually points to hardware/OS issues.
*   **Wait Count**: How many times the event occurred. High count usually points to application frequency issues.

# Architecture
The report queries `DBA_HIST_SYSTEM_EVENT`.

**Key Tables:**
*   `DBA_HIST_SYSTEM_EVENT`: Stores wait statistics per snapshot.

# Impact
*   **Precision Tuning**: Enables targeted fixes (e.g., "Add an index to stop the full table scans" or "Move the redo logs to SSD").
*   **Vendor Management**: Provides evidence of slow storage latency to storage vendors.
*   **Application Optimization**: Identifies excessive committing or inefficient locking logic.
