---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Calculate ICP PII Item Costs Multi-Hop | Oracle EBS SQL Report'
description: 'Calculates the intercompany profit in inventory (PII or ICP) for each item and receiving organization, accumulated over every transfer of the sourcing…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Calculate, ICP, PII, cst_cost_types, mtl_parameters, cst_item_costs'
permalink: /CAC%20Calculate%20ICP%20PII%20Item%20Costs%20Multi-Hop/
report_name: 'CAC Calculate ICP PII Item Costs Multi-Hop'
report_web_name: cac-calculate-icp-pii-item-costs-multi-hop
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Calculate ICP PII Item Costs Multi-Hop – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-multi-hop/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Calculates the intercompany profit in inventory (PII or ICP) for each item and receiving organization, accumulated over every transfer of the sourcing chain from the origin organization to the receiving organization, for any number of hops.

One row per item and sourcing path. The profit of a hop is the receiving organization's item cost without its this level material overhead, resource, outside processing and overhead costs, less the source organization's converted item cost. Calculated To Org PII is the sum over all hops of the path, each converted into the next organization's currency, plus the origin organization's stored PII cost. Only the origin's stored PII is used, so the PII of intermediate organizations does not have to be loaded first. PII Cost Difference is the calculated less the stored PII of the receiving organization.

Sourcing is read from mrp_item_sourcing_levels_v: for each item and organization the most specific assignment of the assignment set (item-organization, item master source organization, category, item, organization, organization parameter, global), effective on the currency conversion date. Rules disabled before today are not available for a conversion date in the past. A receiving organization with several transfer sources gets one row per path, with rank and allocation percent of the last hop.

Circular Sourcing marks organizations that are only reached through a sourcing loop without an origin; they are calculated for one hop from the source organization's stored PII.

A missing exchange rate leaves the calculated columns blank. Inactive items, master organizations and items without costs in the source or receiving organization are not reported. The hidden parameter Numeric Sign for PII (default 1) states whether PII costs are stored as positive or negative amounts.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Assignment Set, Cost Type, PII Cost Type, PII Sub-Element, Currency Conversion Date, Currency Conversion Type, Period Name, Include Transfers to Same OU, From Organization, To Organization, Category Set 1, Category Set 2, Category Set 3, Item Number

