# [CAC Inventory and Intransit Value (Period-End)](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/)
## Description: 
Tracks the amount of inventory at the end of the month.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name.

Note:  if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.

/* +=============================================================================+
-- | Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_inventory_val_rept.sql
-- |
-- |  Parameters:
-- |  p_period_name         -- Accounting period you wish to report for
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional)
-- |  p_cost_type           -- Enter a Cost Type to value the quantities
-- |                           using the Cost Type Item Costs; or, if 
-- |                           Cost Type is blank or null the report will 
-- |                           use the stored month-end snapshot values
-- |  p_category_set1       -- The first item category set to report, typically the
-- |                           Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the
-- |                           Inventory Category Set 
-- |
-- | ===================================================================
-- | Note:  if you enter a cost type this script uses the item costs 
-- |        from the cost type; if you leave the cost type 
-- |        blank it uses the item costs from the month-end snapshot.
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.16    23 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- |                                  master, item categories and operating units.
-- |                                  Used mfg_lookups for "Intransit".
-- +=============================================================================+*/
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - Cost Accounting](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+Cost+Accounting)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Inventory_and_Intransit_Value_Period_End_ 01-Jun-2020 213537.xlsx](https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_Inventory_and_Intransit_Value_Period_End.xml](https://www.enginatics.com/xml/cac-inventory-and-intransit-value-period-end/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics