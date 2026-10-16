---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Number of Item Costs by Cost Type | Oracle EBS SQL Report'
description: 'Report to show the count of item costs by cost type. Use this report after you copy from one cost type to another, to ensure all rows have been copied…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Number, Item, Costs, cst_item_costs, mtl_parameters, cst_cost_types'
permalink: /CAC%20Number%20of%20Item%20Costs%20by%20Cost%20Type/
report_name: 'CAC Number of Item Costs by Cost Type'
report_web_name: cac-number-of-item-costs-by-cost-type
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Number of Item Costs by Cost Type – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-number-of-item-costs-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show the count of item costs by cost type.  Use this report after you copy from one cost type to another, to ensure all rows have been copied over.

/* +=============================================================================+
-- |  Copyright 2017 - 2019 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_count_costs_by_cost_type.sql
-- |
-- |  Parameters:
-- |  p_from_cost_type       -- The cost type you copied from, mandatory
-- |  p_to_cost_type         -- The cost type you copied to, mandatory
-- |  p_from_org_code        -- The inventory organization you copied from, if  
-- |                            enter a blank or null value you get all organizations
-- |  p_to_org_code          -- The inventory organization you copied to, if  
-- |                            enter a blank or null value you get all organizations
-- | 
-- |  Description:
-- |  Report to show the count of item costs by cost type.  Use this report after
-- |  you copy from one cost type to another, to ensure all rows have been copied over.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     04 May 2017 Douglas Volz   Initial Coding
-- |  1.1     31 Aug 2019 Douglas Volz   Added to and from cost types and org codes
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
From Cost Type, To Cost Type, From Org Code, To Org Code

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)

## Related Reports
[INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC Resource Costs](/CAC%20Resource%20Costs/ "CAC Resource Costs Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Number%20of%20Item%20Costs%20by%20Cost%20Type/CAC%20Number%20of%20Item%20Costs%20by%20Cost%20Type.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Number of Item Costs by Cost Type 07-Jul-2022 152510.xlsx](https://www.enginatics.com/example/cac-number-of-item-costs-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type) |
| Blitz Report™ XML Import | [CAC_Number_of_Item_Costs_by_Cost_Type.xml](https://www.enginatics.com/xml/cac-number-of-item-costs-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type) |
| SQL Source | [CAC Number of Item Costs by Cost Type.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Number%20of%20Item%20Costs%20by%20Cost%20Type/CAC%20Number%20of%20Item%20Costs%20by%20Cost%20Type.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-number-of-item-costs-by-cost-type/](https://www.enginatics.com/reports/cac-number-of-item-costs-by-cost-type/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type) |

## Case Study & Technical Analysis: CAC Number of Item Costs by Cost Type

### Executive Summary
The **CAC Number of Item Costs by Cost Type** report is a simple but vital utility for Cost Accountants. It provides a count of how many items exist in one Cost Type versus another. This is primarily used during the "Cost Copy" process to verify that the copy was successful and complete.

### Business Challenge
*   **Completeness Check**: You have 10,000 items in your "Frozen" cost type. You copy them to "Pending" to simulate a price increase. Did all 10,000 copy over? Or did 50 fail?
*   **Multi-Org Validation**: Did the copy process work for all 5 inventory organizations, or did one fail?

### Solution
This report provides a side-by-side count.
*   **Comparison**: Count(Cost Type A) vs. Count(Cost Type B).
*   **Granularity**: Breaks down the count by Organization.
*   **Variance**: Ideally, the counts should match (or match the expected subset).

### Technical Architecture
*   **Query**: `SELECT count(*) FROM cst_item_costs GROUP BY organization_id, cost_type_id`.
*   **Logic**: Simple aggregation.

### Parameters
*   **From Cost Type**: (Mandatory) Source.
*   **To Cost Type**: (Mandatory) Target.
*   **Org Code**: (Optional) Filter.

### Performance
*   **Instant**: Counting rows is extremely fast in Oracle.

### FAQ
**Q: Why would the counts differ?**
A: The "Cost Copy" program has options to "Copy Only Based on Rollup" or "Copy Only Buy Items". If you used these filters, the target count will be lower. Also, if an item already exists in the target, it's an update, not an insert, so the count might not change.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-number-of-item-costs-by-cost-type)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
