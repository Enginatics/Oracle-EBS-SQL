---
layout: default
last_modified_at: 2026-10-16
title: 'EAM Work Requests | Oracle EBS SQL Report'
description: 'Maintenance work requests with their asset, priority, requester and the work order created for them, one row per work request. Days Open and Overdue apply…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enterprise Asset Management, Enginatics, EAM, Work, Requests, wip_eam_work_requests, mtl_parameters, mtl_system_items_vl'
permalink: /EAM%20Work%20Requests/
report_name: 'EAM Work Requests'
report_web_name: eam-work-requests
module: 'Enterprise Asset Management'
module_url: /modules/enterprise-asset-management/
---

# EAM Work Requests – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-work-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests).
**Oracle EBS module:** [Enterprise Asset Management](/modules/enterprise-asset-management/ "Oracle EBS Enterprise Asset Management reports") · [all Enterprise Asset Management reports](/modules/enterprise-asset-management/)  

## Overview
Maintenance work requests with their asset, priority, requester and the work order created for them, one row per work request.

Days Open and Overdue apply to requests that are neither rejected nor complete. Overdue means the expected resolution date has passed.

Work order status is the system status of the linked work order.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Creation Date From, Creation Date To, Status, Open Only, Without Work Order, Priority, Request Type, Owning Department, Asset Group, Asset Number

## Oracle EBS Tables Used
[wip_eam_work_requests](https://www.enginatics.com/library/?pg=1&find=wip_eam_work_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)

## Related Reports
[EAM Work Orders 11i](/EAM%20Work%20Orders%2011i/ "EAM Work Orders 11i Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [WIP Move Transaction Upload](/WIP%20Move%20Transaction%20Upload/ "WIP Move Transaction Upload Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Work%20Requests/EAM%20Work%20Requests.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [EAM Work Requests 15-Oct-2026 022702.xlsx](https://www.enginatics.com/example/eam-work-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests) |
| Blitz Report™ XML Import | [EAM_Work_Requests.xml](https://www.enginatics.com/xml/eam-work-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests) |
| SQL Source | [EAM Work Requests.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Work%20Requests/EAM%20Work%20Requests.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-work-requests/](https://www.enginatics.com/reports/eam-work-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests) |

## Case Study & Technical Analysis: EAM Work Requests

### Executive Summary
The EAM Work Requests report lists maintenance work requests in Oracle Enterprise Asset Management, one row per request. Each row shows the requested asset, its priority and type, the requester and the contact details, and the work order that was created from the request, if any. Maintenance coordinators and planners use it to see the open request backlog, the age of each request, and which requests are overdue against their expected resolution date. The report runs in Excel through Blitz Report, so the backlog can be sorted and shared with maintenance supervisors.

### Business Challenge
*   **Request backlog control:** Requests submitted by operators and departments must be triaged, and those without a work order must be identified before they are forgotten.
*   **Service level tracking:** Overdue requests, measured against the expected resolution date, need to be visible to the maintenance supervisor.
*   **Traceability to work orders:** Each request must be linked to its work order and the status of that work order, so that completion can be confirmed.
*   **Asset and department accountability:** Requests must be attributed to the owning department and the asset group that will carry the repair.

### The Solution
*   **Request register:** The report reads the work request register for the organization and presents the request number, description, status, priority, request type and asset.
*   **Ageing measures:** Days Open is calculated from the creation date for requests that are neither rejected nor complete, and Overdue flags open requests whose expected resolution date has passed.
*   **Work order link:** The linked work order name, its system status, and its scheduled and completion dates are shown beside the request.
*   **Requester details:** The requester, the person it was created for, the contact preference, phone and e-mail are resolved to readable values.

### Technical Architecture (High Level)
#### Primary Tables
*   `WIP_EAM_WORK_REQUESTS`: the work request register, holding the request number, status, priority, type, asset, dates and contact details.
*   `MTL_PARAMETERS`: the maintenance organization code.
*   `MTL_SYSTEM_ITEMS_VL`: the asset group item and its description.
*   `BOM_DEPARTMENTS`: the owning department of the request.
*   `WIP_ENTITIES`: the work order entity created from the request.
*   `WIP_DISCRETE_JOBS`: the work order status type and its scheduled and completion dates.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

#### Logical Relationships
1.  `WIP_EAM_WORK_REQUESTS` joins to `MTL_PARAMETERS` on the organization ID, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  The request joins to `MTL_SYSTEM_ITEMS_VL` on the asset group and organization, as an outer join, so requests without an asset group are kept.
3.  The request joins to `BOM_DEPARTMENTS` on the owning department ID, again as an outer join.
4.  The request joins to `WIP_ENTITIES` on the work order entity ID, and then to `WIP_DISCRETE_JOBS` on the same entity ID.
5.  Output is ordered by organization code, creation date descending and request number.

### Parameters & Filtering
*   **Organization Code:** selects the maintenance organization.
*   **Creation Date From** and **Creation Date To:** bound the creation date of the request.
*   **Status:** filters on the work request status.
*   **Open Only:** restricts the output to requests that are still open.
*   **Without Work Order:** shows only requests that have no work order yet.
*   **Priority** and **Request Type:** filter by the priority and type of the request.
*   **Owning Department:** filters on the department that owns the request.
*   **Asset Group** and **Asset Number:** limit the requests to one asset group or asset.

### Performance & Optimization
*   The main query starts from the request register, so the driving filter is the organization set from `ORG_ACCESS_VIEW` and the creation date range.
*   The work order link uses outer joins, so requests without a work order are returned without a second query.
*   Days Open and Overdue are computed as simple expressions on the request row, so no additional lookup table is needed.
*   Names of users and the lookup meanings are produced by `XXEN_UTIL` functions, which keeps the SQL to one pass over the register.

### FAQ
**Q: How are overdue work requests identified in this report?**
A: A request is marked overdue when its status is neither rejected nor complete and its expected resolution date is earlier than the current date.

**Q: How many days has a work request been open?**
A: The Days Open column is the number of days between the creation date and the current date, shown only for requests that are neither rejected nor complete.

**Q: How can I find requests that have not yet been turned into work orders?**
A: Set the Without Work Order parameter, which returns only requests with no linked work order.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-work-requests)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
