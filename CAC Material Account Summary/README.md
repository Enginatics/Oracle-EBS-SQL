# [CAC Material Account Summary](https://www.enginatics.com/reports/cac-material-account-summary/)
## Description: 
Report to get the material accounting entries for each item, organization, subinventory with amounts.  Including Ship From and Ship To information for inter-org transfers.  This report includes all material transactions but to keep the report smaller it does not displays WIP job information, such as WIP Accounting Class, Class Description, Assembly Number, Assembly Description or Job Order Number.
Use the Show Subinventory parameter to reduce the size of this report, as needed.  If you choose Yes you get the Subinventory Code, if you choose No you only get the Accounting Line Type for inventory, (Inventory valuation) thus greatly reducing the size of this report.

/* +=============================================================================+
-- |  Copyright 2009-20 Douglas Volz Consulting, Inc.                            |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_mtl_dist_xla_sum_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- starting transaction date for PII related transactions, mandatory
-- |  p_trx_date_to      -- ending transaction date for PII related transactions, mandatory
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_show_subinv      -- display the subinventory code or don't display the subinventory code.
-- |                        Enter a 'Y' or 'N' value.  Mandatory.  Use to limit the report size.
-- |
-- |  Description:
-- |  Report to get the material accounting entries for each item, organization and subinventory
-- |  with amounts.  Including Ship From and Ship To information for inter-org
-- |  transfers.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.19    22 Apr 2020 Douglas Volz    Put Item Type lookup code into inner queries, to avoid
-- |                                     creating outer joins errors to multiple tables (12.1.3). 
-- |                                     Put item master back into inner queries for the item type
-- |                                     lookup and changed FOB point into a lookup code for languages.
-- | 1.20    03 May 2020 Douglas Volz    Can have multiple mta rows with the same CCID, quantity
-- |                                     and accounting line type.  To avoid summing incorrectly, 
-- |                                     need to count the number of rows and then divide into the
-- |                                     total quantity sum.  However, for Standard Cost Updates,
-- |                                     use the quantity adjusted.
-- | 1.21    14 May 2020 Douglas Volz    Use multi-language table for UOM_Code, mtl_units_of_measure_vl
-- | 1.22    17 May 2020 Douglas Volz    Remove inner query group by, not needed.
-- +=============================================================================+*/


## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - Cost Accounting](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+Cost+Accounting)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Material_Account_Summary 01-Jun-2020 220747.xlsx](https://www.enginatics.com/example/cac-material-account-summary/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_Material_Account_Summary.xml](https://www.enginatics.com/xml/cac-material-account-summary/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics