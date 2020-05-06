# [DBA SGA SQL Performance Summary](https://www.enginatics.com/reports/dba-sga-sql-performance-summary/) (**https://www.enginatics.com/reports/dba-sga-sql-performance-summary/**)
## Description: 
Database SQL performance summary from the SGA to give an overview of top SQL load and performance issues.
The purpose of this report, compared to 'DBA AWR SQL Performance Summary' is to retrieve SQLs which are not in the AWR, either becasue they ran after the most recent snapshot or because their performance impact is too small to be written to the AWR (see topnsql https://docs.oracle.com/database/121/ARPLS/d_workload_repos.htm#ARPLS69140).
This is useful for example to:
-Identify SQLs executed by a particular program or UI function without running a trace. Navigate to the UI functionality first, then directly after, execute this report and restrict to the module name in question. Sort by column 'Last Active Time'
-Identify SQLs and example bind variables to reproduce a SQL execution in a DB access tool. Switch parameter 'Show Bind Values' to 'Yes'
-Identify SQLs incorrectly using literals instead of binds. Set parameter 'Literals Duplication Count' to a value bigger than zero to show all SQLs which are at least duplicated this numer of times.
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_SGA_SQL_Performance_Summary 11-May-2017 124450.xlsx](https://www.enginatics.com/example/dba-sga-sql-performance-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_SGA_SQL_Performance_Summary.sql](https://www.enginatics.com/export/dba-sga-sql-performance-summary/)\
[rep_DBA_SGA_SQL_Performance_Summary.xml](https://www.enginatics.com/xml/dba-sga-sql-performance-summary/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) (**https://www.enginatics.com/library/**) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) (**https://www.enginatics.com/blitz-report/**), which is the fastest reporting solution for Oracle E-Business Suite. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) (**https://www.enginatics.com/download/**) Blitz Report and use it [free](https://www.enginatics.com/pricing/) (**https://www.enginatics.com/pricing/**) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) (**https://www.enginatics.com/installation-guide/**) and [user](https://www.enginatics.com/user-guide/) (**https://www.enginatics.com/user-guide/**) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/) (**https://www.enginatics.com/**), check our [blog](https://www.enginatics.com/blog/) (**https://www.enginatics.com/blog/**) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/) (**http://demo.enginatics.com/**).

© 2020 Enginatics