# Case Study & Technical Analysis: DBA SYSAUX Occupants

## Executive Summary
The DBA SYSAUX Occupants report shows how the SYSAUX tablespace space is used, broken down by component. Each row is an occupant, such as the Automatic Workload Repository or the optimizer statistics history, with its schema, space used in MB, and its share of the total. Database administrators use it when SYSAUX grows unexpectedly, when planning storage, or when deciding whether to reduce a retention period. The report has no parameters, and its rows are sorted by space used, so the largest consumers appear first.

## Business Challenge
*   **Unexplained SYSAUX growth:** SYSAUX holds the auxiliary data of many database features, and its growth is often attributed to the wrong component without a breakdown.
*   **Retention decisions:** Components such as workload repository snapshots and statistics history grow with their retention settings, and the cost of a longer retention needs to be seen in MB.
*   **Capacity planning:** Storage teams need the share each component takes, so they can plan space for SYSAUX and the instance as a whole.
*   **Relocation options:** Some occupants can be moved to another tablespace, and their move procedures need to be identified before a change is made.

## The Solution
*   **Component inventory:** Every occupant of SYSAUX is listed with its name, description and owning schema.
*   **Space and share:** Space used is shown in MB, and a percentage column shows each occupant's share of total SYSAUX usage.
*   **Statistics history retention:** For the optimizer statistics history occupant, the report shows the configured retention in days and the oldest statistics still available.
*   **Move guidance:** The move procedure and its description are shown for each occupant that supports relocation.

## Technical Architecture (High Level)
### Primary Tables
*   `V$SYSAUX_OCCUPANTS`: the dynamic view that lists each SYSAUX occupant with its schema, space usage in kilobytes and move procedure.

### Logical Relationships
1.  The report reads `V$SYSAUX_OCCUPANTS` as a single source. No joins are used.
2.  The share of total usage is calculated with a ratio-to-report analytic function over all occupant rows.
3.  For the statistics history occupant only, the report calls the statistics history retention and availability functions, and converts the availability date for display.
4.  The result is sorted by space usage in descending order.

## Parameters & Filtering
This report has no user parameters. It always returns every occupant of SYSAUX, so filtering is done by reading the sorted output rather than by changing the query.

## Performance & Optimization
*   **Single dynamic view:** The report reads one dynamic performance view with no joins, so the query is a single read of the occupant list.
*   **Analytic share calculation:** The percentage column uses a ratio-to-report function, so each occupant's share is computed in the same pass without a separate total query.
*   **Conditional function calls:** The statistics retention and availability functions are called only for the optimizer statistics history row, so the other rows do not trigger them.
*   **Sorted at source:** Ordering by space usage lets the largest occupants be read first.

## FAQ
**Q: Which SYSAUX occupants usually take the most space?**
A: The description notes that the largest occupants are usually the AWR (SM/AWR) and the optimizer statistics history (SM/OPTSTAT), and the report sorts them to the top.
**Q: How do I reduce the space used by optimizer statistics history?**
A: The description says a lower retention, set with the DBMS_STATS alter statistics history retention procedure, reduces SYSAUX space used. The SM/OPTSTAT row shows the current retention in days.
**Q: Why does the report have no parameters?**
A: It lists every occupant of SYSAUX, so there is no selection to make, and the output is already sorted by space used.
