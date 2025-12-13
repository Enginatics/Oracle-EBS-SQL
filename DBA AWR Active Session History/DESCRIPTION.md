# Executive Summary
The **DBA AWR Active Session History** report is a forensic performance analysis tool. It mines the Automatic Workload Repository (AWR) to reconstruct the "Active Session History" (ASH) for a past time period. While real-time ASH shows what is happening *now*, this report allows DBAs to answer "What happened *then*?" with second-by-second granularity.

# Business Challenge
*   **Post-Mortem Analysis**: "Users reported the system froze yesterday between 2:00 and 2:15 PM. What caused it?"
*   **Wait Analysis**: Identifying the specific bottleneck (CPU, I/O, Locks) that dominated the workload during the incident.
*   **SQL Identification**: Pinpointing the exact SQL ID and execution plan that was consuming resources at that time.

# Solution
This report dumps the historical ASH data, allowing for detailed filtering and pivoting.

**Key Features:**
*   **Granularity**: ASH samples active sessions every second (in memory) and persists a sample (1 in 10) to AWR.
*   **Dimensions**: Can analyze by User, Module, SQL ID, Wait Event, Machine, etc.
*   **Blocking Info**: Shows which session was blocking which other session.

# Architecture
The report queries `DBA_HIST_ACTIVE_SESS_HISTORY`, the persistent storage for ASH data.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: The core history table.
*   `DBA_USERS`: Usernames.
*   `DBA_HIST_SQLTEXT`: SQL text for the captured SQL IDs.

# Impact
*   **Root Cause Analysis**: Moves performance tuning from guessing to evidence-based diagnosis.
*   **SLA Management**: Helps explain service interruptions to stakeholders with concrete data.
*   **Trend Identification**: Can be used to spot recurring patterns of contention (e.g., "Every day at 9 AM, we hit this lock").
