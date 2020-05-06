# [DBA Result Cache Statistics](https://www.enginatics.com/reports/dba-result-cache-statistics/) (**https://www.enginatics.com/reports/dba-result-cache-statistics/**)
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
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) (**https://www.enginatics.com/library/**) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) (**https://www.enginatics.com/blitz-report/**), which is the fastest reporting solution for Oracle E-Business Suite. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) (**https://www.enginatics.com/download/**) Blitz Report and use it [free](https://www.enginatics.com/pricing/) (**https://www.enginatics.com/pricing/**) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) (**https://www.enginatics.com/installation-guide/**) and [user](https://www.enginatics.com/user-guide/) (**https://www.enginatics.com/user-guide/**) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/) (**https://www.enginatics.com/**), check our [blog](https://www.enginatics.com/blog/) (**https://www.enginatics.com/blog/**) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/) (**http://demo.enginatics.com/**).

© 2020 Enginatics