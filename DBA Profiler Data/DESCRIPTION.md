# Case Study & Technical Analysis: DBA Profiler Data

## Executive Summary
This report presents the output of Oracle's DBMS_PROFILER PL/SQL performance profiler in Excel. It shows each profiled run with its total elapsed time, the PL/SQL time, and for every program unit and source line the number of calls, the time spent and the share of the run. The source text of each line is retrieved from the data dictionary, so the performance analyst sees the code next to its cost. Database administrators and Oracle EBS technical consultants use it to find the custom or seeded PL/SQL that dominates a slow process. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Slow custom code:** Long-running EBS concurrent programs and custom packages often hide their cost in a few lines of PL/SQL.
*   **Raw profiler tables:** The profiler tables store run, unit and line data in separate tables that are hard to read without joins.
*   **Missing source context:** A line number means little without the code it refers to, and the source must be fetched from the dictionary.
*   **Repeat analysis:** Comparing runs before and after a change requires consistent figures for each run.

## The Solution
*   **Run summary:** Each run carries its run date, total elapsed time and PL/SQL time, so runs can be compared directly.
*   **Unit and line detail:** Each line shows its unit, number of calls, total time and percentage of the run's PL/SQL time.
*   **Source text:** A function retrieves the text of each profiled line from the dictionary source view.
*   **Time units:** The Time Unit parameter presents times in seconds or microseconds.
*   **Ranking:** Rows are ordered by run, then by time descending, so the most expensive lines appear first.

## Technical Architecture (High Level)
### Primary Tables
*   `PLSQL_PROFILER_RUNS`: one row per profiling run, with run date, run comment and total elapsed time.
*   `PLSQL_PROFILER_UNITS`: one row per profiled program unit within a run, with unit type, owner and name.
*   `PLSQL_PROFILER_DATA`: one row per source line within a unit, with calls, total time and line number.
*   `DBA_SOURCE`: the source text of each program unit, read through the line-text function.

### Logical Relationships
1. `PLSQL_PROFILER_RUNS` joins to `PLSQL_PROFILER_UNITS` on run id.
2. `PLSQL_PROFILER_UNITS` joins to `PLSQL_PROFILER_DATA` on run id and unit number.
3. Each line's text is returned by a function that matches the unit type, owner, name and line number in `DBA_SOURCE`.
4. Percentage and PL/SQL time are computed as analytic windows partitioned by run id over the line rows.

## Parameters & Filtering
*   **Run Id:** restricts the output to one profiling run.
*   **Module:** restricts the output to one program unit, given as owner and name.
*   **Time From:** keeps only lines whose time is at or above the value entered.
*   **Percentage From:** keeps only lines whose share of the run is at or above the value entered.
*   **Line Text Contains:** keeps only lines whose source text includes the search text.
*   **Line Number From / Line Number To:** bound the lines by their position in the program unit.
*   **Time Unit:** selects seconds or microseconds for all time values.

## Performance & Optimization
*   The time and percentage filters are applied after the analytic totals, so each percentage reflects the full run rather than the filtered rows.
*   The source lookup is a function on the dictionary source view that runs for each returned line, so the Module and Line Number filters should be used to limit the rows.
*   Results are ordered by run and time descending, so the most expensive lines of the latest run are at the top of the sheet.

## FAQ
**Q: Why is my PL/SQL profile empty?**
A: DBMS_PROFILER cannot profile units compiled in native mode. The code must be compiled as interpreted before profiling starts.

**Q: How do I start and stop profiling?**
A: Call the start and stop procedures of the DBMS_PROFILER package around the code under test, as described in Oracle note KB85737.

**Q: How do I clear old profiler data?**
A: The profiler tables are truncated and the run number sequence is restarted by a SYS user, as the report's description states.
