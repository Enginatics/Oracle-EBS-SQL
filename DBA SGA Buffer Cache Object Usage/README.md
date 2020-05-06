# [DBA SGA Buffer Cache Object Usage](https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/) (**https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/**)
## Description: 
SGA buffer cache space usage by object names (in MB).
'Object Percentage' shows how much of one particular object is currently stored in the buffer cache.
100% means that the object is completely in the buffer cache.

Current SGA memory usage is also listed in views:
select * from v$sga
select * from v$sgainfo
select * from v$sga_dynamic_components

Arup Nanda gives a good explanation on how the buffer cache works:
http://arup.blogspot.ch/2014/11/cache-buffer-chains-demystified.html
## Categories: 
[DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_SGA_Buffer_Cache_Object_Usage 05-Apr-2020 014325.xlsx](https://www.enginatics.com/example/dba-sga-buffer-cache-object-usage/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_DBA_SGA_Buffer_Cache_Object_Usage.sql](https://www.enginatics.com/export/dba-sga-buffer-cache-object-usage/)\
[rep_DBA_SGA_Buffer_Cache_Object_Usage.xml](https://www.enginatics.com/xml/dba-sga-buffer-cache-object-usage/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) (**https://www.enginatics.com/library/**) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) (**https://www.enginatics.com/blitz-report/**), which is the fastest reporting solution for Oracle E-Business Suite. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) (**https://www.enginatics.com/download/**) Blitz Report and use it [free](https://www.enginatics.com/pricing/) (**https://www.enginatics.com/pricing/**) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) (**https://www.enginatics.com/installation-guide/**) and [user](https://www.enginatics.com/user-guide/) (**https://www.enginatics.com/user-guide/**) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/) (**https://www.enginatics.com/**), check our [blog](https://www.enginatics.com/blog/) (**https://www.enginatics.com/blog/**) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/) (**http://demo.enginatics.com/**).

© 2020 Enginatics