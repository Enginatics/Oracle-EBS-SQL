# Case Study & Technical Analysis: FND Gather Statistics History

## Executive Summary
The FND Gather Statistics History report shows the history of Oracle E-Business Suite statistics gathering (FNDSTATS) for each schema, table, index or column. For every gathering it gives the start time, end time, duration, estimate percentage, degree of parallelism and the concurrent request that performed it. DBAs and application support teams use it to confirm that statistics jobs completed, to spot gatherings that have become slow, and to decide when a schema or table needs fresh statistics before a performance investigation or a period-end run. The report runs in Excel via Blitz Report.

## Business Challenge
*   **Verifying statistics jobs:** Gather Schema Statistics and Gather Table Statistics runs must be confirmed as completed for the objects that matter to close and reporting processes.
*   **Diagnosing slow gatherings:** A gathering that takes longer than usual can point to growth in a schema or to a parallelism setting that has changed, and the history is needed to see the trend.
*   **Tracing to the request:** When a gathering needs investigation, the owning concurrent request and program must be identified quickly.
*   **Keeping history manageable:** Histories of frequently gathered objects grow large, and users need to see the latest gathering per object without losing the ability to review all runs.

## The Solution
*   **Per-object timing:** Start time, end time, duration in readable form and duration in seconds are shown for every gathering record.
*   **Run identification:** The concurrent request identifier is returned, together with the name of the concurrent program that made the request.
*   **Object and run filters:** The report can be restricted by schema, object type, object name pattern, request identifier, start date range and minimum duration.
*   **Recent first:** Records are ordered by start time, descending, so the latest gatherings appear first.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_STATS_HIST`: one row per gathered object, with schema, object type, object name, partition, column table, last gather start and end times, estimate percentage, parallel setting and request identifier.
*   `FND_CONCURRENT_REQUESTS`: the concurrent request that performed the gathering.
*   `FND_CONCURRENT_PROGRAMS_VL`: the translated name of the concurrent program for that request.

### Logical Relationships
1. Each `FND_STATS_HIST` row is one gathering of one object, identified by schema, object type and object name.
2. The concurrent program name is found by a correlated subquery that matches `FND_STATS_HIST.REQUEST_ID` to `FND_CONCURRENT_REQUESTS`.
3. The request's program application and concurrent program identifiers are matched to `FND_CONCURRENT_PROGRAMS_VL` to return the user concurrent program name.
4. Records are returned at the level of the statistics history table, with no further joins to the data dictionary.

## Parameters & Filtering
*   **Start Date From and Start Date To:** Bound the gathering start time to a date range, using the client time zone.
*   **Schema:** Limits the output to one schema owner.
*   **Object Type:** Limits the output to one type of object, such as a table or an index.
*   **Object Name like:** Filters object names by a pattern.
*   **Request Id:** Returns the gatherings performed by one concurrent request.
*   **Duration Minutes From:** Returns only gatherings whose duration is at least the entered number of minutes.

The description notes that the history mode Last Run keeps only the latest gathering per object. Gather Schema Statistics and Gather Table Statistics record their runs in this table.

## Performance & Optimization
*   The query reads only `FND_STATS_HIST`, and the concurrent program name is resolved by a correlated subquery that runs once per returned row, so the number of returned rows drives the cost.
*   Filters on schema, object name and start date narrow the history before the ordering step.
*   The ordering by start time, schema and object name uses the sort step of the query, so large histories should be restricted with the start date and request identifier filters.
*   Durations are computed as date differences multiplied by 86400, a simple arithmetic conversion with no additional lookups.

## FAQ
**Q: How do I check when a schema's statistics were last gathered?**
A: Filter by the Schema parameter and read the start and end times on each row; the most recent gathering appears first.

**Q: Which concurrent program gathered statistics for a given object?**
A: The Concurrent Program column shows the program name for the request identifier recorded against each gathering.

**Q: How do I find statistics gatherings that took longer than an hour?**
A: Set Duration Minutes From to 60 and review the Duration column for the matching gatherings.
