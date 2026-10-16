# Case Study & Technical Analysis

## Abstract
The **DBA SGA Active Session History** report is the primary tool for real-time and near-real-time performance diagnostics in Oracle Database. Unlike AWR reports which provide hourly snapshots persisted to disk, this report queries `GV$ACTIVE_SESSION_HISTORY` directly from the System Global Area (SGA). This allows for second-by-second analysis of database activity, wait events, and resource consumption for the immediate past (typically the last few hours, depending on buffer size and activity levels).

## Technical Analysis

### Core Methodology
*   **Sampling**: The database samples the state of all active sessions once per second.
*   **In-Memory**: Data is read from the circular ASH buffer in the SGA. Once the buffer is full, older data is overwritten (and 1 in 10 samples are flushed to AWR on disk).
*   **Pivot Analysis**: The report is designed to be exported to Excel, where users can pivot by `SAMPLE_TIME`, `WAIT_CLASS`, `EVENT`, `SQL_ID`, or `MODULE` to isolate performance bottlenecks.

### Blocking Session Analysis
The report includes logic to link blocked sessions to their blockers.
*   **Limitation**: If a blocking session is "Idle" (e.g., a user updated a row but hasn't committed and went to lunch), it will *not* appear in the ASH data as an active session, even though it is holding a lock.
*   **Resolution**: The report attempts to provide context, but for complex lock chains, specialized scripts (like Tanel Poder's `ash_wait_chains`) or the `DBA Blocking Sessions` report (which queries `V$SESSION` directly) might be needed.

### Key Views
*   `GV$ACTIVE_SESSION_HISTORY`: The source of truth for recent activity.
*   `GV$SQLAREA`: Joins to provide SQL text and execution stats.
*   `DBA_USERS` / `DBA_PROCEDURES`: Resolves IDs to human-readable names.

### Operational Use Cases
*   **"It's slow right now"**: Diagnosing current performance spikes.
*   **Root Cause Analysis**: Determining who was holding the lock that caused a pile-up 10 minutes ago.
*   **Application Profiling**: Filtering by `MODULE` (e.g., 'eBusiness Suite') to see where the application spends its time.
