# Executive Summary
The **DBA Log Switches** report tracks the frequency of Redo Log switches. In an Oracle database, every change is written to the Redo Log. When a log file fills up, a "Log Switch" occurs, and the database moves to the next file. Frequent switching (e.g., every 2 minutes) causes "Checkpoint" storms, where the database freezes while flushing dirty blocks to disk.

# Business Challenge
*   **Performance Stalls**: "Why does the system freeze for 10 seconds every few minutes?"
*   **Sizing**: "Are our 1GB redo logs too small for the current transaction volume?"
*   **Peak Load Analysis**: "At what time of day do we generate the most redo (i.e., do the most inserts/updates)?"

# Solution
This report lists the time of each log switch.

**Key Features:**
*   **Switch Time**: The exact timestamp of the switch.
*   **Frequency**: Allows calculation of the interval between switches.
*   **Thread**: In RAC environments, shows which instance performed the switch.

# Architecture
The report queries `GV$LOG_HISTORY`.

**Key Tables:**
*   `GV$LOG_HISTORY`: Historical log switch data.

# Impact
*   **Tuning**: Helps DBAs size redo logs correctly (Oracle recommends switching no more than once every 15-20 minutes).
*   **IO Stability**: Reducing switch frequency smooths out the I/O load on the storage subsystem.
*   **Archiver Health**: Ensures the Archiver process (ARCn) can keep up with the generation of redo logs.
