# Case Study & Technical Analysis

## Abstract
The **DBA SGA Blocking Session Summary** report aggregates data from the Active Session History (ASH) in the SGA to provide a retrospective view of locking and contention. While the standard ASH report shows all activity, this report filters and summarizes specifically for blocking scenarios, helping DBAs understand the impact and duration of lock chains that occurred recently.

## Technical Analysis

### Core Logic
*   **Source**: Queries `GV$ACTIVE_SESSION_HISTORY` where `BLOCKING_SESSION` is not null.
*   **Aggregation**: Groups by the blocking session's attributes to show which session/user was the "root blocker" and how much time other sessions spent waiting behind them.
*   **Wait Events**: Typically focuses on `enq: TX - row lock contention`, `library cache lock`, or `buffer busy waits`.

### Limitations of ASH for Locking
*   **Sampling Bias**: Short locks (< 1 second) might be missed by the 1-second sampler.
*   **Idle Blockers**: As noted in the ASH analysis, if the blocker is idle, it won't be in ASH. This report is best for finding "active" blockers—e.g., a batch job that is running slow SQL and holding locks that block online users.

### Key View
*   `GV$ACTIVE_SESSION_HISTORY`: The in-memory circular buffer of active session samples.

### Operational Use Cases
*   **Post-Mortem**: Analyzing a "system hang" that cleared up before a DBA could look at it.
*   **Pattern Recognition**: Identifying if a specific scheduled job consistently blocks users at 2:00 PM every day.
*   **Concurrency Tuning**: Identifying "hot" records or tables that are subject to frequent contention.
