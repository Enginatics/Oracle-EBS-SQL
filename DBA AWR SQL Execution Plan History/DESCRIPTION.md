# Executive Summary
The **DBA AWR SQL Execution Plan History** report is a critical tool for diagnosing "Plan Flipping" or "Plan Regression". It tracks how the execution plan for a specific SQL statement has changed over time. In Oracle, the Optimizer decides the best way to execute a query (which index to use, join order, etc.). Sometimes, this plan changes for the worse, causing a query that used to take 1 second to suddenly take 1 hour.

# Business Challenge
*   **Performance Regression**: "This report was fast yesterday. Today it's slow. Nothing changed in the code."
*   **Upgrade Analysis**: "Did the database upgrade cause the Optimizer to pick a bad plan for our critical payroll query?"
*   **Index Impact**: "Did dropping that index cause the query to switch to a full table scan?"

# Solution
This report lists all execution plans captured in AWR for a given SQL ID.

**Key Features:**
*   **Plan Hash Value**: A unique identifier for the plan structure. A change in this value confirms the plan changed.
*   **Cost**: The Optimizer's estimated cost for the plan.
*   **Timestamp**: When the plan was first and last seen.

# Architecture
The report queries `DBA_HIST_SQL_PLAN`.

**Key Tables:**
*   `DBA_HIST_SQL_PLAN`: Stores the steps of the execution plan.
*   `DBA_HIST_SQLSTAT`: Links the plan to performance metrics.

# Impact
*   **Stability**: Allows DBAs to identify unstable queries and lock down their plans (using SQL Profiles or Baselines).
*   **Root Cause Analysis**: Definitively proves whether a performance drop was caused by a plan change.
*   **Recovery**: Provides the "good" plan hash value needed to restore performance.
