# [DBA Result Cache Objects and Invalidations](https://www.enginatics.com/reports/dba-result-cache-objects-and-invalidations)
## Description: 
Shows result cache objects with the current number cached results and their dependency on objects causing the most frequent invalidations.

Warning !!!
Don't run this on a prod system during business hours as prior to DB version 12.2, selecting from v$result_cache_objects apparently blocks all result cache objects (see note 2143739.1, section 4.).
You may end up with all server sessions waiting on 'latch free' for 'Result Cache: RC Latch' while the report is running.
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
# Report Example
[DBA_Result_Cache_Objects_and_Invalidations 18-Jan-2018 224327.xlsx](https://www.enginatics.com/example/dba-result-cache-objects-and-invalidations)
# [Blitz Report™](https://www.enginatics.com/blitz-report) import options
[rep_DBA_Result_Cache_Objects_and_Invalidations.sql](https://www.enginatics.com/export/dba-result-cache-objects-and-invalidations)\
[rep_DBA_Result_Cache_Objects_and_Invalidations.xml](https://www.enginatics.com/xml/dba-result-cache-objects-and-invalidations)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) that is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics