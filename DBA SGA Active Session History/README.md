# [DBA SGA Active Session History](https://www.enginatics.com/reports/dba-sga-active-session-history/)
## Description: 
Active session history from the SGA.

Parameter 'Blocked Sessions only' allows a blocking screnario root cause analysis, e.g. by doing a pivot in Excel (see example in the online library).
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH then.
For scenarios where the blocking sessions are active and part of the ASH, Tanel Poder has a treewalk ash_wait_chains.sql, showing the whole chain of ASH records linked by a unique join, including the sample_id:
https://blog.tanelpoder.com/2013/11/06/diagnosing-buffer-busy-waits-with-the-ash_wait_chains-sql-script-v0-2/

We recommend doing ASH performance analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.
A typical use case is to analyze which EBS application user waited for how many seconds in which forms UI and to drill down further into the SQL or wait event root causes then.

Column 'Module Name' shows either the translated EBS module display name or, e.g. for background sessions, the process name (from the program column) to enable pivoting by this column only.
Oracle's background process names are listed here:
https://docs.oracle.com/database/121/REFRN/GUID-86184690-5531-405F-AA05-BB935F57B76D.htm#REFRN104
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic+Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_SGA_Active_Session_History 24-Sep-2018 011658.xlsx](https://www.enginatics.com/example/dba-sga-active-session-history/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_SGA_Active_Session_History.sql](https://www.enginatics.com/export/dba-sga-active-session-history/)\
[rep_DBA_SGA_Active_Session_History.xml](https://www.enginatics.com/xml/dba-sga-active-session-history/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/), which is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics