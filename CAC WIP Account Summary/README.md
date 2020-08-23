# [CAC WIP Account Summary](https://www.enginatics.com/reports/cac-wip-account-summary/)
## Description: 
Shows the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  And for outside processing, including the purchase order number, line and release number.

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
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - Cost Accounting](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+Cost+Accounting)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_WIP_Account_Summary 01-Jun-2020 221236.xlsx](https://www.enginatics.com/example/cac-wip-account-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_WIP_Account_Summary.xml](https://www.enginatics.com/xml/cac-wip-account-summary/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics