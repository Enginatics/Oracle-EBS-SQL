---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Margin Analysis Account Summary | Oracle EBS SQL Report'
description: 'Report for the margin from the customer invoices and shipments, including the Sales and COGS accounts, based on the standard Oracle Margin table…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Margin, Analysis, Account, mtl_parameters, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20Margin%20Analysis%20Account%20Summary/
report_name: 'CAC Margin Analysis Account Summary'
report_web_name: cac-margin-analysis-account-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Margin Analysis Account Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-margin-analysis-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report for the margin from the customer invoices and shipments, including the Sales and COGS accounts, based on the standard Oracle Margin table, cst_margin_summary.  (If you want to show the COGS and Sales Margins without accounts, use report CAC Margin Analysis Summary.)

Notes:
1)  In order to run this report, you first need to run the Margin Analysis Load Run request (to populate the standard Oracle Margin table).
2)  If you have customized Subledger Accounting or used custom programs to record COGS by cost element, this report shows only the first COGS account, as there is only one reported row per sales order line.

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
-- |  1.13    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Customer Name, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [cst_margin_summary](https://www.enginatics.com/library/?pg=1&find=cst_margin_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [hz_cust_accounts_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)

## Related Reports
[CAC Margin Analysis Summary](/CAC%20Margin%20Analysis%20Summary/ "CAC Margin Analysis Summary Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [PO Internal Requisitions and Sales Orders](/PO%20Internal%20Requisitions%20and%20Sales%20Orders/ "PO Internal Requisitions and Sales Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Margin%20Analysis%20Account%20Summary/CAC%20Margin%20Analysis%20Account%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Margin Analysis Account Summary 07-Jul-2022 151652.xlsx](https://www.enginatics.com/example/cac-margin-analysis-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary) |
| Blitz Report™ XML Import | [CAC_Margin_Analysis_Account_Summary.xml](https://www.enginatics.com/xml/cac-margin-analysis-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary) |
| SQL Source | [CAC Margin Analysis Account Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Margin%20Analysis%20Account%20Summary/CAC%20Margin%20Analysis%20Account%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-margin-analysis-account-summary/](https://www.enginatics.com/reports/cac-margin-analysis-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-account-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
