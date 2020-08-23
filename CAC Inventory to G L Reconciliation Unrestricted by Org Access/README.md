# [CAC Inventory to G/L Reconciliation (Unrestricted by Org Access)](https://www.enginatics.com/reports/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/)
## Description: 
Compares the General Ledger inventory balances with the perpetual inventory values (based on the stored month-end inventory balances, generated when the inventory accounting period is closed).

/* +=============================================================================+
-- |  Copyright 2010-20 Douglas Volz Consulting, Inc.                            |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  XXX_INV_RECON_REPT.sql
-- |
-- |  Parameters:
-- |  P_PERIOD_NAME      -- Enter the Period Name you wish to reconcile balances for
-- |                        (mandatory)
-- |  P_LEDGER           -- general ledger you wish to report, for all ledgers enter
-- |                        a NULL or % symbol (optional parameter)
-- |
-- |  Description:
-- |  Report to reconcile G/L and the Inventory and WIP Perpetual
-- |  by Ledger and full account, for a desired accounting period.
-- |
-- |  ============================================================================
-- |  Does not consider cost groups and assumes the elemental cost accounts by
-- |  subinventory are the same as the material account.
-- |  This script also uses a custom lookup code called XXX_CST_GLINV_RECON_ACCOUNTS
-- |  as a means to determine the valid inventory account numbers
-- |  ============================================================================
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     24 Sep 2004 Douglas Volz   Initial Coding based on earlier work with
-- |                                     the following scripts and designs:
-- |                                        XXX_GL_RECON.sql,
-- |                                        XXX_PERPETUAL_INV_RECON_SUM.sql,
-- |                                        XXX_PERPETUAL_RCV_RECON_SUM.sql,
-- |                                        XXX_PERPETUAL_WIP_RECON_SUM.sql,
-- |                                        MD050 Inventory Reconciliation
-- |  1.1     28 Jun 2010 Douglas Volz   Updated design and code for Release 12,
-- |                                     changed GL_SETS_OF_BOOKS to GL_LEDGERS
-- |  1.2     14 Nov 2010 Douglas Volz   Modified for Cost SIG Presentation
-- |  1.3     11 Mar 2014 Douglas Volz   Changed the COA segments to be generic and removed
-- |                                     the second product line join to gl_code_combinations
-- |  1.4     07 Apr 2014 Douglas Volz   Added join condition to avoid secondary ledgers and
-- |                                     added an explicit to_char on the accounts
-- |                                     ml.lookup_code to avoid an "invalid number" SQL error.
-- |  1.5     20 Jul 2016 Douglas Volz   Added condition to avoid summary journals
-- |  1.6     18 May 2020 Douglas Volz   Avoid disabled inventory organizations.
-- +=============================================================================+*/

XXX_INV_RECON_REPT_V5-20-Jul-2016.sql
## Categories: 
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - Cost Accounting](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+Cost+Accounting)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[CAC_Inventory_to_G_L_Reconciliation_Unrestricted_by_Org_Access_ 07-Jun-2020 015839.xlsx](https://www.enginatics.com/example/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[CAC_Inventory_to_G_L_Reconciliation_Unrestricted_by_Org_Access.xml](https://www.enginatics.com/xml/cac-inventory-to-g-l-reconciliation-unrestricted-by-org-access/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics