# [CAC Cost Vs. Planning Item Controls](https://www.enginatics.com/reports/cac-cost-vs-planning-item-controls/)
## Description: 
Compare item make/buy controls vs. costing based on rollup controls.  There are five included reports, see below description for more information.
/* +=============================================================================+
-- |  Copyright 2008-2020 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_cost_vs_plan_ctrls_repts.sql
-- |
-- |  Parameters:
-- |
-- |  p_cost_type	-- Desired cost type, mandatory
-- |  p_assignment_set	-- The assignment set you wish to report
-- |  p_ledger		-- Desired ledger to report, to get all values enter a
-- |			   null value or blank value
-- |  p_item_number	-- Specific item number, to get all values enter a
-- |			   null value or blank value
-- |
-- |  Description:
-- |  Use the below SQL scripts to compare the item costing rollup flags
-- |  with the item's make / buy flag. For the any Cost Type.
-- |  Report to show cost rollup flags which may be incorrect:
-- |     1.  Based on Rollup Yes - No BOMS
-- |         Find make or buy items where the item is set to be rolled up
-- |         but there are no BOMs, routings or sourcing rules.  May
-- |         roll up to a zero cost. 
-- |     2.  Based On Rollup Yes - No Rollup
-- |         Find items where it is set to be rolled up but there are
-- |         no rolled up costs
-- |     3.  Based on Rollup No - with BOMS
-- |         Find make or buy items where the item is not set to be rolled up
-- |         but BOMS, routings or sourcing rules exist.
-- |     4.  User Defined Costs - Make Items
-- |         For make items, where the planning_make_buy_code is Make,
-- |         find records where the detailed item costs are user-defined
-- |         (rollup source type is user-defined) instead of rolled-up or
-- |         based on the cost rollup.  May indicate a doubling up
-- |         of your item costs.
-- |     5.  Based on Rollup Yes - No Routing
-- |         Find items where the planning_make_buy_code is "Buy" or "Make",
-- |         costs are based on the cost rollup, BOMs exist but routings do not.

-- |  1.23    09 Jan 2017 Douglas Volz   New report 5, BOM exists but routing does not
-- |  1.24    05 Nov 2018 Douglas Volz   Don't report obsolete items
-- |  1.25    01 May 2019 Douglas Volz   Changed gl.short_name to gl.short_name 
-- |  1.25    01 May 2019 Douglas Volz   Changed gl.short_name to gl.short_name
-- |  1.26    27 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.27    26 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master and operating units.
-- |  1.28    31 May 2020 Douglas Volz   Use multi-language table for UOM Code and Item Statuses.
+=============================================================================+*/
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - Cost Accounting](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+Cost+Accounting)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Cost_Vs_Planning_Item_Controls 01-Jun-2020 205333.xlsx](https://www.enginatics.com/example/cac-cost-vs-planning-item-controls/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_Cost_Vs_Planning_Item_Controls.xml](https://www.enginatics.com/xml/cac-cost-vs-planning-item-controls/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics