# Case Study & Technical Analysis: DBA Hierarchical Profiler Data

## Executive Summary
The DBA Hierarchical Profiler Data report is an Excel view of the output of Oracle's hierarchical profiler, the `DBMS_HPROF` PL/SQL performance analysis package. It is written for database administrators and Oracle EBS technical teams who must find where PL/SQL code spends its time, for example a slow custom concurrent program, a form customisation or an API call. For each function in a profiled run, it shows the elapsed time, the share of total run time, the number of calls, the owning module, the line number and the source text.
## Business Challenge
*   **Locating PL/SQL hotspots:** When a customised process is slow, the DBA needs to know which function or line consumes the elapsed time, not only that the process is slow.
*   **Separating self time from subtree time:** Total time for a function includes the functions it calls, so the report must show both the function time and the subtree time to find the real cost.
*   **Tracing back to source:** The profiler records line numbers, and the team needs the source text at that line to act on the finding.

## The Solution
*   **Function-level breakdown:** Each function in a run is listed with its elapsed time, percentage of the run total, call count and owning module.
*   **Time units:** Elapsed times are converted from microseconds into seconds or milliseconds, as selected by the Time Unit parameter.
*   **Source text lookup:** A helper function reads the line of source from `DBA_SOURCE` for each profiled line, so the code appears next to its timing.
*   **Excel analysis:** Running the report through Blitz Report puts the profile into a sortable sheet for filtering by module, line or percentage.

## Technical Architecture (High Level)
### Primary Tables
*   `DBA_SOURCE`: the PL/SQL source text, queried through a helper function to return the line that corresponds to each profiled line.
*   `DBMSHP_RUNS`: one row per profiling run, holding the run timestamp and total elapsed time.
*   `DBMSHP_FUNCTION_INFO`: one row per function per run, holding the function, module, SQL identifier, elapsed time, calls and line number.
*   `DBMSHP_PARENT_CHILD_INFO`: the parent and child relationships between profiled functions in each run.

### Logical Relationships
1. `DBMSHP_RUNS` joins to `DBMSHP_FUNCTION_INFO` on the run identifier, giving each function the run date and total time.
2. The parent-child data is reduced to distinct run and parent symbol identifiers, then joined to the function rows as an outer join, so only functions with children show a subtree time.
3. The helper function looks up `DBA_SOURCE` by unit type, owner, name and line number, and returns the text of that line, or null if none is found.
4. The outer query sorts by run identifier descending and then by time descending, so the most expensive functions of the latest run appear first.

## Parameters & Filtering
*   **Run Id:** Restricts the output to one profiling run.
*   **Module:** Limits the functions to one PL/SQL unit, identified by its module name.
*   **Time From:** Filters the functions by elapsed time above a threshold.
*   **Percentage From:** Filters to functions whose share of the run total is at or above a given percentage.
*   **Line Text Contains:** Restricts the rows to those whose source line contains the given text.
*   **Line Number From and Line Number To:** Bound the source lines of the functions returned.
*   **Time Unit:** Selects whether elapsed time is shown in seconds or milliseconds, and the SQL divides the stored microsecond values accordingly.

## Performance & Optimization
*   **Run-scoped reading:** The profiler tables are read per run, and the run identifier is the natural filter for keeping the query to a single profile.
*   **Distinct parent-child reduction:** The parent-child table is collapsed to distinct run and parent identifiers before the join, which prevents the join from multiplying function rows.
*   **Analytic percentage:** The percentage of each function is computed with a window sum over the run identifier, so no second pass over the data is needed.

## FAQ
**Q: Why does my PL/SQL profile not show any functions?**
A: The description states that units compiled in NATIVE mode cannot be profiled. The code must be compiled with `plsqlcodetype=interpreted` before profiling starts.

**Q: What is the difference between the time and subtree time columns?**
A: Time is the elapsed time spent in the function itself, and subtree time is the inclusive time including the functions it calls, shown only where the function has children.

**Q: How do I stop the profiler data from accumulating?**
A: The description gives the purge steps: truncate the four profiler tables and restart the run and trace number sequences, as the SYS user.
