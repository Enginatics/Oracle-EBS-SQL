# [OPM Batches](https://www.enginatics.com/reports/opm-batches/)
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
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_OPM_Batches.sql](https://www.enginatics.com/export/opm-batches/)\
[rep_OPM_Batches.xml](https://www.enginatics.com/xml/opm-batches/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics