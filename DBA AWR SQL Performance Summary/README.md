# [DBA AWR SQL Performance Summary](https://www.enginatics.com/reports/dba-awr-sql-performance-summary/)
## Description: 
Database SQL performance summary from the automatic workload repository (AWR) tables to give an overview of top SQL load and performance issues.
The report shows the summarized execution stats such as elapsed time and IO figures for a certain timeframe for individual SQL_ID and plan hash value combinations.
All IO figures are shown in MB.

Parameter 'Level' can be switched to aggregate data either by Module or by individual SQL and to show summarised figures or to split them by day.
Parameter 'Time Restriction' can be set to show either daytime or nightbatch figures only.

For SQL IO tuning or database server load optimization, a sorting by IO is recommended to show the most IO intensive SQLs on top.
Non server or SQL IO related performance bottlenecks, such as wait time caused by Network e.g. 'SQL*Net message from dblink', can be spotted when sorting by 'elapsed time' instead of IO.

Columns:

- Responsibility: Derived from the SGA's action column for initialized EBS sessions.
- Module Name: Derived from the SGA's module column for initialized EBS sessions.
- Module: SGA's module. Please note that if the same SQL is executed by different modules, it appears only once in this report. Thus, the module name column could be misleading as it shows the name of the first module parsing the SQL only.
-Code and Code Line#: Code package and line number of the SQL, in case it is still in the cursor cache
-Sql Id: Hash identifier for an individual SQL.
-Plan Hash Value: Hash identifier for one particular execution plan. Please note that similar but different SQLs might share exactly the same plan hash value if their execution path is identical.
-Sql Text
-Executions: Total number of executions
-Elapsed Time: Total elapsed time in seconds
-Time: Total elapsed time in a readable format split into days, hours, minutes and seconds
-User Io Wait Time: Total elapsed time in seconds from wait event class 'User I/O'
-Cpu Time: Total elapsed time in seconds that the SQL spent on CPU. High figures here usually indicate that massive amounts of data are read from the buffer cache
-Plsql Exec Time: Total elapsed time in seconds for PLSQL execution
-Concurrency Wait Time: Total elapsed time in seconds from wait event class 'Concurrency' e.g. 'buffer busy waits' or 'enq: TX - index contention'
-Application Wait Time: Total elapsed time in seconds from wait event class 'Application' e.g. 'enq: TX - row lock contention', an uncommitted session's update blocking another session.
-Time Exec: Average elapsed time per execution
-Buffer IO: Total buffer IO in megabtes. This is the most important figure to look at from a server load perspective.
-Disk IO: Total physical IO
-IO Exec: Total IO per execution.
-Rows Exec: Average number of rows per execution
-IO Row: Average IO per individual row retrieved. For data extraction SQLs without any sort of data aggregation, the average IO per row is a good indication if the IO spent is reasonable or if the SQL executes efficiently or not.
-IO Sec: Average IO in MB per second during SQL execution time.
-IO Sec Avg: Average IO in MB per second per overall server time (to indicate the average IO server load of the individual SQL).
-Execs Per Hour: Number of SQL executions per hour
-Time Percentage: Average percentage of the overall server time that the SQL is running. 50% indicates a SQL is running half of the server time, 400% means the same SQL is running constantly 4 times in parallel
-Is Bind Sensitive: Indicates the DB's 'adaptive cursor sharing' feature. A value of 'Y' means, the DB might consider a different explainplan for different bind values. Note that for transactional SQLs such as the ones used by Oracle EBS, the execution path should usually not change. Thus, a value of 'Y' often indicates 'instable' SQLs or SQLs where the optimizer struggles to find the best execution path.
-Is Bind Aware: 'adaptive cursor sharing' feature. A value of 'Y' means, the DB considers a differ
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic+Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
# Report Example
[DBA_AWR_SQL_Performance_Summary 25-Jan-2019 160632.xlsx](https://www.enginatics.com/example/dba-awr-sql-performance-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_AWR_SQL_Performance_Summary.sql](https://www.enginatics.com/export/dba-awr-sql-performance-summary/)\
[rep_DBA_AWR_SQL_Performance_Summary.xml](https://www.enginatics.com/xml/dba-awr-sql-performance-summary/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) that is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics