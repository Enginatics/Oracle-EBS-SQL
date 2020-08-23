# [DBA SGA+PGA Memory Configuration](https://www.enginatics.com/reports/dba-sga-pga-memory-configuration/)
## Description: 
Current SGA and PGA memory configuration in gigabytes.

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
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - DBA](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+DBA)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_SGA_PGA_Memory_Configuration 29-Jul-2018 103004.xlsx](https://www.enginatics.com/example/dba-sga-pga-memory-configuration/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[DBA_SGA_PGA_Memory_Configuration.xml](https://www.enginatics.com/xml/dba-sga-pga-memory-configuration/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics