# [FND Lookup Search](https://www.enginatics.com/reports/fnd-lookup-search/)
## Description: 
Finds the best matching lookup_type for a given set of lookup_codes in a custom application base table.

Example:
Coding a sql for ap suppliers, the value of column vendor_type_lookup_code should get translated to the user visible meaning instead of the code.
The lookup_type used for translation can be found by this report entering table name AP_SUPPLIERS and column name VENDOR_TYPE_LOOKUP_CODE.
The output contains a column SQL_TEXT which can be used directly in the sql where clause:

=flv.lookup_code(+) and
flv.lookup_type(+)='VENDOR TYPE' and
flv.view_application_id(+)=201 and
flv.language(+)=userenv('lang') and
flv.security_group_id(+)=0 and
## Categories: 
[Application](https://www.enginatics.com/library/?pg=1&category[]=Application), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
# Report Example
[FND_Lookup_Search 27-Jul-2018 212528.xlsx](https://www.enginatics.com/example/fnd-lookup-search/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_FND_Lookup_Search.sql](https://www.enginatics.com/export/fnd-lookup-search/)\
[rep_FND_Lookup_Search.xml](https://www.enginatics.com/xml/fnd-lookup-search/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) that is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics