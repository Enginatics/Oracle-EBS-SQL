---
layout: default
title: 'CAC Margin Analysis Summary | Oracle EBS SQL Report'
description: 'Report for the margin from the customer invoices and shipments, based on the standard Oracle Margin table, cstmarginsummary. (If you want to show the COGS…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Margin, Analysis, Summary, cst_margin_summary, mtl_system_items_vl, mtl_units_of_measure_vl'
permalink: /CAC%20Margin%20Analysis%20Summary/
---

# CAC Margin Analysis Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-margin-analysis-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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
-- +=============================================================================+*/


## Report Parameters
Transaction Date From, Transaction Date To, Category Set 1, Category Set 2, Category Set 3, Customer Name, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_margin_summary](https://www.enginatics.com/library/?pg=1&find=cst_margin_summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [so_order_types_all](https://www.enginatics.com/library/?pg=1&find=so_order_types_all), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [hz_cust_accounts_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts_all), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Margin Analysis Account Summary](/CAC%20Margin%20Analysis%20Account%20Summary/ "CAC Margin Analysis Account Summary Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Margin Analysis Summary 24-Jun-2022 063517.xlsx](https://www.enginatics.com/example/cac-margin-analysis-summary/) |
| Blitz Report™ XML Import | [CAC_Margin_Analysis_Summary.xml](https://www.enginatics.com/xml/cac-margin-analysis-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-margin-analysis-summary/](https://www.enginatics.com/reports/cac-margin-analysis-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
