# [CAC ICP PII WIP Material Usage Variance](https://www.enginatics.com/reports/cac-icp-pii-wip-material-usage-variance/)
## Description: 
Report your material usage variances for your open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period.  You can report period periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect what it was for the specified reported accounting period.  And by specifying the profit in inventory (PII) cost type you can determine how much PII or ICP (intercompany profit) was either remaining on your balance sheet or how much was recorded as part of your WIP job close variances.


/* +=============================================================================+
-- |  Copyright 2009 - 2019 Douglas Volz Consulting, Inc.                        |
-- |  Permission to use this code is granted provided the original authors are   |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Authors: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_mtl_usage_var_rept.sql.sql
-- |
-- |  Parameters:
-- |  p_period_name       -- Enter the Period Name you wish to report for WIP Period
-- |                         balances (mandatory)
-- |  p_pii_cost_type     -- The name of the cost type that has that 
-- |                         month's PII costs (mandatory)
-- |  p_pii_resource_code -- The sub-element or resource for profit in inventory,
-- |                         such as PII or ICP (mandatory)
-- |  p_report_type       -- You can choose to limit the report size with this
-- |                         parameter.  The choices are:  Open jobs, All jobs or
-- |                         Closed jobs. (mandatory)
-- |  p_assembly_number   -- Enter the specific assembly number you wish to report (optional)
-- |  p_component_number  -- Enter the specific component number you wish to report (optional)
-- |  p_show_phantom_comp -- Show phantom components, default to No (N) (mandatory)
-- |  p_wip_job           -- Specific WIP job (optional)
-- |  p_job_status        -- Specific WIP job status (optional)
-- |  p_wip_class_code    -- Specific WIP class code (optional)
-- |  p_org_code          -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit    -- Operating Unit you wish to report, leave blank for all
-- |                         operating units (optional) 
-- |  p_ledger            -- general ledger you wish to report, leave blank for all
-- |                         ledgers (optional)
-- |
-- |  Rules:
-- |  If component issue qty = zero, there is no PII as the components are in onhand inventory
-- |  If component issue qty - required qty > 0, PII = PII item cost X "Est. Qty in WIP"
-- |  If component issue qty - required qty < 0, PII = PII item cost X "Est. Qty in WIP"
-- |  This will offset the overstatement of PII in the onhand inventory.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.0     11 Oct 2020 Douglas Volz    Initial Coding Based on ICP WIP Component 
-- |                                      Variances and ICP WIP Component Valuation 
-- +=============================================================================+*/
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_ICP_PII_WIP_Material_Usage_Variance.xml](https://www.enginatics.com/xml/cac-icp-pii-wip-material-usage-variance/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics