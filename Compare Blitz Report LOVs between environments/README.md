# [Compare Blitz Report LOVs between environments](https://www.enginatics.com/reports/compare-blitz-report-lovs-between-environments/) (**https://www.enginatics.com/reports/compare-blitz-report-lovs-between-environments/**)
## Description: 
Requires following view to be created on the remote environment to avoid ORA-64202: remote temporary or abstract LOB locator is encountered

create or replace view xxen_report_parameter_lovs_v_ as
select
xrplv.*,
dbms_lob.substr(xrplv.lov_query,4000,1) lov_query_short
from
xxen_report_parameter_lovs_v xrplv;
## Categories: 
[Application](https://www.enginatics.com/library/?pg=1&category[]=Application), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_Compare_Blitz_Report_LOVs_between_environments.sql](https://www.enginatics.com/export/compare-blitz-report-lovs-between-environments/)\
[rep_Compare_Blitz_Report_LOVs_between_environments.xml](https://www.enginatics.com/xml/compare-blitz-report-lovs-between-environments/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) (**https://www.enginatics.com/library/**) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) (**https://www.enginatics.com/blitz-report/**), which is the fastest reporting solution for Oracle E-Business Suite. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) (**https://www.enginatics.com/download/**) Blitz Report and use it [free](https://www.enginatics.com/pricing/) (**https://www.enginatics.com/pricing/**) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) (**https://www.enginatics.com/installation-guide/**) and [user](https://www.enginatics.com/user-guide/) (**https://www.enginatics.com/user-guide/**) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/) (**https://www.enginatics.com/**), check our [blog](https://www.enginatics.com/blog/) (**https://www.enginatics.com/blog/**) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/) (**http://demo.enginatics.com/**).

© 2020 Enginatics