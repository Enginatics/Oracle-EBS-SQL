---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Item Cost Comparison | Oracle EBS SQL Report'
description: 'Report to compare the item costs from two cost types in any two inventory orgs, converting the Org Code 1 (Source Org) into the currency of Org Code 2 (To…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Item, Cost, Comparison, mtl_parameters, hr_organization_information, hr_all_organization_units'
permalink: /CAC%20Item%20Cost%20Comparison/
report_name: 'CAC Item Cost Comparison'
report_web_name: cac-item-cost-comparison
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Item Cost Comparison – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to compare the item costs from two cost types in any two inventory orgs, converting the Org Code 1 (Source Org) into the currency of Org Code 2 (To Org).  Put the smallest cost type into Cost Type 1, as the values for cost type 1 are always reported even if not in cost type 2.  Note that the Source Org and the Compared To Org default from the inventory organization as set for your session.

/* +=============================================================================+
-- |  Copyright 2006 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       | 
-- |  1.14    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_org_code1            -- The inventory organization that is the source
-- |  p_org_code2            -- The inventory organization that is the target 
-- |  p_cost_type1           -- The source comparison cost type
-- |  p_cost_type2           -- The target comparison cost type
-- |  p_curr_conv_type       -- Conversion conversion type, to convert the Source
-- |                            org, org_code1, into the currency of the To_Org,
-- |                            org_code2
-- |  p_curr_conv_date       -- The currency conversion date, typically a month-end
-- |                            date
-- |  p_min_cost_diff        -- Minimum material cost diff. to show on the report
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- |
-- |  Description:
-- |  Report to compare the item costs from two cost types in any two inventory orgs,
-- |  converting the Org_Code 1 (Source_Org) into the currency of Org_Code 2 (To_Org).
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.1     14 Apr 2006 Douglas Volz   Final Coding for client
-- |  1.4     13 JUN 2006 Douglas Volz   Added nvl to all material costs columns
-- |  1.5     02 NOV 2009 Douglas Volz   Changed to compare the item costs for two orgs
-- |                                     across different currencies
-- |  1.6     21 Nov 2016 Douglas Volz   Take out currencies, allow comparison within
-- |                                     the same inventory org but using different
-- |                                     cost types
-- |  1.7     18 Dec 2018 Douglas Volz   Add currencies back in
-- |  1.8     30 Aug 2019 Douglas Volz   Add cost and inventory item categories,
-- |                                     item type and item status.
-- |  1.9     01 Sep 2020 Douglas Volz   Added costs by cost element.
-- |  1.10    11 Sep 2020 Douglas Volz   Added ability to report cost type1 even when
-- |                                     the item is not in cost type1. Made cic2 a
-- |                                     table select to avoid sql outer join errors.
-- |  1.11    24 Oct 2020 Douglas Volz   Fix bug to convert into any currency, not just USD.
-- |  1.12    02 Nov 2020 Douglas Volz   Again, fix to report cost type 1 even when the
-- |                                     item is not in cost type 2.
-- |  1.13    05 Jan 2022 Douglas Volz   Add lot size, shrinkage rate, based on rollup
-- |                                     flags.  Change calc. for percent difference.
+=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type 1, Compared to Cost Type 2, Source Org (Org Code 1), Compared to Org (Org Code 2), Minimum Cost Difference, Currency Conversion Type, Currency Conversion Date, Category Set 1, Category Set 2, Category Set 3, Item Number

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)

## Related Reports
[CAC Item List Price vs. Item Cost](/CAC%20Item%20List%20Price%20vs-%20Item%20Cost/ "CAC Item List Price vs. Item Cost Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20Comparison/CAC%20Item%20Cost%20Comparison.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost Comparison 23-Jun-2022 212444.xlsx](https://www.enginatics.com/example/cac-item-cost-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Comparison.xml](https://www.enginatics.com/xml/cac-item-cost-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison) |
| SQL Source | [CAC Item Cost Comparison.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20Comparison/CAC%20Item%20Cost%20Comparison.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-item-cost-comparison/](https://www.enginatics.com/reports/cac-item-cost-comparison/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison) |

## Case Study & Technical Analysis: CAC Item Cost Comparison

### Executive Summary
The **CAC Item Cost Comparison** report is a strategic sourcing and transfer pricing tool. It enables the comparison of item costs between two different inventory organizations, even if they use different currencies. This is critical for "Make vs. Buy" decisions (e.g., "Is it cheaper to make this in Plant A or Plant B?") and for validating intercompany transfer prices.

### Business Challenge
Global supply chains involve moving goods between entities with different cost structures and currencies.
*   **Currency Barrier**: Comparing a cost of 100 USD in the US to 90 EUR in Germany requires real-time currency conversion to be meaningful.
*   **Cost Structure**: Plant A might have lower labor but higher overhead than Plant B. A simple total cost comparison hides these trade-offs.
*   **Data Volume**: Manually looking up costs for thousands of items across two orgs is impossible.

### Solution
This report automates the cross-org comparison.
*   **Currency Normalization**: Converts the "Source Org" cost into the "Target Org" currency using a user-defined exchange rate type and date.
*   **Side-by-Side**: Displays Cost Type 1 (Source) and Cost Type 2 (Target) next to each other, with a calculated variance.
*   **Element Visibility**: Can optionally break down the comparison by cost element (Material, Labor, etc.) to show *where* the difference lies.

### Technical Architecture
The report performs a complex join across organizations:
*   **Self-Join**: Joins `cst_item_costs` to itself (once for Org 1, once for Org 2).
*   **Currency Engine**: Uses `gl_daily_rates` to fetch the exchange rate between the functional currencies of the two organizations.
*   **Item Matching**: Matches items based on the Item Number (Segment 1), assuming a shared Item Master.

### Parameters
*   **Org Code 1 (Source)**: The reference organization.
*   **Org Code 2 (Target)**: The comparison organization.
*   **Currency Conversion**: (Mandatory) Date and Type for the FX calculation.
*   **Min Cost Diff**: (Optional) Filter to show only significant variances.

### Performance
*   **Heavy Join**: Joining two large cost tables can be slow.
*   **Filtering**: Using the "Min Cost Diff" parameter is highly recommended to reduce the output to actionable items only.

### FAQ
**Q: Can I compare the same org to itself?**
A: Yes, you can use this to compare two different Cost Types (e.g., Frozen vs. Pending) within the same organization, effectively acting as a "Cost Impact" report.

**Q: What if the item doesn't exist in the second org?**
A: The report typically uses an outer join, so it will show the item in Org 1 with a null value for Org 2 (or vice versa).

**Q: Does it handle different Units of Measure?**
A: The report assumes the Primary UOM is the same. If Org 1 uses "Each" and Org 2 uses "Dozen", the comparison will be skewed unless a conversion is applied (which this report typically does not do automatically).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-comparison)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
