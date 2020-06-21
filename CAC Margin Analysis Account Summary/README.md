# [CAC Margin Analysis Account Summary](https://www.enginatics.com/reports/cac-margin-analysis-account-summary/)
## Description: 
Report for the margin from the customer invoices and shipments, including the Sales and COGS accounts, based on the standard Oracle Margin table, cst_margin_summary.  You first need to run the Margin Analysis Build request, to populate this table.
/* +=============================================================================+
-- |  Copyright 2006 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- Starting transaction date for the customer shipments
-- |  p_trx_date_to      -- Ending transaction date for the customer shipments
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_customer_name    -- Enter the specific customer name you wish to report (optional)
-- |  p_item_number      -- Enter the specific item number you wish to report (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- General ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report for the margin from the customer invoices and shipments, based
-- |  on the standard Oracle Margin table, cst_margin_summary.  You first need
-- |  to run the Margin Analysis Build request, to populate this table.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 APR 2006 Douglas Volz   Initial Coding
-- |  1.1     15 MAY 2006 Douglas Volz   Working version
-- |  1.2     17 MAY 2006 Douglas Volz   Added order line and date information
-- |  1.3     14 Dec 2012 Douglas Volz   Modified for Garlock, changed category set
-- |  1.4     19 Dec 2012 Douglas Volz   Bug fix for category set name
-- |  1.5     29 Jan 2013 Douglas Volz   Fixed date parameters to have same format
-- |          as other reports; had to remove sales and COGS accounts as these are 
-- |          on different rows and would need to rewrite the code to include this.
-- |          Also added a join for mic and mcs for category_set_id to avoid duplicate rows.
-- |          And added a having clause to screen out zero rows.
-- |  1.6     25 Feb 2013 Douglas Volz   Added apps.mtl_default_category_sets mdcs table
-- |                                     to make the script more generic
-- |  1.7     27 Feb 2017 Douglas Volz   Modified for Item Category and customer
-- |                                     information.  
-- |  1.8     28 Feb 2017 Douglas Volz   Removed sales rep information,
-- |                                     was causing cross-joining.
-- |  1.9     22 May 2017 Douglas Volz   Adding Inventory item category
-- |  1.10    23 May 2020 Douglas Volz   Use multi-language table for UOM Code, item 
-- |                                     master, OE transaction types and hr organization names. 
-- +=============================================================================+*/

## Categories: 
[Cost Accounting - Assessment](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Assessment), [Cost Accounting - Transactions](https://www.enginatics.com/library/?pg=1&category[]=Cost+Accounting+-+Transactions), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [OATUG Public](https://www.enginatics.com/library/?pg=1&category[]=OATUG+Public)
## Dependencies
If you would like to try one of these SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Margin_Analysis_Account_Summary 01-Jun-2020 220355.xlsx](https://www.enginatics.com/example/cac-margin-analysis-account-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[rep_CAC_Margin_Analysis_Account_Summary.xml](https://www.enginatics.com/xml/cac-margin-analysis-account-summary/)
# Oracle E-Business Suite - Reporting Library 
    
We provide an open source EBS operational and project implementation support [library](https://www.enginatics.com/library/) for rapid Excel report generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are not generated through the XML mechanism. 

Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate translation to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics