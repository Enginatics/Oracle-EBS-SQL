# Case Study & Technical Analysis: DBA Resource Limits

## Executive Summary
DBA Resource Limits shows the current and highest utilization, since instance startup, of the database resources that cap connections and transactions, such as processes, sessions and transactions, against their configured limits. It helps DBAs of Oracle E-Business Suite databases detect when the instance is approaching or has reached a limit, the point at which new connections fail. The report is intended for DBA operations teams who monitor capacity and for administrators who want a scheduled warning before users are affected.

## Business Challenge
*   **Connection Failures:** When the processes or sessions limit is reached, new logons fail with ORA-00020 or ORA-00018, which stops users from working.
*   **Hidden Peak Usage:** Current utilization shows the load at one moment, but the highest value since startup shows whether the limit was reached earlier.
*   **Capacity Planning:** Without a comparison against the configured limits, the team cannot judge how much headroom remains.
*   **Pluggable Database Differences:** In a container database the resource views differ between the root and the pluggable databases, so the same check needs different handling.

## The Solution
*   **Limit Comparison:** Each resource is shown with its current utilization, its maximum utilization and its configured limit, and the two percentages are calculated against the limit.
*   **Sorting by Pressure:** Rows are ordered by the highest percentage, so the resources closest to their limits appear first.
*   **Fallback For Containers:** Where the resource limit view is empty, as in the container root, the report compares current processes and sessions with their parameter values.
*   **Alert Scheduling:** The Max Percent From parameter lets the report be scheduled so that output is produced only when a limit is nearly reached.

## Technical Architecture (High Level)
### Primary Tables
*   `GV$RESOURCE_LIMIT`: the cluster-wide view of resource usage, with current and maximum utilization and the limit values.
*   `GV$PROCESS`: used to count current processes for each instance in the fallback branch.
*   `GV$SESSION`: used to count current sessions for each instance in the fallback branch.
*   `GV$PARAMETER`: supplies the processes and sessions parameter values for the fallback branch.

### Logical Relationships
1.  The first branch reads every row of `GV$RESOURCE_LIMIT` for each instance, trimming the initial allocation and limit text.
2.  The second branch, combined with UNION ALL, reads the processes and sessions parameters from `GV$PARAMETER` and only runs when `GV$RESOURCE_LIMIT` returns no rows for the instance.
3.  For processes, the current count is taken from `GV$PROCESS`; for sessions, it is taken from `GV$SESSION`.
4.  An outer query calculates the current and maximum percentages against the numeric limit, leaving them empty where the limit is UNLIMITED or zero.
5.  Rows are ordered by the larger of the two percentages, then by instance and resource name.

## Parameters & Filtering
*   **Max Percent From:** Returns only resources whose maximum percentage is at or above the entered value, for example 90. This is the parameter used for scheduled alerts.
*   **Instance Id:** Restricts the output to one instance of a RAC cluster.

## Performance & Optimization
*   **Small Resource Set:** The resource list is short, so the aggregation over sessions and processes is the main cost and is bounded by the number of connections.
*   **Correlated Count Per Instance:** Process and session counts are computed per instance with correlated subqueries, which keeps the counts aligned with each instance.
*   **Conditional Fallback:** The second branch is guarded by a NOT EXISTS test, so it adds work only when the resource limit view is unavailable.
*   **Ordering on the Computed Percentage:** Sorting by the larger percentage places the most constrained resources first without any additional query.

## FAQ
**Q: What does a Max Percent close to 100 mean?**
A: The instance reached that percentage of the configured limit at some point since startup. For processes or sessions, reaching 100 means new connections were refused at that point.

**Q: Why does my pluggable database show only processes and sessions?**
A: In a pluggable database the resource limit view shows data only in the container root. The report then compares current processes and sessions with their parameter values, without the highest utilization.

**Q: How can the report warn me before users are affected?**
A: Schedule the report with Max Percent From set to 90. The scheduled run then sends output only when a resource has reached that share of its limit.
