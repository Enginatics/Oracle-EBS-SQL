# [Month End - Speed Inventory Period Close](https://www.enginatics.com/reports/month-end-speed-inventory-period-close/)
## Description: 
** Queries Used to Display the Counts in the Inventory Account Periods form  (Doc ID 357997.1)**
The following Blitz Report mimicks the counts found in the Inventory Accounting Period close form. 
1. The following parameters are used:
OrgID -- The Organization id.
StartPeriodDate -- The start period date for the period in question.
EndPeriodDate -- The end period date for the period in question.
2. The following SQL can be used to find the organization id:
select a.organization_id, b.organization_code, a.name
from HR_ALL_ORGANIZATION_UNITS_TL a, mtl_parameters_view b
where a.organization_id = b.organization_id
order by organization_id, organization_code **/
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_Month_End_Speed_Inventory_Period_Close.sql](https://www.enginatics.com/export/month-end-speed-inventory-period-close/)\
[rep_Month_End_Speed_Inventory_Period_Close.xml](https://www.enginatics.com/xml/month-end-speed-inventory-period-close/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/), which is the fastest reporting solution for Oracle E-Business Suite. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics