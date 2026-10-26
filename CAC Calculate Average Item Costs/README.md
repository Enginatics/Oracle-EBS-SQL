---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Calculate Average Item Costs | Oracle EBS SQL Report'
description: 'Using purchase order receipts, calculate average item costs over a specified transaction date range and compare against the Comparison Cost Type. In…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Calculate, Average, Item, mtl_parameters, mtl_material_transactions, rcv_transactions'
permalink: /CAC%20Calculate%20Average%20Item%20Costs/
report_name: 'CAC Calculate Average Item Costs'
report_web_name: cac-calculate-average-item-costs
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Calculate Average Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-calculate-average-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Using purchase order receipts, calculate average item costs over a specified transaction date range and compare against the Comparison Cost Type.  In addition, with the Use Default Material Overheads parameter you can choose which material overheads to use on this report.  Select Yes to use the Default Material Overhead setups.  Set to No to use the material overheads from the specified Comparison Cost Type.  And if planning to use roll up these item costs, to avoid doubling up rolled up material costs on assemblies, choose Yes for the parameter Exclude Rolled Up Items, to avoid having manually defined material costs and rolled up material costs.

-- |  Copyright 2006 - 2023 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     05 Jan 2019 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.15    10 Jan 2023 Douglas Volz   Fix for Average Cost calculations, UOM issue.
-- | 1.16    21 Aug 2023 Douglas Volz   Remove tabs and restrict to only orgs you have access to,
-- |                                    Add last payables invoice and purchase order price information.
-- | 1.17    25 Sep 2023 Douglas Volz   Fix for the Last PO and Last A/P information
-- | 1.18    13 Oct 2023 Andy Haack     Fix for G/L Daily Rates, outer joins
-- | 1.19    24 Nov 2023 Douglas Volz   Fixed item number parameter for last PO information
-- |                                    and fix Last A/P Invoice info for G/L Daily Rates
-- | 1.20    08 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- |  1.21    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Use Default Material Overheads, Only Active Rates, Exclude Rolled Up Items, Comparison Cost Type, Currency Conversion Date, Currency Conversion Type, Show Last AP Invoice, Category Set 1, Category Set 2, Category Set 3, Supplier Type to Exclude, Item Status to Exclude, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [cst_item_overhead_defaults](https://www.enginatics.com/library/?pg=1&find=cst_item_overhead_defaults&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)

## Related Reports
[CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [CAC Receiving Activity Summary](/CAC%20Receiving%20Activity%20Summary/ "CAC Receiving Activity Summary Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20Average%20Item%20Costs/CAC%20Calculate%20Average%20Item%20Costs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Calculate Average Item Costs 11-Dec-2022 114227.xlsx](https://www.enginatics.com/example/cac-calculate-average-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs) |
| Blitz Report™ XML Import | [CAC_Calculate_Average_Item_Costs.xml](https://www.enginatics.com/xml/cac-calculate-average-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs) |
| SQL Source | [CAC Calculate Average Item Costs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20Average%20Item%20Costs/CAC%20Calculate%20Average%20Item%20Costs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-calculate-average-item-costs/](https://www.enginatics.com/reports/cac-calculate-average-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs) |

## Case Study & Technical Analysis: CAC Calculate Average Item Costs

### Executive Summary
The **CAC Calculate Average Item Costs** report is a sophisticated analytical tool for Cost Accountants and Procurement Managers. It calculates the "true" average cost of items based on actual Purchase Order (PO) receipts over a specified period and compares these calculated values against a standard cost type (e.g., Frozen or Pending). This analysis is crucial for validating standard costs during periodic updates, ensuring that the system's cost definitions align with current market prices paid to suppliers.

### Business Challenge
Setting standard costs is often a complex exercise involving estimation and historical analysis. Organizations face challenges such as:
*   **Cost Variance:** Significant Purchase Price Variances (PPV) occurring because standard costs are outdated compared to actual procurement costs.
*   **Inflationary Pressure:** Difficulty in quantifying the impact of rising supplier prices on inventory valuation.
*   **Overhead Allocation:** Complexity in determining the correct material overheads to apply to new standard costs.
*   **Data Volume:** The inability to manually calculate weighted average costs across thousands of items and receipts.

### The Solution
The **CAC Calculate Average Item Costs** report automates the derivation of average costs. It enables users to:
*   **Validate Standards:** Compare the calculated average purchase price against the current standard cost to identify items requiring revaluation.
*   **Simulate Overheads:** Choose between using existing standard overheads or applying default overhead setups to simulate the total cost impact.
*   **Exclude Outliers:** Filter out specific supplier types or inactive items to ensure the calculated average reflects "normal" business operations.
*   **Analyze Trends:** View the last AP invoice and PO price alongside the average to spot recent pricing trends.

### Technical Architecture (High Level)
The report performs a complex aggregation of purchasing and inventory data.
*   **Data Source:** It queries `RCV_TRANSACTIONS` and `MTL_MATERIAL_TRANSACTIONS` to identify receipts and their actual transaction values.
*   **Calculation Engine:** It calculates a weighted average cost: $\frac{\sum (Quantity \times Unit Price)}{\sum Quantity}$.
*   **Cost Comparison:** It joins with `CST_ITEM_COSTS` to retrieve the comparison cost (e.g., Frozen) and calculates the variance (absolute and percentage).
*   **Overhead Logic:** The query includes conditional logic (`DECODE`) to apply material overhead rates either from the existing cost type or from the default category-based setups (`CST_DEFAULT_COST_ELEMENT_RATES`), depending on the user's parameter selection.

### Parameters & Filtering
The report offers extensive parameters for precise analysis:
*   **Transaction Date Range:** Defines the historical period for the average cost calculation (e.g., last 6 months).
*   **Comparison Cost Type:** The benchmark cost type (e.g., "Frozen" or "Pending").
*   **Use Default Material Overheads:** A toggle ('Y'/'N') to determine if overheads should be recalculated based on current default rules.
*   **Exclude Rolled Up Items:** Prevents double-counting of costs for sub-assemblies if the intention is to roll up costs later.
*   **Show Last AP Invoice:** Optionally retrieves the most recent invoice details for a "sanity check" against the average.

### Performance & Optimization
The report handles large data volumes through:
*   **Pre-Aggregation:** It aggregates receipt data by item and organization before joining to the master data, reducing the row count for subsequent joins.
*   **Indexed Lookups:** Utilizes standard indexes on transaction dates and item IDs.
*   **Efficient Currency Conversion:** Applies currency conversion rates at the transaction level (if needed) or uses the standard rate defined in the parameters.

### FAQ
**Q: How is the "Average Material Cost" calculated?**
A: It is the total value of PO receipts divided by the total quantity received during the specified date range.

**Q: What happens if there are no receipts for an item?**
A: The item will not appear in the report unless it exists in the comparison cost type, depending on the join type. Typically, this report focuses on items with activity.

**Q: Why can I exclude specific supplier types?**
A: You might want to exclude inter-company transfers or one-time spot buys from the average cost calculation to get a more representative market price.

**Q: Does this update the system costs?**
A: No, this is a reporting tool only. It provides the data needed to make decisions about updating costs, but it does not perform the update itself.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-average-item-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
