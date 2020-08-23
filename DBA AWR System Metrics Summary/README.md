# [DBA AWR System Metrics Summary](https://www.enginatics.com/reports/dba-awr-system-metrics-summary/)
## Description: 
Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write IO figures, summarized in snapshot time intervals. All IO figures are measured in MB/s.

-CPU%: Total CPU usage percentage. If this is low, the hardware is underused and performance could potentially get improved by using it better e.g. by resolving IO bottlenecks (bigger RAM, faster storage) or parallelization of SQLs and user processes.
-WAIT%: Percentage of time that the DB process spends waiting rather than processing. If the wait% is high and most of the wait time is spend e.g. waiting for IO, then the storage is too slow compared to CPU speed.
-BUFF_READ: Logical IO read from the buffer cache (RAM) in MB/s
-PHYS_READ: Physical IO read from the storage in MB/s
-PHYS_WRITE:  Physical IO written to the storage in MB/s

Note: The UOM calculation from LIOs to MB uses the database default block size and doesn't support different block sizes for different tablespaces.
## Categories: 
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic+Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_AWR_System_Metrics_Summary 13-Jul-2018 173115.xlsx](https://www.enginatics.com/example/dba-awr-system-metrics-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[DBA_AWR_System_Metrics_Summary.xml](https://www.enginatics.com/xml/dba-awr-system-metrics-summary/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics