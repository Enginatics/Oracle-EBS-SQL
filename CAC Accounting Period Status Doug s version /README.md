# [CAC Accounting Period Status (Doug's version)](https://www.enginatics.com/reports/cac-accounting-period-status-doug-s-version/)
## Description: 
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
-- |  p_functional_area  -- functional area you wish to report, works with null,
-- |                        or valid functional areas.  The names of the
-- |                        functional areas are:  General Ledger, Inventory, Lease
-- |                        Management, Payables, Projects, Purchasing and Receivables.
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_period_name      -- The desired accounting period you wish to report
-- |  p_report_option    -- Parameter used to combine the Period Open and Period Close
-- |                        reports.  The list of value choices are:
-- |                    'Periods Not Opened'  (similar to 'Only Missing Periods') 
-- |                    'Open Periods'
-- |                    'Closed Periods'
-- |                    'All Period Statuses'
-- |  Description:
-- |  Report to show the inventory accounting period status, whether open or closed,
-- |  showing inventory organizations that are not open that should be open or 
-- |  inventory organizations which are closed but should be open. Also shows the
-- |  open/close status for the General Ledger, Lease Management, Payables, Projects, 
-- |  Purchasing and Receivables.  And this report will show open process organizations
-- |  even if the respective inventory accounting period is closed for the same period name.
-- | 
-- |  History for xxx_period_status_rept.sql
-- |
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     19 Jan 2015 Douglas Volz    Combined the xxx_period_open_status_rept.sql
-- |                      Apps Associates and xxx_period_close_status_rept.sql into
-- |                                      one report.  Originally written in 2006 and 2011.
-- |  1.1     19 Jan 2015 Douglas Volz    Added OPM Cost Calendar status and Projects.
-- |  1.2     19 Dec 2016 Douglas Volz    Fixed list of value choices, was preventing
-- |                                      purchasing operating units from being reported.
-- |                                      Changed to: 
-- |                        'Periods Not Opened'  (similar to 'Only Missing Periods') 
-- |                        'Open Periods'
-- |                        'Closed Periods'
-- |                        'All Period Statuses' 
-- |  1.3     18 May 2016 Douglas Volz    Minor fix for reporting the Organization Hierarchy
-- |  1.4     03 Dec 2018 Douglas Volz    Open Periods option now checks for Summarized Flag.
-- |  1.5     27 Oct 2019 Douglas Volz    Condense A/R, A/P, Projects, Purchasing SQL logic
-- |  1.6     16 Jan 2020 Douglas Volz    Add operating unit parameter
-- +=============================================================================+*/

-- =====================================================================
-- Inventory Calendar Periods Not Closed
-- =====================================================================
## Categories: 
[Cost Accounting - Other](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Other), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Financials](https://www.enginatics.com/library/?pg=1&category[]=Financials)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_CAC_Accounting_Period_Status_Doug_s_version.sql](https://www.enginatics.com/export/cac-accounting-period-status-doug-s-version/)\
[rep_CAC_Accounting_Period_Status_Doug_s_version.xml](https://www.enginatics.com/xml/cac-accounting-period-status-doug-s-version/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics