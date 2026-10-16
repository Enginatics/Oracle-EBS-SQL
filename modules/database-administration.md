---
layout: default
last_modified_at: 2026-10-16
title: 'Oracle EBS Database Administration Reports | 73 SQL reports'
description: '73 free Oracle E-Business Suite Database Administration SQL reports for Excel: DBA ASM Disk Groups, DBA AWR Active Session History, DBA AWR Blocking…'
keywords: 'Oracle EBS Database Administration reports, Oracle Database Administration SQL, Oracle E-Business Suite, Blitz Report, dba_hist_snapshot, dba_objects, v$parameter, dual, gv$sqlarea'
permalink: /modules/database-administration/
module: 'Database Administration'
module_page: true
---

# Oracle EBS Database Administration Reports

73 ready-to-run SQL reports for **Oracle E-Business Suite Database Administration**, maintained by Enginatics and used in production at Oracle EBS customers worldwide. Each report page lists its parameters, the Oracle EBS tables it reads and an Excel example output. The most frequently used Database Administration tables in these reports are `dba_hist_snapshot`, `dba_objects`, `v$parameter`, `dual`, `gv$sqlarea`, `obj$`.

> **Run any of these reports in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration) – your first 30 reports are free.

## Database Administration SQL Reports

| Report | Description |
|---|---|
| [DBA ASM Disk Groups](/DBA%20ASM%20Disk%20Groups/) | Automatic Storage Management disk groups used by the database, with their redundancy, total and free space. All sizes are shown in MB. Usable File Mb is the… |
| [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/) | Active session history from the automatic workload repository |
| [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/) | Summary of blocked and blocking sessions based on the active session history from the AWR. The link to blocking sessions is deliberately nonunique without… |
| [DBA AWR CPU Load (active session history)](/DBA%20AWR%20CPU%20Load%20%28active%20session%20history%29/) | Aggregates active sessions by snapshot time to identify times with high CPU load over a specific 'CPU Sessions From' threshold value. |
| [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/) | Summary of database CPU vs. wait times and average active sessions for a specified time frame To see data in this report based on dbahistsystimemodel, set the… |
| [DBA AWR Interconnect Traffic](/DBA%20AWR%20Interconnect%20Traffic/) | Displays information about the usage of an interconnect device by instance in a RAC configuration. ipq - Parallel query communications dlm - Database lock… |
| [DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/) | Summary of latch statistics such as misses and wait times for a specified snapshot time interval |
| [DBA AWR Latch by Time](/DBA%20AWR%20Latch%20by%20Time/) | Latch contention wait time history. Each row shows the system-wide latch contention wait time per latch name of one AWR snapshot interval to identify high… |
| [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/) | History of database PGA size and other statistics from v$pgastat in megabytes |
| [DBA AWR SQL Execution Plan History](/DBA%20AWR%20SQL%20Execution%20Plan%20History/) | Execution plan history for a particular SQL id from the automatic workload repository |
| [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/) | Database SQL performance summary from the Automatic Workload Repository (AWR) tables to give an overview of top SQL load and performance issues. The report… |
| [DBA AWR Settings](/DBA%20AWR%20Settings/) | Automatic workload repository settings such as retention period, snapshot interval and number of top SQLs to capture (from table underlying the view… |
| [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/) | Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write IO… |
| [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/) | Historic system time model values from the automated workload repository showing a breakdown of how much percent of the database time was spent e.g. on… |
| [DBA AWR System Time Summary](/DBA%20AWR%20System%20Time%20Summary/) | Historic system time model values from the automated workload repository showing how the database time was spent e.g. on excuting SQL, PL/SQL or Java code… |
| [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/) | Tablespace usage over time from the AWR |
| [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/) | Non idle session wait times by wait class over time. Each row shows the system-wide wait time per wait class of one AWR snapshot interval to identify unusual… |
| [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/) | Summary of wait times by wait event and event class for a specified snapshot time interval. Use the Session Type parameter to restrict either to foreground… |
| [DBA AWR Wait Event Summary (active session history)](/DBA%20AWR%20Wait%20Event%20Summary%20%28active%20session%20history%29/) | Wait event and CPU usage summary from the AWR active session history. |
| [DBA Alert Log](/DBA%20Alert%20Log/) | V$DIAGALERTEXT shows the contents of the XML-based alert log in the Automatic Diagnostic Repository (ADR) for the current container (PDB). You could schedule… |
| [DBA Archive / Redo Log Rate](/DBA%20Archive%20-%20Redo%20Log%20Rate/) | If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown. For databases on NOARCHIVELOG, the approximate amount of generated… |
| [DBA Automated Maintenance Tasks](/DBA%20Automated%20Maintenance%20Tasks/) | There are several automated jobs and 'advisors' running by default in an Oracle database that are often not required or should not run in Oracle EBS… |
| [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/) | Chain of currently blocking and blocked database sessions from v$waitchains |
| [DBA CPU Benchmark1](/DBA%20CPU%20Benchmark1/) | Benchmark report to measure a database server's CPU speed, mainly for PLSQL processing. This report generates an output file of 500000 out of a total of 561495… |
| [DBA CPU Benchmark2](/DBA%20CPU%20Benchmark2/) | Benchmark report to measure a database server's CPU speed, mainly for PLSQL processing. This report generates an output file of 200000 records from dual. As… |
| [DBA CPU Benchmark3](/DBA%20CPU%20Benchmark3/) | This Benchmark report measures a database server's CPU performance for arithmetic calculations by calculating about 40 million square roots. example… |
| [DBA Data Files](/DBA%20Data%20Files/) | Data and temp files per tablespace with their size, free space, autoextend settings and the space still available up to the maximum size. All sizes are shown… |
| [DBA Database Links](/DBA%20Database%20Links/) | Database links with their owner, remote user and connect string. |
| [DBA Database Parameter Validation](/DBA%20Database%20Parameter%20Validation/) | Replicates the database initialization-parameter validation performed by Oracle's EBS Database Performance and Statistics Analyzer (My Oracle Support Doc… |
| [DBA Dependencies (used by)](/DBA%20Dependencies%20%28used%20by%29/) | Hierarchical report showing all database objects using the specified object, e.g. a certain table and the report shows all the views or packages that are… |
| [DBA Dependencies (uses)](/DBA%20Dependencies%20%28uses%29/) | Hierarchical report showing all dependent database objects that a specified object, e.g. a view or package name uses or depends on (top to bottom) |
| [DBA Directories](/DBA%20Directories/) | Database directory objects with their operating system path and the users granted read, write or execute access to them. |
| [DBA Editioned Object Summary](/DBA%20Editioned%20Object%20Summary/) | Summary of editioned objects per edition from ADZDSHOWOBJS.sql There is a good blog: https://www.pythian.com/blog/technical-track/adop-edition-cleanup |
| [DBA Editions](/DBA%20Editions/) | Database editions, their type and status |
| [DBA External Table Creation](/DBA%20External%20Table%20Creation/) |  |
| [DBA Feature Usage Statistics](/DBA%20Feature%20Usage%20Statistics/) | Database license feature usage statistics, such as the number of times that an AWR HTML report was run |
| [DBA Hierarchical Profiler Data](/DBA%20Hierarchical%20Profiler%20Data/) | Excel version of Oracle's hierarchical profiler dbmshprof PLSQL performance analysis. PL/SQL units that have been compiled in NATIVE mode cannot be profiled… |
| [DBA Index Columns](/DBA%20Index%20Columns/) |  |
| [DBA Jobs](/DBA%20Jobs/) |  |
| [DBA Log Switches](/DBA%20Log%20Switches/) |  |
| [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/) | Validates the Oracle REST Data Services (ORDS) configuration for Blitz Report webservices. Checks: ORDS schema enablement and URL mapping, REST module status… |
| [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/) | Database object privileges for a specific user, including privileges inherited through role grants. Useful for DB access security audits to understand exactly… |
| [DBA Objects](/DBA%20Objects/) | All database objects |
| [DBA Parameters](/DBA%20Parameters/) | To validate recommended settings validate following notes: Database Initialization Parameters for Oracle E-Business Suite Release 12 (Doc ID 396009.1) EBS… |
| [DBA Profiler Data](/DBA%20Profiler%20Data/) | Excel version of Oracle's dbmsprofiler PLSQL performance analysis, see Oracle note: Using DBMSPROFILER (KB85737)… |
| [DBA Redo Log Files](/DBA%20Redo%20Log%20Files/) |  |
| [DBA Registry](/DBA%20Registry/) | Database components installed, such as Oracle Text, JServer or XML Database, with their version and status. A component with a status other than VALID can… |
| [DBA Registry SQL Patch](/DBA%20Registry%20SQL%20Patch/) | DBAREGISTRYSQLPATCH contains information about the SQL patches that have been installed in the database. A SQL patch is a patch that contains SQL scripts which… |
| [DBA Resource Limits](/DBA%20Resource%20Limits/) | Current and highest utilization since instance startup of database resources such as processes, sessions and transactions, compared to their limits. A Max… |
| [DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/) | Shows result cache objects with the current number of cached results, the number of times these results were found and reused (scan count) and their dependency… |
| [DBA Result Cache Statistics](/DBA%20Result%20Cache%20Statistics/) | Result cache statistics with size values in MB. If the 'Maximum Size' is big enough, 'Create Count Failure' should be zero or low, same as 'Delete Count… |
| [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/) | Active session history from the SGA. Parameter 'Blocked Sessions only' allows a blocking scenario root cause analysis, e.g. by doing a pivot in Excel (see… |
| [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/) | Summary of blocked and blocking sessions based on the active session history from the SGA. The link to blocking sessions is deliberately nonunique without… |
| [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/) | SGA buffer cache space usage by object names (in MB). 'Object Percentage' shows how much of one particular object is currently stored in the buffer cache. 100%… |
| [DBA SGA CPU Load (active session history)](/DBA%20SGA%20CPU%20Load%20%28active%20session%20history%29/) | Aggregates active sessions by snapshot time to identify times with high CPU load over a specific 'CPU Sessions From' threshold value. |
| [DBA SGA Memory Allocation](/DBA%20SGA%20Memory%20Allocation/) | Current SGA memory usage in gigabytes, showing the split between buffer cache and shared pool |
| [DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/) | Execution plan history for a particular SQL id from the SGA |
| [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/) | Database SQL performance summary from the SGA to give an overview of top SQL load and performance issues. The purpose of this report, compared to 'DBA AWR SQL… |
| [DBA SGA Target Advice](/DBA%20SGA%20Target%20Advice/) | Orace's SGA target advice view. It shows an estimation of how an SGA resize would affect overall database time and IO. |
| [DBA SGA Wait Event Summary (active session history)](/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/) | Wait event and CPU usage summary from the SGA active session history. |
| [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/) | Current SGA and PGA memory configuration in gigabytes. A frequent configuration problem is not making full use of the available hardware resources, especially… |
| [DBA SYSAUX Occupants](/DBA%20SYSAUX%20Occupants/) | Space used in the SYSAUX tablespace by component. All sizes are shown in MB. The largest occupants are usually the AWR (SM/AWR) and the optimizer statistics… |
| [DBA Scheduler Jobs](/DBA%20Scheduler%20Jobs/) |  |
| [DBA Segments](/DBA%20Segments/) | Database segments such as tables, indexes, lob segments by size and total database size summary |
| [DBA Session Longops](/DBA%20Session%20Longops/) | Estimated time to completion for long running sessions based on gv$sessionlongops |
| [DBA Sessions](/DBA%20Sessions/) | Current database sessions with their Oracle EBS user, responsibility, form or concurrent request, the SQL being executed, wait event, blocking session, and… |
| [DBA Table Columns](/DBA%20Table%20Columns/) | Report with all table column names based on dbatabcolumns, as finding tables by column names is a frequent task during SQL development |
| [DBA Table Modifications](/DBA%20Table%20Modifications/) | If table monitoring is activated, dbatabmodifications shows the number of rows modified since the last time a table was analyzed. |
| [DBA Tablespace Usage](/DBA%20Tablespace%20Usage/) | Tablespace usage including currently active undo and temp tablepace usage in Megabytes |
| [DBA Text Search](/DBA%20Text%20Search/) | Full text search through database source code objects such as packages, procedures, functions, triggers etc. The search can also be done using regular… |
| [DBA Trace File Contents](/DBA%20Trace%20File%20Contents/) | V$DIAGTRACEFILECONTENTS contains trace data that is present in the trace files that are part of the current Automatic Diagnostic Repository (ADR). Supported… |
| [DBA Undo Statistics](/DBA%20Undo%20Statistics/) | Undo generation, longest running query and undo errors per 10-minute interval from gv$undostat, which keeps about four days of history. All sizes are shown in… |
| [DBA Users](/DBA%20Users/) | Database user accounts with their status, lock and expiry dates, profile, tablespaces and quotas. Default Password flags accounts that still have an… |

[← All Oracle EBS modules](/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=module-database-administration)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
