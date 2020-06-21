# [CAC Accounting Period Status](https://www.enginatics.com/reports/cac-accounting-period-status/)
## Description: 
Report to show the accounting period status for General Ledger, Inventory, Lease Management, Payables, Projects, Purchasing and Receivables.  You can choose All Statuses (open or closed or never opened), Closed, Open or Never Opened periods.  And this report will also display the process manufacturing cost calendar status.


/* +=============================================================================+
-- | SQL Code Copyright 2011-2020 Douglas Volz Consulting, Inc.                  |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_period_status_rept.sql
-- |
-- |  Parameters:
-- |  p_functional_area       -- functional area you wish to report, works with null,
-- |                             or valid functional areas.  The names of the
-- |                             functional areas are:  General Ledger, Inventory, Lease
-- |                             Management, Payables, Projects, Purchasing and Receivables.
-- |  p_operating_unit        -- Operating Unit you wish to report, leave blank for all
-- |                             operating units (optional) 
-- |  p_ledger                -- general ledger you wish to report, leave blank for all
-- |                             ledgers (optional)
-- |  p_period_name           -- The desired accounting period you wish to report
-- |  p_report_period_option  -- Parameter used to combine the Period Open and Period Close
-- |                             reports.  For English, the list of value choices are:
-- |					Closed, Open, Never Opened or All Statuses
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     19 Jan 2015 Douglas Volz    Combined the xxx_period_open_status_rept.sql
-- |                      Apps Associates and xxx_period_close_status_rept.sql into
-- |                                      one report.  Originally written in 2006 and 2011.
-- |  1.7     10 Apr 2020 Douglas Volz    Made the following multi-language changes:
-- |                                      Changed fnd_application to fnd_application_vl
-- |                                      Changed hr_all_organization_units to hr_all_organization_units_vl
-- |  1.8      7 May 2020 Douglas Volz    Added fnd_product_installations to only report
-- |                                      installed applications.
-- |  1.9     26 May 2020 Douglas Volz    Added lookup values and parameters for the
-- |                                      organization_hierarchy_name subquery.
-- |  1.10    28 May 2020 Douglas Volz    For language translation, replaced custom Report 
-- |                                      Options LOV with compound Oracle lookup values.
-- |  1.11    21 Jun 2020 Douglas Volz    Added Organization Hierarchy as a separate parameter
-- +=============================================================================+*/


## Categories: 
[Cost Accounting - Assessment](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Assessment), [Cost Accounting - Other](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Other), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [OATUG Public](https://www.enginatics.com/library/?pg=1&category[]=OATUG+Public)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Accounting_Period_Status 01-Jun-2020 205716.xlsx](https://www.enginatics.com/example/cac-accounting-period-status/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_CAC_Accounting_Period_Status.xml](https://www.enginatics.com/xml/cac-accounting-period-status/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics