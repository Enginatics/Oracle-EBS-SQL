# [DBA Result Cache Statistics](https://www.enginatics.com/reports/dba-result-cache-statistics/)
## Description: 
Result cache statistics with size values in MB.

If the 'Maximum Size' is big enough, 'Create Count Failure' should be zero or low, same as 'Delete Count Valid', which depicts the number of valid cache results flushed out.
'Find Count' shows the number of cached results used (instead of executing the underlying sql/plsql) and should hence be as high as possible for maximum performance improvement.

A high number of 'Invalidation Count' or 'Delete Count Invalid' relative to 'Find Count' should get investigated further as it indicates a result_cache specified for code where the underlying data changes too frequently.
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_Result_Cache_Statistics 18-Jan-2018 225229.xlsx](https://www.enginatics.com/example/dba-result-cache-statistics/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_Result_Cache_Statistics.sql](https://www.enginatics.com/export/dba-result-cache-statistics/)\
[rep_DBA_Result_Cache_Statistics.xml](https://www.enginatics.com/xml/dba-result-cache-statistics/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics