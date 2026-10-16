# Case Study & Technical Analysis: AD ADOP Sessions

## Executive Summary
The AD ADOP Sessions report lists the Online Patching (adop) sessions of Oracle E-Business Suite Release 12.2, with one row per node and per phase. For each phase it shows the status, start and end time, duration in seconds and minutes and, for the Apply phase, the patches applied in that session. Applications DBA teams use it to follow a patching cycle node by node, to see where an interrupted session stopped and to document what each session delivered. Run in Excel through Blitz Report, it gives a phase timeline that would otherwise require querying the AD patching tables directly.

## Business Challenge
*   **Phase visibility:** A session moves through the Prepare, Apply, Finalize, Cutover, Cleanup and Abort phases, but `AD_ADOP_SESSIONS` stores each phase's status and dates as separate column groups on one row per node, which makes the progress of a session hard to read.
*   **Duration tracking:** Patching windows are planned in hours, so DBAs need the run time of each phase to compare sessions and to explain overruns.
*   **Patch traceability:** Change records and rollback decisions require the list of patches that a given session applied on each node.
*   **Incomplete sessions:** A session that has not completed needs to be found quickly, so the DBA can decide whether to resume it or abort it.

## The Solution
*   Unpivots the six phase column groups of `AD_ADOP_SESSIONS` into one row per phase by means of a row generator, so every node and phase has its own status, start date and end date.
*   Translates the status codes into readable values (Completed, Failed, Running, Not Started) and removes phases whose status is X, which do not apply to the session.
*   Calculates the duration of each phase in seconds, formatted with xxen_util.time, and in minutes.
*   Lists the bug numbers recorded in `AD_ADOP_SESSION_PATCHES` against the Apply row of each node as one comma-separated value.

## Technical Architecture (High Level)
### Primary Tables
*   `AD_ADOP_SESSIONS`: one row per node and session, holding the status and the start and end dates of each of the six phases.
*   `AD_ADOP_SESSION_PATCHES`: the patches applied in a session, identified by session and node name, read only for the Apply phase.

### Logical Relationships
1.  `AD_ADOP_SESSIONS` is joined to `xxen_util.rowgen(6)`, which returns the phase numbers 1 to 6. Each phase number selects the matching status, start date and end date through DECODE, and the phase name is derived the same way.
2.  The inner query removes phases whose status is X. The outer query orders the rows by session id descending, node name and phase number.
3.  For rows whose phase is Apply, a correlated subquery on `AD_ADOP_SESSION_PATCHES` matches on the session id and node name and aggregates the bug numbers with LISTAGG.
4.  Start and end dates are converted with xxen_util.client_time, and the Duration and Minutes columns are computed from the same unpivoted dates.

## Parameters & Filtering
*   **Session Id:** restricts the output to one adop session.
*   **Start Date From:** keeps only the sessions that started on or after the date entered.
*   **Incomplete only:** limits the output to sessions that have not completed. The SQL text does not write this predicate out; it carries 1=1 placeholders where the report framework adds the parameter conditions.

## Performance & Optimization
*   The row generator produces six rows per node from a single pass over `AD_ADOP_SESSIONS`, so no separate query per phase is needed.
*   Phases with status X are removed in the outer WHERE clause, which keeps the output short for sessions that run only part of the phases.
*   The patch list is a correlated subquery that the CASE expression evaluates only for the Apply phase, so the bug numbers are not aggregated for the other five phases.
*   Session Id and Start Date From are the most effective filters on a large session history, because the report sorts every row it returns.

## FAQ
**Q: How do I see which patches an adop session applied?**
A: Run the report for the session id. The Patches column on the Apply row lists the bug numbers from `AD_ADOP_SESSION_PATCHES` for that node, separated by commas.

**Q: Why does a phase not appear in the output?**
A: Phases whose status is X do not apply to the session, and the report hides them. A hotpatch session, for example, shows only the Apply phase.

**Q: How is the duration of a phase calculated?**
A: Duration is the difference between the phase end date and start date multiplied by 86,400 and formatted with xxen_util.time. Minutes is the same difference multiplied by 1,440.
