# [DBA SGA SQL Performance Summary](https://www.enginatics.com/reports/dba-sga-sql-performance-summary/)
## Description: 
Database SQL performance summary from the SGA to give an overview of top SQL load and performance issues.
The purpose of this report, compared to 'DBA AWR SQL Performance Summary' is to retrieve SQLs which are not in the AWR, either becasue they ran after the most recent snapshot or because their performance impact is too small to be written to the AWR (see topnsql https://docs.oracle.com/database/121/ARPLS/d_workload_repos.htm#ARPLS69140).
This is useful for example to:
-Identify SQLs executed by a particular program or UI function without running a trace. Navigate to the UI functionality first, then directly after, execute this report and restrict to the module name in question. Sort by column 'Last Active Time'
-Identify SQLs and example bind variables to reproduce a SQL execution in a DB access tool. Switch parameter 'Show Bind Values' to 'Yes'
-Identify SQLs incorrectly using literals instead of binds. Set parameter 'Literals Duplication Count' to a value bigger than zero to show all SQLs which are at least duplicated this numer of times.
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - DBA](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+DBA)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_SGA_SQL_Performance_Summary 11-May-2017 124450.xlsx](https://www.enginatics.com/example/dba-sga-sql-performance-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_SGA_SQL_Performance_Summary.xml](https://www.enginatics.com/xml/dba-sga-sql-performance-summary/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics