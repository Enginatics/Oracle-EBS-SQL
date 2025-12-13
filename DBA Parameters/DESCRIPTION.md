# Executive Summary
The **DBA Parameters** report audits the database initialization parameters (`init.ora` / `spfile`). These parameters control every aspect of the database's behavior, from memory allocation (`sga_target`) to optimizer behavior (`optimizer_features_enable`). Incorrect parameters are a leading cause of performance issues and instability.

# Business Challenge
*   **Standardization**: "Does our Production database have the same parameters as our Test database?"
*   **Performance Tuning**: "Is `cursor_sharing` set to `EXACT` or `FORCE`?"
*   **Change Tracking**: "Who changed `open_cursors` from 1000 to 500?"

# Solution
This report lists the current value of all database parameters.

**Key Features:**
*   **Is Default**: Indicates if the parameter is set to its default value or has been overridden.
*   **Is Modified**: Shows if the parameter was changed in the current session.
*   **RAC Consistency**: In a RAC environment, checks if parameters are consistent across all instances.

# Architecture
The report queries `GV$PARAMETER`.

**Key Tables:**
*   `GV$PARAMETER`: The in-memory view of active parameters.

# Impact
*   **Stability**: Prevents "drift" where configuration changes are made in one environment but not others.
*   **Best Practices**: Allows DBAs to validate settings against Oracle Support recommendations (e.g., "bde_chk_cbo.sql").
*   **Troubleshooting**: Quickly rules out misconfiguration as the cause of a new issue.
