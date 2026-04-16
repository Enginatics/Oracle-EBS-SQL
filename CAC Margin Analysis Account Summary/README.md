---
layout: default
title: 'CAC Margin Analysis Account Summary | Oracle EBS SQL Report'
description: 'Report for the margin from the customer invoices and shipments, including the Sales and COGS accounts, based on the standard Oracle Margin table…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Margin, Analysis, Account, mtl_system_items_vl, mtl_units_of_measure_vl, fnd_common_lookups'
permalink: /CAC%20Margin%20Analysis%20Account%20Summary/
---

# CAC Margin Analysis Account Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-margin-analysis-account-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report for the margin from the customer invoices and shipments, including the Sales and COGS accounts, based on the standard Oracle Margin table, cst_margin_summary.  (If you want to show the COGS and Sales Margins without accounts, use report CAC Margin Analysis Summary.)

Notes:
1)  In order to run this report, you first need to run the Margin Analysis Load Run request (to populate the standard Oracle Margin table).
2)  If you have customized Subledger Accounting or used custom programs to record COGS by cost element, this report shows only the first COGS account, as there is only one reported row per sales order line.

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Customer Name:  enter the specific customer name you wish to report (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006 - 2024 Douglas Volz Consulting, inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_margin_analysis_rept.sql
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
-- |  1.6     25 Feb 2013 Douglas Volz   Added mtl_default_category_sets mdcs table
-- |                                     to make the script more generic
-- |  1.7     27 Feb 2017 Douglas Volz   Modified for Item Category and customer
-- |                                     information.  
-- |  1.8     28 Feb 2017 Douglas Volz   Removed sales rep information,
-- |                                     was causing cross-joining.
-- |  1.9     22 May 2017 Douglas Volz   Adding Inventory item category
-- |  1.10    23 May 2020 Douglas Volz   Use multi-language table for UOM Code, item master
-- |                                     OE transaction types and hr organization names. 
-- |  1.11    06 Nov 2020 Douglas Volz   Fix for having custom, multiple COGS accounts by
-- |                                     cost element.  Now only get one COGS account.
-- |  1.12    14 Jun 2024 Douglas Volz   Remove tabs, reinstall parameters and org access controls.
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Customer Name, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [so_order_types_all](https://www.enginatics.com/library/?pg=1&find=so_order_types_all), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [hz_cust_accounts_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts_all), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_margin_summary](https://www.enginatics.com/library/?pg=1&find=cst_margin_summary), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Margin Analysis Summary](/CAC%20Margin%20Analysis%20Summary/ "CAC Margin Analysis Summary Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Margin Analysis Account Summary 07-Jul-2022 151652.xlsx](https://www.enginatics.com/example/cac-margin-analysis-account-summary/) |
| Blitz Report™ XML Import | [CAC_Margin_Analysis_Account_Summary.xml](https://www.enginatics.com/xml/cac-margin-analysis-account-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-margin-analysis-account-summary/](https://www.enginatics.com/reports/cac-margin-analysis-account-summary/) |

## Case Study & Technical Analysis: CAC Margin Analysis Account Summary

### Executive Summary
The **CAC Margin Analysis Account Summary** report bridges the gap between Sales Operations and Financial Accounting. It reports the Gross Margin (Revenue - COGS) for customer shipments, while explicitly listing the General Ledger accounts used for both sides of the transaction. This is essential for reconciling the "Managerial" margin to the "Financial" margin.

### Business Challenge
*   **Reconciliation**: The Sales team reports $1M in margin, but the GL shows $900k. Why? Often, specific transactions posted to unexpected accounts (e.g., a "Warranty" account instead of "COGS").
*   **Audit**: Auditors need to verify that the COGS account used matches the product type sold.
*   **Granularity**: Standard GL reports show balances; they don't show which Customer or Sales Order drove the balance.

### Solution
This report leverages the `CST_MARGIN_SUMMARY` table (populated by a concurrent request).
*   **Transaction Detail**: Lists Sales Order, Line, Item, and Customer.
*   **Account Visibility**: Shows the `Sales Account` and `COGS Account` segments.
*   **Profitability**: Calculates Margin Amount and Margin %.

### Technical Architecture
*   **Prerequisite**: The "Margin Analysis Load Run" program must be run first to populate the data.
*   **Tables**: `cst_margin_summary`, `gl_code_combinations`, `mtl_system_items`.
*   **Join**: Links the margin record to the GL code combinations to resolve the account numbers.

### Parameters
*   **Transaction Date From/To**: (Mandatory) The date range.
*   **Customer Name**: (Optional) Filter for specific account analysis.
*   **Organization**: (Optional) Inventory Org.

### Performance
*   **Dependent**: Performance depends on the `CST_MARGIN_SUMMARY` table size. If the Load Run hasn't been purged recently, this table can be huge.
*   **Indexed**: Efficiently filters by Date and Org.

### FAQ
**Q: Why is the report empty?**
A: You likely haven't run the "Margin Analysis Load Run" program for the requested period. This report reads a snapshot table, not raw transactions.

**Q: Why do I see multiple lines for one order line?**
A: If a single sales order line was shipped in multiple partial shipments, or if the COGS account was split (e.g., across cost centers), you will see multiple rows.

**Q: Does it include freight?**
A: Only if the freight is invoiced as a line item or included in the COGS calculation.


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
