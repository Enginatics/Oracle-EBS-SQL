# Case Study & Technical Analysis

## Abstract
The **DBA SGA Wait Event Summary (active session history)** report aggregates wait event data from the in-memory ASH buffer to provide a "Top Wait Events" profile for the immediate past. Unlike the standard AWR "Top 5 Timed Events," which covers a full hour, this report can be scoped to the last 5, 10, or 30 minutes, providing high-resolution visibility into transient performance spikes.

## Technical Analysis

### Core Logic
*   **Aggregation**: Sums the number of active session samples for each `EVENT` (or `WAIT_CLASS`).
*   **Time Basis**: Since ASH samples once per second, the count of samples roughly equates to "seconds spent waiting" (DB Time).
*   **CPU vs. Wait**: Clearly distinguishes between time spent on CPU (working) versus time spent waiting for resources (I/O, locks, latches).

### Key View
*   `GV$ACTIVE_SESSION_HISTORY`: The source of the wait event samples.

### Operational Use Cases
*   **Incident Response**: During a slowdown, running this report for the "Last 10 Minutes" immediately reveals if the bottleneck is I/O (`db file sequential read`), Concurrency (`enq: TX`), or CPU.
*   **Load Profiling**: Understanding the "personality" of the workload (e.g., is it read-intensive or commit-intensive?).
