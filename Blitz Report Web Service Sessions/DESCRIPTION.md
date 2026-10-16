# Case Study & Technical Analysis: Blitz Report Web Service Sessions

## Executive Summary
The Blitz Report Web Service Sessions report lists the Blitz Report runs that are executing inside a web service call and are still active. These runs come from the Excel add-in or from a Blitz FSG drilldown, and each row shows the Oracle E-Business Suite user and responsibility that started it. System administrators use it to see which reports are running, how long they have been running and how much temporary tablespace they consume, and to end a session that has become unproductive. The report is a monitoring tool for the Blitz Report server side of an installation.

## Business Challenge
*   **Stuck report runs:** The Excel clients stop waiting after 15 minutes, but the database session of a run keeps going until its query ends, so a long run holds resources that no user is waiting for.
*   **Resource contention:** Long sorts and joins consume temporary tablespace and middle-tier threads, which slows down other users.
*   **Accountability:** The administrator needs to know which user and responsibility started a run before ending it.
*   **Proactive alerts:** Operations teams want to be told about long runs before users report a slow system.

## The Solution
*   Finds the Blitz Report runs that are active in a web service call, by matching the module of the database session and the run id in the session's action attribute.
*   Shows the user name, responsibility, report name and run id of each run, taken from the Blitz Report run and report tables.
*   Calculates Running Minutes from the time of the current database call, and shows the wait event or CPU state of the session.
*   Gives the temporary space used by the session in megabytes, and a ready-made ALTER SYSTEM KILL SESSION command for each row.

## Technical Architecture (High Level)
### Primary Tables
*   `GV$SESSION`: the active database sessions, with module, action, status, last call elapsed time and client identifier.
*   `GV$PROCESS`: the operating system process of each session, used to show the process id of the database server.
*   `XXEN_REPORT_RUNS`: one row per report run, with the run id, the user who created it, the responsibility and the completion fields.
*   `XXEN_REPORTS_V`: the report name for each run.
*   `GV$TEMPSEG_USAGE` and `DBA_TABLESPACES`: the temporary segments of each session and the block size of their tablespaces.
*   `FND_RESPONSIBILITY_VL` and `FND_CONCURRENT_REQUESTS`: the responsibility name, and the concurrent requests that exclude sessions already running as concurrent programs.

### Logical Relationships
1.  `GV$SESSION` is joined to `GV$PROCESS` on instance and process address, so each session carries its operating system process id.
2.  The run id in the first part of the session's action attribute is matched to `XXEN_REPORT_RUNS`, and the run is kept only while its request id, completion date and completion message are empty.
3.  `XXEN_REPORTS_V` supplies the report name for the run, and `FND_RESPONSIBILITY_VL` supplies the responsibility name from the run's responsibility id.
4.  Temporary usage is summed per instance and session address in an inline view, then joined back to the session on the session address.
5.  Sessions that belong to an active concurrent request in `FND_CONCURRENT_REQUESTS` are excluded.

## Parameters & Filtering
*   **Running Minutes From:** shows only the runs whose elapsed time in the current database call is at least the number of minutes entered. It is the parameter to schedule when an alert on long runs is wanted.

The report has no other parameters; the list is always the current set of active web service sessions.

## Performance & Optimization
*   The session scan is limited by the module filter, which matches only Blitz Report sessions, so the report does not read the full session list of the database.
*   Temporary space usage is aggregated once per session in an inline view, rather than being computed for every row of the session list.
*   The result is ordered by the last call elapsed time, so the longest running sessions appear first.
*   The DBA_TABLESPACES lookup is a correlated subquery on the tablespace name, which returns only the block size needed for the usage calculation.

## FAQ
**Q: How do I find long-running Blitz Report web service calls?**
A: Run the report with Running Minutes From set to the threshold, for example 15. Each row is an active run, with its user, responsibility, report name and running minutes.

**Q: How do I stop a Blitz Report session that is still running?**
A: Copy the Kill Session command of the row and run it with a user who has the ALTER SYSTEM privilege. The command ends the session immediately.