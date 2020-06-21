# [ECC Admin - Concurrent Programs](https://www.enginatics.com/reports/ecc-admin-concurrent-programs/)
## Description: 
List of all concurrent programs required to synchronize Oracle EBS data to the Enterprise Command Centers (ECC) Weblogic server, based on Oracle note 2495053.1 https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=2495053.1

The report includes all currently scheduled request_ids and responsibilities for incremental and full loads, to check which ones are already scheduled.
The short code can be used as multiple parameter value entry in other reports, e.g. https://www.enginatics.com/reports/fnd-access-control/ to see which responsibilities or users have access to schedule them, or https://www.enginatics.com/reports/fnd-concurrent-requests/ to look at past execution and schedule times.

ECC data is defined by dataset codes, which have a related DB package procedure containing the SQL for each dataset, see:
https://www.enginatics.com/reports/ecc-data-sets/

The individual load progams are all calling child program 'ECC Run Data Load' either for specific datasets or by application, and the program's java executable ECCRUNDL then executes the dataset SQL and transfers the data to the Weblogic server where it is stored in a file structure using Apache Lucene technology https://en.wikipedia.org/wiki/Apache_Lucene
## Categories: 
[Application](https://www.enginatics.com/library/?pg=1&category[]=Application), [DBA](https://www.enginatics.com/library/?pg=1&category[]=DBA), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[ECC_Admin_Concurrent_Programs 15-Jun-2020 192701.xlsx](https://www.enginatics.com/example/ecc-admin-concurrent-programs/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_ECC_Admin_Concurrent_Programs.xml](https://www.enginatics.com/xml/ecc-admin-concurrent-programs/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics