# Executive Summary
The **DBA AWR Blocking Session Summary** report focuses specifically on database locking and concurrency issues. It aggregates data from the AWR Active Session History to identify "Blocking Chains"—situations where one session holds a resource (like a row lock) that prevents other sessions from proceeding. This is often the cause of "application hangs."

# Business Challenge
*   **Lock Storms**: A single user leaving a record open on their screen can block a batch job, which then blocks other users, creating a cascade of hung sessions.
*   **Code Defects**: Identifying application code that holds locks longer than necessary or commits infrequently.
*   **Idle Blockers**: Detecting sessions that are "Idle" (not consuming CPU) but are still holding locks (e.g., "SQL*Net message from client").

# Solution
This report summarizes the blocking relationships found in the history.

**Key Features:**
*   **Blocker Identification**: Identifies the "Root Blocker"—the session at the top of the chain.
*   **Wait Event Analysis**: Shows what the blocked sessions were waiting for (e.g., "enq: TX - row lock contention").
*   **Impact Assessment**: Shows how many sessions were blocked and for how long.

# Architecture
The report analyzes `DBA_HIST_ACTIVE_SESS_HISTORY` to find rows where `BLOCKING_SESSION` is populated.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: Source of blocking info.
*   `DBA_OBJECTS`: Identifies the object being locked (if available).
*   `DBA_USERS`: Identifies the users involved.

# Impact
*   **Application Stability**: Helps developers fix code that causes concurrency bottlenecks.
*   **Operational Efficiency**: Reduces the time required to diagnose "system hang" incidents.
*   **User Education**: Can be used to show users the impact of leaving transactions uncommitted.
