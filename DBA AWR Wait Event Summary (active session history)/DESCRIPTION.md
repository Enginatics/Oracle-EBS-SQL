# Executive Summary
The **DBA AWR Wait Event Summary (active session history)** report provides a highly granular view of database waits. Unlike the standard "System Wait Event" report which aggregates data globally, this report uses Active Session History (ASH) data. This allows you to filter waits by specific dimensions like User, Module, Action, or SQL ID. It answers "Who?" and "What?" rather than just "How much?".

# Business Challenge
*   **User Isolation**: "Why is the CFO's session slow, even though the system overall is fine?"
*   **Module Analysis**: "Is the 'Payroll' module suffering from lock contention?"
*   **SQL Diagnosis**: "What specific event is this SQL statement waiting on?"

# Solution
This report aggregates ASH samples to estimate wait times for specific criteria.

**Key Features:**
*   **Granular Filtering**: Can filter by `SESSION_TYPE`, `EVENT`, `INSTANCE_NUMBER`, etc.
*   **ASH Sampling**: Uses the 1-second samples from ASH to reconstruct the performance profile.
*   **CPU vs. Wait**: Clearly distinguishes between time spent working (CPU) and time spent waiting.

# Architecture
The report queries `DBA_HIST_ACTIVE_SESS_HISTORY`.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: The history of active sessions (sampled every 10 seconds).

# Impact
*   **Targeted Tuning**: Solves "needle in a haystack" problems where a single user or job is suffering.
*   **Multi-Tenant Analysis**: In a consolidated environment, identifies which tenant is causing the noise.
*   **Forensic Analysis**: Allows detailed post-mortem analysis of incidents that happened days ago.
