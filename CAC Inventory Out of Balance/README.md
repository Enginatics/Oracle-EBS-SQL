# [CAC Inventory Out-of-Balance](https://www.enginatics.com/reports/cac-inventory-out-of-balance/)
## Description: 
Report to show any differences in the period end snapshot that is created when you close the inventory periods.  This represents any differences between the cumulative inventory accounting entries and the onhand valuation of the subinventories and intransit stock locations.

/* +=============================================================================+
-- |  Copyright 2006-2020 Douglas Volz Consulting, Inc.                          |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_inv_snapshot_diff_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_period_name      -- the accounting period to report, mandatory
-- |  p_min_value_diff   -- minimum difference to add up by org  by period,
-- |                        this is set to default to a value of 1 if nothing is entered
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- |  Description:
-- |  Report to show any differences in the period end snapshot that is created
-- |  when you close the inventory periods.  This represents any differences
-- |  between the cumulative inventory accounting entries and the onhand
-- |  valuation of the subinventories and intransit stock locations.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.14    19 Nov 2015 Douglas Volz   Commented out the Cost Group information.  Not Consistent.
-- |  1.15    17 Jul 2018 Douglas Volz   Now report G/L short name.
-- |  1.16    06 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.17    30 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.18    18 May 2020 Douglas Volz   Added language for item status.
-- +=============================================================================+*/

## Categories: 
[Cost Accounting - Assessment](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Assessment), [Cost Accounting - Inventory Value](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Inventory+Value), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [OATUG Public](https://www.enginatics.com/library/?pg=1&category[]=OATUG+Public)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Inventory_Out_of_Balance 01-Jun-2020 213157.xlsx](https://www.enginatics.com/example/cac-inventory-out-of-balance/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_CAC_Inventory_Out_of_Balance.xml](https://www.enginatics.com/xml/cac-inventory-out-of-balance/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics