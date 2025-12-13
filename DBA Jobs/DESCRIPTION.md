# Executive Summary
The **DBA Jobs** report monitors the legacy Oracle Job Scheduler (`DBMS_JOB`). While newer applications use `DBMS_SCHEDULER`, many older parts of Oracle E-Business Suite and custom legacy code still rely on `DBMS_JOB`. This report is essential for ensuring that these background tasks are running successfully.

# Business Challenge
*   **Silent Failures**: "The nightly interface didn't run, but no one got an email."
*   **Broken Jobs**: "Why is this job marked as 'Broken'?" (It failed 16 times in a row).
*   **Performance**: "Is this job taking longer and longer to run each night?"

# Solution
This report lists all jobs submitted via `DBMS_JOB`.

**Key Features:**
*   **Last Date/Time**: When the job last ran successfully.
*   **Next Date/Time**: When it is scheduled to run again.
*   **Failures**: The number of consecutive failures.
*   **What**: The PL/SQL block that the job executes.

# Architecture
The report queries `DBA_JOBS`.

**Key Tables:**
*   `DBA_JOBS`: The legacy job queue table.

# Impact
*   **Reliability**: Ensures critical background processes (like workflow background engines or materialized view refreshes) are active.
*   **Troubleshooting**: Quickly identifies jobs that have stopped running due to errors.
*   **Migration**: Helps inventory legacy jobs that should be migrated to the modern `DBMS_SCHEDULER`.
