---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Margin Analysis Summary | Oracle EBS SQL Report'
description: 'Report for the margin from the customer invoices and shipments, based on the standard Oracle Margin table, cstmarginsummary. (If you want to show the COGS…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Margin, Analysis, Summary, mtl_parameters, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20Margin%20Analysis%20Summary/
report_name: 'CAC Margin Analysis Summary'
report_web_name: cac-margin-analysis-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Margin Analysis Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-margin-analysis-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report for the margin from the customer invoices and shipments, based on the standard Oracle Margin table, cst_margin_summary.  (If you want to show the COGS and Sales Accounts use report CAC Margin Analysis Account Summary.)  

Note:  in order to run this report, you first need to run the Margin Analysis Load Run request (to populate the standard Oracle Margin table).

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
-- |  Copyright 2006 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is 
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
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
-- |  1.11    14 Jun 2024 Douglas Volz   Remove tabs, reinstall parameters and org access controls.
-- |  1.12    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Customer Name, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [cst_margin_summary](https://www.enginatics.com/library/?pg=1&find=cst_margin_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Margin%20Analysis%20Summary/CAC%20Margin%20Analysis%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Margin Analysis Summary 24-Jun-2022 063517.xlsx](https://www.enginatics.com/example/cac-margin-analysis-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary) |
| Blitz Report™ XML Import | [CAC_Margin_Analysis_Summary.xml](https://www.enginatics.com/xml/cac-margin-analysis-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary) |
| SQL Source | [CAC Margin Analysis Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Margin%20Analysis%20Summary/CAC%20Margin%20Analysis%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-margin-analysis-summary/](https://www.enginatics.com/reports/cac-margin-analysis-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary) |

## Case Study & Technical Analysis: CAC Margin Analysis Summary

### Executive Summary
The **CAC Margin Analysis Summary** report is a high-level profitability tool. Unlike its "Account Summary" counterpart, this report strips away the General Ledger complexity to focus purely on the business metrics: Quantity, Revenue, Cost, and Margin. It is designed for Sales Managers, Product Managers, and Executives.

### Business Challenge
Business leaders need quick answers to profitability questions.
*   **Customer Profitability**: Which customers are generating the most margin?
*   **Product Mix**: Are we selling high-volume/low-margin items or low-volume/high-margin items?
*   **Trend Analysis**: How is our margin trending month-over-month?

### Solution
This report provides a clean, tabular view of margin performance.
*   **Aggregated View**: Can be summarized by Customer, Item Category, or Sales Order.
*   **Metrics**: Reports Invoiced Qty, Sales Amount, COGS Amount, Margin Amount, and Margin %.
*   **Source**: Uses the official Oracle Margin table to ensure consistency with financial reports.

### Technical Architecture
*   **Source**: `cst_margin_summary`.
*   **Simplification**: Removes the joins to `gl_code_combinations` found in the "Account Summary" version, making the output cleaner for non-finance users.
*   **Categorization**: Includes Item Category sets to allow for product line analysis.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Reporting period.
*   **Category Set**: (Optional) To group items by product family.
*   **Customer**: (Optional) To focus on key accounts.

### Performance
*   **Fast**: Reading from the summary table is generally faster than querying raw Order Management and AR tables.
*   **Prerequisite**: Requires the "Margin Analysis Load Run" to be up to date.

### FAQ
**Q: Does this match the P&L?**
A: It should match the *Gross Margin* line of the P&L, assuming the "Margin Analysis Load Run" was executed for the same period and all COGS/Revenue entries were captured.

**Q: Can I see the invoice number?**
A: Yes, the underlying table links to the AR Invoice, allowing for drill-down if the report layout is modified.

**Q: How are returns handled?**
A: RMAs (Returns) typically appear as negative revenue and negative cost, reducing the total margin.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-margin-analysis-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
