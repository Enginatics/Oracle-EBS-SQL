# Executive Summary
The **DBA Automated Maintenance Tasks** report audits the status of the Oracle Database's built-in automated maintenance jobs. In an Oracle E-Business Suite (EBS) environment, many of these default tasks (like the Automatic Optimizer Statistics Collection) conflict with EBS-specific best practices and must be disabled or carefully managed to prevent performance degradation.

# Business Challenge
*   **EBS Compliance**: Oracle EBS has its own specific method for gathering statistics (`FND_STATS`). The default database job can overwrite these with suboptimal stats, causing severe performance regressions.
*   **Resource Contention**: The "Segment Advisor" or "SQL Tuning Advisor" can consume significant I/O and CPU during their maintenance windows, potentially impacting batch jobs.
*   **Configuration Drift**: Ensuring that these jobs haven't been accidentally re-enabled during a database upgrade or patch.

# Solution
This report lists the configuration and run history of the automated tasks.

**Key Features:**
*   **Status Check**: Shows whether "Auto Optimizer Stats", "Segment Advisor", and "SQL Tuning Advisor" are Enabled or Disabled.
*   **Run History**: Shows when these jobs last ran and their duration.

# Architecture
The report queries the Scheduler and Autotask views.

**Key Tables:**
*   `DBA_AUTOTASK_WINDOW_CLIENTS`: Shows the status of tasks per maintenance window.
*   `DBA_AUTOTASK_OPERATION`: Operation details.
*   `DBA_AUTOTASK_JOB_HISTORY`: Execution logs.

# Impact
*   **Performance Stability**: Prevents the "Monday Morning Meltdown" caused by bad statistics gathered automatically over the weekend.
*   **Best Practice Adherence**: Verifies the system is configured according to Oracle Support Note 396009.1.
*   **Resource Optimization**: Reclaims system resources by disabling unnecessary background tasks.
