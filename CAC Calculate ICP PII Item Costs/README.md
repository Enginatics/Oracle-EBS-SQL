---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Calculate ICP PII Item Costs | Oracle EBS SQL Report'
description: 'Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item. Report gets the PII…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Calculate, ICP, PII, mrp_assignment_sets, mrp_sr_assignments, mrp_sourcing_rules'
permalink: /CAC%20Calculate%20ICP%20PII%20Item%20Costs/
report_name: 'CAC Calculate ICP PII Item Costs'
report_web_name: cac-calculate-icp-pii-item-costs
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Calculate ICP PII Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item.  Report gets the PII item costs across organizations, by joining the sourcing rule information from the first "hop" to the sourcing rule information to the second "hop".  In addition, if an item has a source organization in the item master, but the sourcing rule does not exist, this item relationship will still be reported.  This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations.  Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations.  In addition, inactive items and disabled organizations are ignored.

Note:  there is one hidden parameter: 
1) Numeric Sign for PII which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts.  Defaulted as positive (+1).

/* +=============================================================================+
-- | Copyright 2009-23 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- |  1.38    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     26 Sep 2009 Douglas Volz   Initial Coding
-- | 1.34     05 May 2021 Douglas Volz   Add Make Buy Code.
-- | 1.35    26 Feb 2022 Douglas Volz   Add category sets and To Org and From Org
-- |                                    parameters. Add two hidden parameters,
-- |                                    Include Same OU Transfers and set Sign
-- |                                    for PII Amounts (p_sign_pii), to determine 
-- |                                    if PII is entered as a positive or negative.
-- | 1.36     28 Nov 2023 Andy Haack     Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins
-- | 1.37     28 Jan 2024 Douglas Volz   Make Include Transfers to Same OU a displayed parameter. 
+=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Assignment Set, Cost Type, PII Cost Type, PII Sub-Element, Currency Conversion Date, Currency Conversion Type, Period Name, Include Transfers to Same OU, From Organization, To Organization, Category Set 1, Category Set 2, Category Set 3, Item Number

## Oracle EBS Tables Used
[mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)

## Related Reports
[CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20ICP%20PII%20Item%20Costs/CAC%20Calculate%20ICP%20PII%20Item%20Costs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Calculate ICP PII Item Costs 26-Jun-2023 171332.xlsx](https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs) |
| Blitz Report™ XML Import | [CAC_Calculate_ICP_PII_Item_Costs.xml](https://www.enginatics.com/xml/cac-calculate-icp-pii-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs) |
| SQL Source | [CAC Calculate ICP PII Item Costs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20ICP%20PII%20Item%20Costs/CAC%20Calculate%20ICP%20PII%20Item%20Costs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs) |

## Case Study & Technical Analysis: CAC Calculate ICP PII Item Costs

### Executive Summary
The **CAC Calculate ICP PII Item Costs** report is a specialized financial tool designed for multinational corporations with complex intercompany supply chains. It calculates the **Profit in Inventory (PII)**, also known as Intercompany Profit (ICP), embedded in the standard costs of items as they move between inventory organizations. By analyzing sourcing rules and cost structures across "hops" (transfer points), this report enables finance teams to accurately eliminate intercompany profits for consolidated financial reporting and ensure transfer pricing compliance.

### Business Challenge
In multi-entity organizations, goods are often transferred between subsidiaries at a markup (transfer price). While this markup is recognized as revenue for the selling entity, it represents an unrealized profit for the consolidated group until the goods are sold to an external customer. Challenges include:
*   **Unrealized Profit Tracking:** Difficulty in identifying how much of an item's standard cost is actually intercompany profit.
*   **Currency Fluctuations:** Complexity in converting costs from source to destination currencies using specific historical rates.
*   **Multi-Leg Transfers:** Tracking costs through multiple layers of the supply chain (e.g., Factory -> Hub -> Distribution Center).
*   **Compliance:** Ensuring that inventory valuations exclude internal profits for regulatory reporting.

### The Solution
The **CAC Calculate ICP PII Item Costs** report provides a granular view of intercompany profit at the item level. It allows users to:
*   **Trace Sourcing:** Automatically identifies the source organization for each item based on MRP Sourcing Rules and Assignment Sets.
*   **Calculate PII:** Computes the PII amount by comparing the source organization's cost (minus its own upstream PII) with the destination organization's cost.
*   **Handle Currencies:** Applies specific currency conversion rates (e.g., corporate rates at the time of standard setting) to ensure accurate cross-border cost comparisons.
*   **Simulate Adjustments:** Helps in calculating the necessary adjustments to the "PII" cost element to align with the calculated values.

### Technical Architecture (High Level)
The report logic is built around the concept of "hops" in the supply chain.
*   **Sourcing Logic:** It queries `MRP_SOURCING_RULES`, `MRP_SR_ASSIGNMENTS`, and related views to determine the flow of goods (Source Org $\rightarrow$ Destination Org).
*   **Cost Extraction:** It retrieves item costs from `CST_ITEM_COSTS` for both the source and destination organizations.
*   **PII Calculation:**
    *   *Source Cost Basis:* Takes the Source Org's total cost and subtracts any existing PII (to avoid cascading profit on profit).
    *   *Currency Conversion:* Converts the Source Cost Basis to the Destination Org's currency using `GL_DAILY_RATES`.
    *   *Comparison:* Compares the converted source cost with the destination's standard cost components to isolate the profit margin.
*   **Sign Handling:** Uses a hidden parameter (`p_sign_pii`) to handle different conventions for storing PII (positive or negative values).

### Parameters & Filtering
The report requires specific configuration to yield accurate results:
*   **Assignment Set:** The specific set of sourcing rules to use for determining the supply chain network.
*   **Cost Types:**
    *   *Cost Type:* The main standard cost type (e.g., Frozen).
    *   *PII Cost Type:* The specific cost type where PII values are stored/reported.
*   **PII Sub-Element:** The specific cost sub-element (resource or overhead) used to track PII.
*   **Currency Settings:** Conversion Date and Type to align with the organization's standard setting policy.
*   **Include Transfers to Same OU:** A toggle to include or exclude transfers within the same Operating Unit (often treated differently for tax purposes).

### Performance & Optimization
*   **Materialized Views:** Relies on MRP views (`MRP_SR_RECEIPT_ORG_V`, `MRP_SR_SOURCE_ORG_V`) which abstract complex sourcing logic but require efficient indexing on assignment sets.
*   **Organization Filtering:** Filters out disabled organizations and inactive items early in the process to reduce processing overhead.
*   **Outer Joins:** Uses outer joins for sourcing rules to ensure that items with defined source orgs in the item master (but no specific sourcing rule) are still captured if applicable.

### FAQ
**Q: What is "PII" or "ICP"?**
A: PII stands for Profit in Inventory, and ICP stands for Intercompany Profit. They refer to the profit margin added by a selling entity within the same corporate group, which must be eliminated for consolidated reporting.

**Q: How does the report handle currency conversion?**
A: It uses the *Currency Conversion Date* and *Type* parameters to look up rates in the General Ledger. This is crucial because standard costs are often set using a fixed exchange rate for the year.

**Q: Does this report update the costs?**
A: No, it is a calculation and reporting tool. The results are typically used to create a mass update (e.g., via an interface or API) to adjust the PII cost elements in the system.

**Q: Why is there a "Sign for PII" parameter?**
A: Different implementations track PII differently—some as a positive cost element (additive) and others as a contra-asset (negative). This parameter ensures the math works correctly for your specific setup.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
