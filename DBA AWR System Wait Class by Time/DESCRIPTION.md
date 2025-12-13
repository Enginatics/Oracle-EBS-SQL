# Executive Summary
The **DBA AWR System Wait Class by Time** report is a high-level diagnostic tool that groups database waits into logical categories (Classes). Instead of overwhelming the DBA with hundreds of specific wait events, it aggregates them into classes like "User I/O", "System I/O", "Concurrency", "Commit", and "Network". This allows for rapid identification of the *type* of bottleneck affecting the system.

# Business Challenge
*   **Triage**: "The system is slow. Is it the disk (User I/O), the network (Network), or locking (Concurrency)?"
*   **Pattern Recognition**: "Why do we see a spike in 'Configuration' waits every night at 2 AM?"
*   **Hardware Validation**: "We bought a faster SAN. Did 'User I/O' wait time actually decrease?"

# Solution
This report aggregates wait times by `WAIT_CLASS`.

**Key Features:**
*   **User I/O**: Waits for user queries (e.g., reading tables).
*   **System I/O**: Waits for background processes (e.g., writing redo logs).
*   **Concurrency**: Waits for locks and latches.
*   **Commit**: Waits for log file sync (transaction durability).
*   **Application**: Waits caused by application logic (e.g., row locks).

# Architecture
The report queries `DBA_HIST_SYSTEM_EVENT`.

**Key Tables:**
*   `DBA_HIST_SYSTEM_EVENT`: Historical wait event statistics.
*   `V$EVENT_NAME`: Maps events to classes.

# Impact
*   **Faster Diagnosis**: Reduces the search space for performance issues from hundreds of events to ~12 classes.
*   **Communication**: "We have a disk I/O problem" is easier to explain to management than "We have high db file sequential read waits."
*   **Focused Tuning**: Tells the DBA which team to call (Storage, Network, or Developers).
