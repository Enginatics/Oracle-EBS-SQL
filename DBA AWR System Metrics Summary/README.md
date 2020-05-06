# [DBA AWR System Metrics Summary](https://www.enginatics.com/reports/dba-awr-system-metrics-summary/) (**https://www.enginatics.com/reports/dba-awr-system-metrics-summary/**)
## Description: 
Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write IO figures, summarized in snapshot time intervals. All IO figures are measured in MB/s.

-CPU%: Total CPU usage percentage. If this is low, the hardware is underused and performance could potentially get improved by using it better e.g. by resolving IO bottlenecks (bigger RAM, faster storage) or parallelization of SQLs and user processes.
-WAIT%: Percentage of time that the DB process spends waiting rather than processing. If the wait% is high and most of the wait time is spend e.g. waiting for IO, then the storage is too slow compared to CPU speed.
-BUFF_READ: Logical IO read from the buffer cache (RAM) in MB/s
-PHYS_READ: Physical IO read from the storage in MB/s
-PHYS_WRITE:  Physical IO written to the storage in MB/s

Note: The UOM calculation from LIOs to MB uses the database default block size and doesn't support different block sizes for different tablespaces.
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic+Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_AWR_System_Metrics_Summary 13-Jul-2018 173115.xlsx](https://www.enginatics.com/example/dba-awr-system-metrics-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_AWR_System_Metrics_Summary.sql](https://www.enginatics.com/export/dba-awr-system-metrics-summary/)\
[rep_DBA_AWR_System_Metrics_Summary.xml](https://www.enginatics.com/xml/dba-awr-system-metrics-summary/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) (**https://www.enginatics.com/library/**) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) (**https://www.enginatics.com/blitz-report/**), which is the fastest reporting solution for Oracle E-Business Suite. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) (**https://www.enginatics.com/download/**) Blitz Report and use it [free](https://www.enginatics.com/pricing/) (**https://www.enginatics.com/pricing/**) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) (**https://www.enginatics.com/installation-guide/**) and [user](https://www.enginatics.com/user-guide/) (**https://www.enginatics.com/user-guide/**) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/) (**https://www.enginatics.com/**), check our [blog](https://www.enginatics.com/blog/) (**https://www.enginatics.com/blog/**) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/) (**http://demo.enginatics.com/**).

© 2020 Enginatics