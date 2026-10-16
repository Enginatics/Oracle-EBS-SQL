# Case Study & Technical Analysis: DBA Sessions

## Executive Summary
This report is a live view of the database sessions connected to the Oracle E-Business Suite instance. For each session it shows the EBS user and responsibility, the form or concurrent request that owns it, the SQL being executed, the wait event, any blocking session, and the PGA, temporary and undo space it holds. It is used by DBAs during performance incidents, by support teams who must find the session behind a stuck form or request, and by administrators who need to end a runaway session safely.

## Business Challenge
*   **Finding who is blocking whom:** When users report that a form or a request hangs, the blocking session and its wait event must be identified quickly.
*   **Linking database sessions to EBS users:** The database user is usually a shared application account, so the EBS user, responsibility and program must be recovered from the session context.
*   **Runaway resource use:** Sessions can hold large amounts of temporary space, undo or PGA memory, and these need to be found and assessed.

## The Solution
*   Lists each session in the instance with its status, status duration, logon time, wait class, event and wait time.
*   Recovers the EBS user and responsibility from the Blitz Report run record when the session belongs to a report, and from the module and action information otherwise.
*   Shows the concurrent request and program for sessions that run a concurrent request, identified by the Oracle session identifier of the request.
*   Reports PGA memory allocated and used, temporary segment usage, undo blocks and records, the transaction start, and logical and physical reads per session.
*   Provides ready-made commands to kill the session, disconnect it, or kill the server process, for every session that is not a background process.

## Technical Architecture (High Level)
### Primary Tables
*   `GV$SESSION`: the active and inactive sessions of each instance, with status, module, action, wait and SQL information.
*   `GV$PROCESS`: the operating system process behind each session, used for the PGA memory and the server process identifier.
*   `GV$TEMPSEG_USAGE`: the temporary segments held by each session, with `DBA_TABLESPACES` for the block size.
*   `GV$TRANSACTION`: the active transactions, with undo blocks, undo records and the transaction start.
*   `GV$SESS_IO`: the logical and physical I/O of each session.
*   `V$PARAMETER`: the database block size used to convert undo blocks to MB.
*   `XXEN_REPORT_RUNS`: the Blitz Report run records of sessions started by Blitz Report.
*   `FND_CONCURRENT_REQUESTS` and `FND_CONCURRENT_PROGRAMS_VL`: the running concurrent requests and their program names.
*   `FND_RESPONSIBILITY_VL`: the responsibility name.
*   `DBA_PROCEDURES`: the PL/SQL entry point of the session.

### Logical Relationships
1. `GV$SESSION` is joined to `GV$PROCESS` on instance and process address, which provides the operating system process.
2. `GV$SESSION` is joined to `XXEN_REPORT_RUNS` through the run identifier that the module and action carry, and to the running concurrent request through the Oracle session identifier.
3. Temporary usage, transaction and I/O data are each aggregated per session in separate inline views, then joined on instance and session address.
4. The entry procedure is found by joining the session's PL/SQL object and subprogram identifiers to `DBA_PROCEDURES`.

## Parameters & Filtering
*   **Active only:** restricts the output to sessions that are active.
*   **Status Duration Minutes From:** lower bound on how long the session has been in its current status.
*   **Blitz Report Webservice Runs only:** restricts the output to sessions that are Blitz Report runs still executing.
*   **Blocked Sessions only:** shows the sessions that are blocked by another session.
*   **Session Type**, **User Name**, **Module Type**, **Module contains**, **Machine**, **Schema** and **Instance Id:** filter the sessions by their type, database or EBS user, module, machine, schema and instance.
*   **Request Id** and **SQL Id:** find the session of a concurrent request or of a SQL statement.
*   **Show SQL Text:** includes the text of the SQL being executed.

## Performance & Optimization
*   The temporary and undo figures are aggregated per session before the join, so the report does not repeat those scans for each session row.
*   The database block size is read from `V$PARAMETER` inside the undo subquery, which converts undo blocks to MB.
*   The run and concurrent request lookups are outer joins on identifiers, so sessions that are not reports or requests still appear.

## FAQ
**Q: How do I find the session that is blocking a form?**
A: Run the report with Blocked Sessions only set to Yes. The Blocking Inst Id and Blocking SID columns identify the blocking session.


**Q: How do I end a session safely?**
A: Use the Kill DB Session or Disconnect DB Session command for a non-background session. The Kill Server Process command ends the operating system process and should be used with care.
