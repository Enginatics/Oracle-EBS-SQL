# [CAC Receiving Account Summary](https://www.enginatics.com/reports/cac-receiving-account-summary/)
## Description: 
Report to get the receiving accounting distributions, in summary, by item, purchase order, purchase order line, release and project number.  For outside processing, including the WIP job, OSP item number and the OSP resource code.  And for expense destinations, even when there is no item number on the purchase order line, this report will get the expense category information, into the first category column.  (Note: this report has not been tested with encumbrance entries.)

/* +=============================================================================+
-- |  Copyright 2009- 2020 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_dist_xla_sum_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- starting transaction date for WIP accounting transactions,
-- |                        mandatory.
-- |  p_trx_date_to      -- ending transaction date for WIP accounting transactions,
-- |                        mandatory.
-- |  p_item_number      -- Enter the specific item number you wish to report (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- |  Description:
-- |  Report to get the WIP accounting distributions, in summary, by WIP job,
-- |  resource, overhead and WIP cost update.  And for outside processing, 
-- |  including the purchase order number, line and release number.  
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.11    05 Jul 2019 Douglas Volz   Added:
-- |                                     a) Added the breakout of transaction mounts by cost 
-- |                                        element.
-- |                                     b) Added the sum of resource / overhead hours or
-- |                                        amounts to a primary quantity column, plus,
-- |                                        added the quantity UOM field.
-- |  1.12    23 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, item categories and operating units.
-- |                                     Added Project Number.
-- +=============================================================================+*/




## Categories: 
[Cost Accounting - Assessment](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Assessment), [Cost Accounting - Transactions](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Transactions), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [OATUG Public](https://www.enginatics.com/library/?pg=1&category[]=OATUG+Public)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Receiving_Account_Summary 01-Jun-2020 221021.xlsx](https://www.enginatics.com/example/cac-receiving-account-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_CAC_Receiving_Account_Summary.xml](https://www.enginatics.com/xml/cac-receiving-account-summary/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics