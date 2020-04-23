# [DBA SGA+PGA Memory Configuration](https://www.enginatics.com/reports/dba-sga-pga-memory-configuration/)
## Description: 
A frequent configuration problem is not making full use of the available hardware resources, especially the physical RAM of the database server.
This report shows the servers SGA, PGA and CPU configuration in comparison to the available hardware.
For maximum performance, configure the SGA+PGA to use the full available memory of your server minus a few gig for OS level caching, e.g. for writing and reading of PLSQL output files on the DB node and for process memory (an estimated 4MB per process, see below).

Oracle's performance tuning guide:
https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgdba/database-memory-allocation.html

Oracle's exadata best practices whitepaper:
SUM of databases (SGA_TARGET + PGA_AGGREGATE_TARGET) + 4 MB * (Maximum PROCESSES) < Physical Memory per Database Node

Tom Kyte's recommendation:
"... if you want it all automatic, give ALL FREE MEMORY on your machine to the SGA and be done with it. No more monitoring, no more thinking about how it could be, should be, would be used.
Set the PGA aggregate target and the SGA target to be a tad less than physical memory on the machine and you are done."
https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:30011178429375

The report also shows the status of system statistics.
select * from sys.aux_stats$

If CPUSPEEDNW still shows the default of 4096, it either means that the stats have never been gathered or it could also mean that your storage is too fast to gather them with the standard NOWORKLOAD method and you should set reasonable values manually then.
exec dbms_stats.gather_system_stats();
exec dbms_stats.set_system_stats('IOSEEKTIM',1);
exec dbms_stats.set_system_stats('IOTFRSPEED',85782);

There is also an Exadata mode, considering the faster storage correctly and updating the MBRC too
exec dbms_stats.gather_system_stats(`EXADATA');
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
# Report Example
[DBA_SGA_PGA_Memory_Configuration 29-Jul-2018 103004.xlsx](https://www.enginatics.com/example/dba-sga-pga-memory-configuration/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_SGA_PGA_Memory_Configuration.sql](https://www.enginatics.com/export/dba-sga-pga-memory-configuration/)\
[rep_DBA_SGA_PGA_Memory_Configuration.xml](https://www.enginatics.com/xml/dba-sga-pga-memory-configuration/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/), which is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics