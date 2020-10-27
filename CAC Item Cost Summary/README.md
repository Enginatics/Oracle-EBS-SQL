# [CAC Item Cost Summary](https://www.enginatics.com/reports/cac-item-cost-summary/)
## Description: 
Report to show item costs in any cost type.  For one or more inventory organizations.

/* +=============================================================================+
-- | Copyright 2009-2020 Douglas Volz Consulting, Inc.                           |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- The cost type you wish to report
-- |  p_ledger                 -- general ledger you wish to report, works with
-- |                              null or valid ledger names
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed resources
-- |
-- | Description:
-- | Report to show item costs in any cost type
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     08 Nov 2010 Douglas Volz  Updated with additional columns and parameters
-- |  1.3     07 Feb 2011 Douglas Volz  Added COGS and Revenue default accounts
-- |  1.4     15 Nov 2016 Douglas Volz  Added category information
-- |  1.5     27 Jan 2020 Douglas Volz  Added Org Code and Operating Unit parameters
-- |  1.6     27 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units.
-- |  1.7     21 Jun 2020 Douglas Volz  Changed to multi-language views for item 
-- |                                    status and UOM.
-- |  1.8     24 Sep 2020 Douglas Volz  Added List Price to report.+=============================================================================+*/
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - Cost Accounting](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+Cost+Accounting)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Item_Cost_Summary 21-Jun-2020 155735.xlsx](https://www.enginatics.com/example/cac-item-cost-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_Item_Cost_Summary.xml](https://www.enginatics.com/xml/cac-item-cost-summary/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics