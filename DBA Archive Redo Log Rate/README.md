# [DBA Archive / Redo Log Rate](https://www.enginatics.com/reports/dba-archive-redo-log-rate)
## Description: 
If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown.
For databases on NOARCHIVELOG, the approximate amount of generated redo is calculated by the number of log switches per hour and log file size. Note that this log rate is just an approximated maximum as switches could also occur without the log files being full.

Redo log files are located here:
select * from sys.v_$logfile
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
# Report Example
### [DBA_Archive_Redo_Log_Rate 13-Jul-2018 173740.xlsx](https://www.enginatics.com/example/dba-archive-redo-log-rate)
# [Blitz Report™](https://www.enginatics.com/blitz-report) import options
### [rep_DBA_Archive_Redo_Log_Rate.sql](https://www.enginatics.com/export/dba-archive-redo-log-rate)
### [rep_DBA_Archive_Redo_Log_Rate.xml](https://www.enginatics.com/xml/dba-archive-redo-log-rate)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) that is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics