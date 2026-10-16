---
layout: default
last_modified_at: 2026-10-16
title: 'CAC PO Price vs. Costing Method Comparison | Oracle EBS SQL Report'
description: 'Report to compare the open purchase order lines and unit prices with the costing method item cost in Oracle (Average, Standard, FIFO or LIFO). Used by the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Price, vs., Costing, mtl_supply, po_headers_all, po_lines_all'
permalink: /CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/
report_name: 'CAC PO Price vs. Costing Method Comparison'
report_web_name: cac-po-price-vs-costing-method-comparison
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC PO Price vs. Costing Method Comparison – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-po-price-vs-costing-method-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to compare the open purchase order lines and unit prices with the costing method item cost in Oracle (Average, Standard, FIFO or LIFO).  Used by the buyers and cost accounting to check the accuracy of the recently created purchase orders and run using a range of purchase order line creation dates.  Foreign currency purchase orders convert to the inventory organization's currency by either using the original purchase order exchange rate, if the Invoice Match Option is "Purchase Order" or by using the latest exchange rate date if the Invoice Match Option is "Receipt".

Parameters:
===========
Creation Date From:  purchase order starting creation date (mandatory).
Creation Date To: purchase order ending creation date (mandatory).
Cost Type:  enter the cost type you wish to report (mandatory).  Defaults to your Costing Method.
Minimum Value Difference:  the absolute smallest difference you want to report (mandatory).
Minimum Cost Difference:  the absolute smallest difference you want to report (mandatory).
Currency Conversion Type:  enter the currency conversion type for translating PO unit prices, used if the Invoice Match Option is "Receipt", defaults to Corporate (mandatory).
Currency Conversion Date:  enter the currency conversion date for translating PO unit prices, used if the Invoice Match Option is "Receipt" (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006-2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.17    13 Jun 2017 Douglas Volz   Added OSP Resource Code
-- |  1.18    19 Aug 2019 Douglas Volz   Removed non-generic item categories
-- |  1.19    27 Jan 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |                                     Added project number to report.
-- |  1.20    19 Dec 2020 Douglas Volz   Add these columns: PO Need By Date, PO Promise Date,
-- |                                     PO Expected Receipt Date, Target Price (PO List Price),
-- |                                     Customer Name (description for category set 1).  
-- |                                     And added Minimum Cost Difference parameter.
-- |  1.21    22 Dec 2020 Douglas Volz   Changed the item cost "union all" to just "union", 
-- |                                     which eliminated a full table scan on cst_item_costs.
-- |  1.22    02 Nov 2023 Douglas Volz   Add Cost Type as a parameter, remove tabs and
-- |                                     add org access controls.
-- |  1.23    18 Jul 2024 Douglas Volz   Fix for Percent Difference calculation.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Creation Date From, Creation Date To, Cost Type, Minimum Value Difference, Minimum Cost Difference, Currency Conversion Type, Currency Conversion Date, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)

## Related Reports
[CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC PO Price vs. Costing Method Comparison 07-Jul-2022 173319.xlsx](https://www.enginatics.com/example/cac-po-price-vs-costing-method-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison) |
| Blitz Report™ XML Import | [CAC_PO_Price_vs_Costing_Method_Comparison.xml](https://www.enginatics.com/xml/cac-po-price-vs-costing-method-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison) |
| SQL Source | [CAC PO Price vs- Costing Method Comparison.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-po-price-vs-costing-method-comparison/](https://www.enginatics.com/reports/cac-po-price-vs-costing-method-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison) |

## Case Study & Technical Analysis: CAC PO Price vs. Costing Method Comparison

### Executive Summary
The **CAC PO Price vs. Costing Method Comparison** report is a proactive audit tool. It compares the Unit Price on Open Purchase Orders against the current Item Cost in the system. This allows organizations to catch significant pricing errors or forecast large variances *before* the goods are received.

### Business Challenge
*   **Data Entry Errors**: A buyer enters $100.00 instead of $10.00. If not caught, this creates a massive variance upon receipt.
*   **Standard Cost Accuracy**: If the PO Price is consistently 20% higher than the Standard Cost, the Standard Cost is outdated and needs revaluation.
*   **Currency Impact**: Buying in EUR when the system is in USD requires checking if the exchange rate on the PO is current.

### Solution
This report highlights the discrepancies.
*   **Comparison**: `PO Unit Price` vs. `Item Cost` (Standard/Average/FIFO).
*   **Thresholds**: Parameters for "Minimum Value Difference" and "Minimum Cost Difference" allow users to filter out noise (e.g., ignore variances under $100).
*   **Currency**: Handles currency conversion to ensure an apples-to-apples comparison.

### Technical Architecture
*   **Tables**: `po_lines_all`, `cst_item_costs`.
*   **Logic**:
    *   If Invoice Match Option = 'Purchase Order', use PO Rate.
    *   If Invoice Match Option = 'Receipt', use current Daily Rate.

### Parameters
*   **Creation Date From/To**: (Mandatory) Range of POs to check.
*   **Cost Type**: (Mandatory) The standard to compare against.
*   **Min Value/Cost Diff**: (Mandatory) Filters for exception reporting.

### Performance
*   **Efficient**: Uses standard indexes on PO tables.

### FAQ
**Q: Does this affect the GL?**
A: No, this is a reporting tool for *Open* POs. No accounting has happened yet. It is for forecasting and data cleansing.

**Q: What if the item has no cost?**
A: It will show a 100% variance, highlighting that a New Item Cost needs to be set up before receipt.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-po-price-vs-costing-method-comparison)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
