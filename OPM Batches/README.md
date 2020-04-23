# [OPM Batches](https://www.enginatics.com/reports/opm-batches)
## Description: 
The primary table is GME_BATCH_HEADER. It contains basic information
regarding the batch such as plant_code, batch_number, batch_type (0 for
normal batches or 10 for firm planned orders), and batch_status. Note
batch_status translations are to be found in GEM_LOOKUPS.

Batches have many steps which are found in GME_BATCH_STEPS. It's not in the
example query; but, the operation name can be found in GMD_OPERATIONS_B
which is linked by OPRN_ID.

Steps have many activities which are found in GME_BATCH_STEP_ACTIVITIES.

Activities have many resources which are found in GME_BATCH_STEP_RESOURCESS.

Resources have many process parameters which are found in
GME_PROCESS_PARAMETERS. Process parameters is OPM's way of letting the
customer easily store information not designed into the GME schema. Think
of it like a descriptive flex field (not on steroids).

The name of the process parameter can be found in GMP_PROCESS_PARAMETERS.
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
# [Blitz Report™](https://www.enginatics.com/blitz-report) import options
### [rep_OPM_Batches.sql](https://www.enginatics.com/export/opm-batches)
### [rep_OPM_Batches.xml](https://www.enginatics.com/xml/opm-batches)
# Oracle E-Business Suite reports

This is a part of extensive [library](https://www.enginatics.com/library/) of SQL scripts for [Blitz Report™](https://www.enginatics.com/blitz-report/) that is the fastest reporting solution for Oracle EBS. Blitz Report is based on Oracle Forms so is fully integrated with E-Business Suite. 

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) Blitz Report and use it [free](https://www.enginatics.com/pricing/) for up to 30 reports. 

Blitz Report runs as a background concurrent process and generates output files in XLSX or CSV format, which are automatically downloaded and opened in Excel. Check [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for more details.

If you are interested in Oracle EBS reporting you can visit [www.enginatics.com](https://www.enginatics.com/), check our [blog](https://www.enginatics.com/blog) and try to run this and other reports on our [demo environment](http://demo.enginatics.com/)

© 2020 Enginatics