---
layout: default
last_modified_at: 2026-10-26
title: 'CAC OPM Item Cost Detail | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) item cost detail: the costed value of each item broken out by cost component class (material, labor, burden, overhead)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, OPM, Item, Cost, cm_cmpt_dtl, mtl_system_items_vl, cm_cmpt_mst_vl'
permalink: /CAC%20OPM%20Item%20Cost%20Detail/
report_name: 'CAC OPM Item Cost Detail'
report_web_name: cac-opm-item-cost-detail
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC OPM Item Cost Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-opm-item-cost-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Oracle Process Manufacturing (OPM) item cost detail: the costed value of each item broken out by cost component class (material, labor, burden, overhead) and cost analysis code, per cost calendar, period and method. Answers what makes up an item's OPM cost.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Cost Calendar, Cost Method, Cost Component Class

## Oracle EBS Tables Used
[cm_cmpt_dtl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [cm_cmpt_mst_vl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)

## Related Reports
[CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [OPM Actual Cost Adjustment Upload](/OPM%20Actual%20Cost%20Adjustment%20Upload/ "OPM Actual Cost Adjustment Upload Oracle EBS SQL Report"), [INV Slow Moving Inventory](/INV%20Slow%20Moving%20Inventory/ "INV Slow Moving Inventory Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20Item%20Cost%20Detail/CAC%20OPM%20Item%20Cost%20Detail.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC OPM Item Cost Detail 05-Jun-2026 120011.xlsx](https://www.enginatics.com/example/cac-opm-item-cost-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail) |
| Blitz Report™ XML Import | [CAC_OPM_Item_Cost_Detail.xml](https://www.enginatics.com/xml/cac-opm-item-cost-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail) |
| SQL Source | [CAC OPM Item Cost Detail.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20OPM%20Item%20Cost%20Detail/CAC%20OPM%20Item%20Cost%20Detail.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-opm-item-cost-detail/](https://www.enginatics.com/reports/cac-opm-item-cost-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail) |

## Case Study & Technical Analysis: CAC OPM Item Cost Detail

### Executive Summary
The CAC OPM Item Cost Detail report shows the costed value of each Oracle Process Manufacturing (OPM) item, broken out by cost component class and cost analysis code. It is organized by organization, item, cost calendar, period and cost method, so a cost accountant can see what makes up the cost of an item in a given period. Cost accountants and plant controllers use it to explain item cost movements, to check material, labor, burden and overhead rates and to compare costing methods. The report runs in Excel through Blitz Report, and its rows can be summed by component class in the workbook.

### Business Challenge
*   **Cost explanation:** A change in an item's OPM cost must be traced to the component class that caused it, which requires the cost detail rather than the total cost.
*   **Period analysis:** Items are costed for each period of a cost calendar, so the cost of the same item must be compared across periods.
*   **Method comparison:** An item can be costed under more than one cost method, and the results must be read side by side.
*   **Responsibility-based access:** Cost data must be restricted to the organizations the user is authorized to see.

### The Solution
*   Shows the costed value of each item, the component cost, for each cost component class such as material, labor, burden and overhead.
*   Adds the cost analysis code and the total quantity used in the cost calculation, so that the cost per unit can be checked.
*   Shows the item code and description from the item master, the organization code, the calendar and period code and the cost method and its description.
*   Excludes rows marked as deleted, so that only current cost detail is listed.

### Technical Architecture (High Level)
#### Primary Tables
*   `CM_CMPT_DTL`: the cost component detail of each item, with the component cost, total quantity and cost analysis code.
*   `MTL_SYSTEM_ITEMS_VL`: the item, its concatenated segments and its description.
*   `CM_CMPT_MST_VL`: the cost component class names and codes.
*   `CM_MTHD_MST`: the cost method names and codes, linked to the cost type of each detail row.
*   `GMF_PERIOD_STATUSES`: the periods of each calendar, linked to the period of the cost detail.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1.  `CM_CMPT_DTL` is joined to `MTL_SYSTEM_ITEMS_VL` on inventory item id and organization id, which gives the item for each cost row.
2.  `CM_CMPT_DTL` is joined to `CM_CMPT_MST_VL` on the cost component class id, and to `CM_MTHD_MST` on the cost type id.
3.  The period is an outer join to `GMF_PERIOD_STATUSES` on the period id, so cost rows without a period still appear.
4.  The organization is restricted by a subquery on `ORG_ACCESS_VIEW` using the application and responsibility of the current session, and the organization code comes from `ORG_ORGANIZATION_DEFINITIONS`.

### Parameters & Filtering
*   **Organization Code:** restricts the cost detail to one OPM organization.
*   **Item:** restricts the report to one item.
*   **Cost Calendar:** selects the cost calendar whose periods are reported.
*   **Cost Method:** selects one cost method.
*   **Cost Component Class:** selects one component class, such as material or overhead.

### Performance & Optimization
*   The organization access check is an IN subquery on `ORG_ACCESS_VIEW`, so it reads only the organizations granted to the responsibility.
*   The period join is an outer join on the period id, which keeps the period columns out of the driving path of the query.
*   Rows with a delete mark are excluded in the WHERE clause, which keeps deleted cost detail out of the result.
*   Filtering by Organization Code, Item and Cost Calendar is the most selective way to run the report, because the cost detail table is the largest in the query.

### FAQ
**Q: What makes up the cost of an OPM item in a period?**
A: Run the report for the item, calendar and period. Each row is one cost component class, such as material, labor, burden or overhead, with its component cost.

**Q: How do I compare the cost of an item under two cost methods?**
A: Run the report for the item once for each Cost Method, or leave Cost Method blank to list every method. Each row shows the cost method and its description.

**Q: Which cost analysis code is shown?**
A: The cost analysis code of each cost detail row, with the total quantity used in the cost calculation.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-opm-item-cost-detail)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
