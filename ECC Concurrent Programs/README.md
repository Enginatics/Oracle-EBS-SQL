# [ECC Concurrent Programs](https://www.enginatics.com/reports/ecc-concurrent-programs/)
## Description: 
List of all concurrent programs required to synchronize Oracle EBS data to the Enterprise Command Centers (ECC) Weblogic server, based on Oracle note 2495053.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=2495053.1

The report includes all currently scheduled request_ids and responsibilities for incremental and full loads, to check which ones are already scheduled.
The short code can be used as multiple parameter value entry in other reports, e.g. https://www.enginatics.com/reports/fnd-access-control/ to see which responsibilities or users have access to schedule them, or https://www.enginatics.com/reports/fnd-concurrent-requests/ to look at past execution and schedule times.

ECC data is defined by dataset codes, which have a related DB package procedure containing the SQL for each dataset, see:
https://www.enginatics.com/reports/ecc-data-sets/

The individual load progams are all calling child program 'ECC Run Data Load' either for specific datasets or by application, and the program's java executable ECCRUNDL then executes the dataset SQL and transfers the data to the Weblogic server where it is stored in a file structure using Apache Lucene technology https://en.wikipedia.org/wiki/Apache_Lucene
## Categories: 
[Application](https://www.enginatics.com/library/?pg=1&category[]=Application), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[ECC_Concurrent_Programs 23-Apr-2020 013118.xlsx](https://www.enginatics.com/example/ecc-concurrent-programs/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_ECC_Concurrent_Programs.sql](https://www.enginatics.com/export/ecc-concurrent-programs/)\
[rep_ECC_Concurrent_Programs.xml](https://www.enginatics.com/xml/ecc-concurrent-programs/)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/), which is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog/) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics