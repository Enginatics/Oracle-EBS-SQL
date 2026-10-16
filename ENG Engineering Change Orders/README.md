---
layout: default
last_modified_at: 2026-10-16
title: 'ENG Engineering Change Orders | Oracle EBS SQL Report'
description: 'Engineering change orders (ECOs) with one row per revised item: the ECO header with its type, status, approval status, priority, reason, requestor and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Engineering, Enginatics, ENG, Change, Orders, hz_parties, hr_all_organization_units_vl, bom_structures_b'
permalink: /ENG%20Engineering%20Change%20Orders/
report_name: 'ENG Engineering Change Orders'
report_web_name: eng-engineering-change-orders
module: 'Engineering'
module_url: /modules/engineering/
---

# ENG Engineering Change Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eng-engineering-change-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders).
**Oracle EBS module:** [Engineering](/modules/engineering/ "Oracle EBS Engineering reports") · [all Engineering reports](/modules/engineering/)  

## Overview
Engineering change orders (ECOs) with one row per revised item: the ECO header with its type, status, approval status, priority, reason, requestor and dates, and the revised item with its new revision, effectivity, implementation and cancellation dates, use-up item and material disposition. An ECO without revised items is listed once with blank revised item columns.

Change types are those based on the Change Order change category, as on the Engineering Change Orders form.

Show Component Changes adds one row per component the revised item adds, changes or disables. Old Quantity and Old Op Seq come from the component the change replaces.

Open Jobs is the current number of unreleased, released and on hold discrete jobs building the revised item in the ECO's organization, whatever the ECO's status. Open Job List shows the first 15 of these jobs by scheduled start date.

Estimated Eng Cost and Estimated Mfg Cost are shown on the first row of an ECO and Open Jobs on the first row of a revised item only, so that they can be summed.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, ECO, Change Type, ECO Status, Approval Status, Open Only, Revised Item, Effectivity Date From, Effectivity Date To, Show Component Changes, Show DFF Attributes

## Oracle EBS Tables Used
[hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [eng_engineering_changes](https://www.enginatics.com/library/?pg=1&find=eng_engineering_changes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [eng_change_order_types_vl](https://www.enginatics.com/library/?pg=1&find=eng_change_order_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [eng_revised_items](https://www.enginatics.com/library/?pg=1&find=eng_revised_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [BOM Bill of Material Structure](/BOM%20Bill%20of%20Material%20Structure/ "BOM Bill of Material Structure Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ENG%20Engineering%20Change%20Orders/ENG%20Engineering%20Change%20Orders.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ENG Engineering Change Orders 15-Oct-2026 022515.xlsx](https://www.enginatics.com/example/eng-engineering-change-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders) |
| Blitz Report™ XML Import | [ENG_Engineering_Change_Orders.xml](https://www.enginatics.com/xml/eng-engineering-change-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders) |
| SQL Source | [ENG Engineering Change Orders.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ENG%20Engineering%20Change%20Orders/ENG%20Engineering%20Change%20Orders.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eng-engineering-change-orders/](https://www.enginatics.com/reports/eng-engineering-change-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders) |

## Case Study & Technical Analysis: ENG Engineering Change Orders

### Executive Summary
This report lists engineering change orders (ECOs) with one row per revised item, showing the change header, its type, status and approval state, and for each revised item its new revision, effectivity dates, use-up item and material disposition. Change coordinators, item engineers and planners use it to see which changes are pending, approved or implemented, and their effect on items. It runs in Excel through Blitz Report™, and optionally shows component changes and the open discrete jobs that build each revised item.

### Business Challenge
*   **Change visibility:** Engineering changes move through approval and implementation across many items, and the status of each revised item must be visible in one list.
*   **Effectivity planning:** Manufacturing needs the early and scheduled effectivity dates of each revised item to plan the cut-in of new revisions.
*   **Impact on open work:** An ECO that changes an item affects the unreleased, released and on-hold jobs building that item, which planners must identify before the change takes effect.
*   **Cost tracking:** Estimated costs should be reported once per change, not once per revised item.

### The Solution
*   Lists each ECO with its change type, status, approval status, priority, reason, requestor, assignee and responsible organization.
*   Shows each revised item with its new item revision, routing revision, early and scheduled effectivity dates, implementation and cancellation dates, use-up item and disposition.
*   Adds one row per component when Show Component Changes is requested, with the old quantity and old operation sequence of the component the change replaces.
*   Counts the open jobs for each revised item in the ECO's organization, and lists the first 15 of them by scheduled start date.

### Technical Architecture (High Level)
#### Primary Tables
*   `ENG_ENGINEERING_CHANGES`: the change order header, including change notice, status, approval dates, cost estimates and requestor.
*   `ENG_CHANGE_ORDER_TYPES_VL`: the change order types, restricted to those based on the Change Order change category.
*   `ENG_REVISED_ITEMS`: the items revised by each change, with new revisions, effectivity, implementation and disposition.
*   `MTL_SYSTEM_ITEMS_VL`: the revised item and the use-up item, with their item numbers and descriptions.
*   `BOM_STRUCTURES_B`: the alternate bill of material designator of a revised item.
*   `WIP_DISCRETE_JOBS` and `WIP_ENTITIES`: the discrete jobs building each revised item, with their job names and status types.
*   `HZ_PARTIES` and `HR_ALL_ORGANIZATION_UNITS_VL`: requestor, assignee and responsible organization names.
*   `MTL_PARAMETERS` and `ORG_ACCESS_VIEW`: the organization code and the organizations the responsibility can access.

#### Logical Relationships
1.  Each ECO is joined to its change order type, and only types based on the CHANGE_ORDER change category are kept.
2.  ECOs are outer-joined to their revised items on change notice and organization, so an ECO with no revised items is listed once with blank item columns.
3.  Each revised item is joined to its item master record in `MTL_SYSTEM_ITEMS_VL`, and the open job summary is joined on organization and item.
4.  The open job summary is built from discrete jobs with status types 1, 3 and 6, which are the unreleased, released and on-hold statuses.
5.  Component changes, when requested, add extra joins and rows within each revised item.
6.  Results are ordered by organization code, change notice, revised item and revised item sequence.

### Parameters & Filtering
*   **Organization Code**, **ECO** and **Change Type:** narrow the changes to one organization, one change notice or one change order type.
*   **ECO Status**, **Approval Status** and **Open Only:** filter on the state of the change.
*   **Revised Item:** limits the output to ECOs that revise a given item.
*   **Effectivity Date From** and **Effectivity Date To:** select revised items by effectivity date.
*   **Show Component Changes** and **Show DFF Attributes:** add the component rows and the descriptive flexfield columns to the output.

### Performance & Optimization
*   The open job summary is an inline view grouped by organization and item, restricted to the revised items in scope.
*   The open job list is built with an aggregate string function that keeps only the first 15 jobs by scheduled start date, which bounds the length of the column.
*   Estimated costs use a row-numbering window function, so they appear once per change.
*   The organization access view limits the organizations to those of the current responsibility.

### FAQ
**Q: Why are the estimated costs shown on only one row for each ECO?**
A: The report numbers each change's rows and returns the estimated engineering and manufacturing cost only on the first row, so the costs can be summed without counting them once per revised item.

**Q: How are open jobs counted for a revised item?**
A: Open Jobs counts the discrete jobs in the ECO's organization that build the revised item and are unreleased, released or on hold, whatever the status of the ECO.

**Q: Which change types does the report include?**
A: It includes only change order types based on the Change Order change category, as shown on the Engineering Change Orders form.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eng-engineering-change-orders)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