## Oracle EBS Tables Used
[cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop), [h](https://www.enginatics.com/library/?pg=1&find=h&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)

## Related Reports
[CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20Multi-Hop/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20Multi-Hop.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Calculate ICP PII Item Costs Multi-Hop 19-Sep-2026 143818.xlsx](https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs-multi-hop/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop) |
| Blitz Report™ XML Import | [CAC_Calculate_ICP_PII_Item_Costs_Multi_Hop.xml](https://www.enginatics.com/xml/cac-calculate-icp-pii-item-costs-multi-hop/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop) |
| SQL Source | [CAC Calculate ICP PII Item Costs Multi-Hop.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20Multi-Hop/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20Multi-Hop.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-multi-hop/](https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-multi-hop/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop) |

## Case Study & Technical Analysis: CAC Calculate ICP PII Item Costs Multi-Hop

### Executive Summary
The CAC Calculate ICP PII Item Costs Multi-Hop report calculates intercompany profit in inventory (PII, or ICP) for each item and receiving organization in Oracle Cost Management. It follows the full sourcing chain from the origin organization to the receiving organization, across any number of inter-organization transfers, and accumulates the profit of each hop. Cost accountants and intercompany reconciliation teams use it to compare the calculated PII with the PII stored in the receiving organization. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Multi-level intercompany profit:** When an item moves through several organizations, the profit in inventory must be eliminated across the whole chain, not only on the last transfer.
*   **Stored PII accuracy:** The PII stored in each receiving organization must agree with the sourcing chain and the costs of the organizations that supply it.
*   **Multi-currency transfers:** Each hop crosses a currency boundary, so costs must be converted on the conversion date.
*   **Multiple sources:** An organization can receive an item from several sources, and each path needs its own result.

### The Solution
*   **Hop profit:** For each transfer, the profit is the receiving organization's item cost without its material overhead, resource, outside processing and overhead costs, less the source organization's converted item cost.
*   **Recursive path accumulation:** A recursive `WITH` query adds each hop's profit to the PII of the previous hop, starting at the origin organization, and records the path such as origin to intermediate to receiving organization.
*   **Stored comparison:** The calculated PII is compared with the stored PII of the receiving organization, giving PII Cost Difference.
*   **Cycle handling:** Organizations reached only through a sourcing loop are flagged as Circular Sourcing and calculated for one hop from the source's stored PII.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_ITEM_COSTS`: the item cost of each organization and cost type, with the material overhead, resource, outside processing and overhead components.
*   `CST_ITEM_COST_DETAILS`: the cost detail rows used to take the PII sub-element.
*   `CST_COST_TYPES`: the cost type of the calculation and the PII cost type.
*   `MTL_PARAMETERS`: the organization parameters, including the primary cost method and the master organization.
*   `MRP_ASSIGNMENT_SETS` and `MRP_ITEM_SOURCING_LEVELS_V`: the assignment set and the sourcing hierarchy used to find each item's source.
*   `GL_DAILY_CONVERSION_TYPES` and `GL_DAILY_RATES`: the conversion type and the rates on the conversion date.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_ITEM_STATUS_VL`: item description, type, make-buy code and status.
*   `ORG_ORGANIZATION_DEFINITIONS` and `GL_LEDGERS`: organization codes, currencies and ledgers.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can see.
*   `BOM_RESOURCES`: the resource codes used to identify the PII sub-element.

#### Logical Relationships
1.  The `C` step reads each item's cost in each organization and computes the net cost and the PII cost of the sub-element.
2.  The `E` step takes the most specific sourcing level for each item and organization, joins source and receiving organizations and their currencies, and attaches the daily rate.
3.  The hop profit is the receiving net cost less the converted source item cost, signed by the Numeric Sign for PII parameter.
4.  The recursive `H` step starts from edges whose source is not itself a receiving organization, and repeatedly joins an edge whose source is the previous receiving organization.
5.  The final select joins the paths to their edges and to the organizations the responsibility can access.

### Parameters & Filtering
*   **Assignment Set:** names the sourcing assignment set that defines each item's source.
*   **Cost Type** and **PII Cost Type:** the cost type whose item costs are used and the cost type holding the stored PII.
*   **PII Sub-Element:** the resource code that identifies the PII cost inside the cost details.
*   **Currency Conversion Date** and **Currency Conversion Type:** the date and rate type used to convert each source cost.
*   **From Organization** and **To Organization:** limit the source and receiving organizations.
*   **Item Number** and **Category Set 1** to **Category Set 3:** restrict the items reported and add category columns.

### Performance & Optimization
*   The `C` and `E` steps are materialized, so the item cost and sourcing joins run once before the recursive path query.
*   The recursive `H` step uses a `CYCLE` clause, so a sourcing loop stops at the repeated organization rather than running indefinitely.
*   Sourcing rows are filtered to the most specific sourcing level by an analytic minimum, which removes lower-priority assignments before the joins.
*   The output is limited to organizations visible to the current responsibility through `ORG_ACCESS_VIEW`.

### FAQ
**Q: How is PII calculated for an item moved through several organizations?**
A: Each hop adds its converted profit to the PII of the previous hop, starting from the origin organization's stored PII, and the recursive query accumulates the result for every sourcing path.

**Q: What does Circular Sourcing mean in this report?**
A: It marks an organization reached only through a sourcing loop without an origin. Those rows are calculated for one hop from the source organization's stored PII.

**Q: Why are some calculated PII columns blank?**
A: A missing exchange rate leaves the calculated columns blank, and inactive items and items without costs in the source or receiving organization are not reported.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-calculate-icp-pii-item-costs-multi-hop)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
