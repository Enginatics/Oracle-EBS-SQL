---
layout: default
last_modified_at: 2026-10-26
title: 'PO Printed Planning Schedule | Oracle EBS SQL Report'
description: 'Migration of the Oracle standard concurrent program Printed Planning Schedule (XML) (CHVPRSCHXML) from Supplier Scheduling. Shows, for each confirmed…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, Printed, Planning, Schedule, per_all_people_f, po_asl_attributes, chv_cum_periods'
permalink: /PO%20Printed%20Planning%20Schedule/
report_name: 'PO Printed Planning Schedule'
report_web_name: po-printed-planning-schedule
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Printed Planning Schedule – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-printed-planning-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
Migration of the Oracle standard concurrent program Printed Planning Schedule (XML) (CHVPRSCH_XML) from Supplier Scheduling. Shows, for each confirmed planning/shipping schedule, the time-phased demand grid sent to the supplier - one row per schedule, item and time bucket - with forecast, released, total and cumulative (CUM+) quantities per bucket, plus the schedule header, item, CUM and authorization context. The horizontal schedule grid (chv_horizontal_schedules, up to 60 bucket columns) is un-pivoted into rows for analysis in Excel.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization, Supplier, Supplier Site, Schedule Type, Schedule Number, Schedule Status, Horizon From, Horizon To, Exclude Zero Quantity Buckets

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [po_asl_attributes](https://www.enginatics.com/library/?pg=1&find=po_asl_attributes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_cum_periods](https://www.enginatics.com/library/?pg=1&find=chv_cum_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_authorizations](https://www.enginatics.com/library/?pg=1&find=chv_authorizations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_horizontal_schedules](https://www.enginatics.com/library/?pg=1&find=chv_horizontal_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_schedule_items](https://www.enginatics.com/library/?pg=1&find=chv_schedule_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_schedule_headers](https://www.enginatics.com/library/?pg=1&find=chv_schedule_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_bucket_patterns](https://www.enginatics.com/library/?pg=1&find=chv_bucket_patterns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [chv_org_options](https://www.enginatics.com/library/?pg=1&find=chv_org_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)

## Related Reports
[PO Approved Supplier List Upload](/PO%20Approved%20Supplier%20List%20Upload/ "PO Approved Supplier List Upload Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [PO Supplier Scheduling On-Time Delivery](/PO%20Supplier%20Scheduling%20On-Time%20Delivery/ "PO Supplier Scheduling On-Time Delivery Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Printed%20Planning%20Schedule/PO%20Printed%20Planning%20Schedule.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Printed Planning Schedule 01-Jun-2026 020822.xlsx](https://www.enginatics.com/example/po-printed-planning-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule) |
| Blitz Report™ XML Import | [PO_Printed_Planning_Schedule.xml](https://www.enginatics.com/xml/po-printed-planning-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule) |
| SQL Source | [PO Printed Planning Schedule.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Printed%20Planning%20Schedule/PO%20Printed%20Planning%20Schedule.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-printed-planning-schedule/](https://www.enginatics.com/reports/po-printed-planning-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule) |

## Case Study & Technical Analysis: PO Printed Planning Schedule

### Executive Summary
The PO Printed Planning Schedule report reproduces the time-phased demand schedule that Oracle Purchasing sends to a supplier under Supplier Scheduling. It is a migration of the standard concurrent program Printed Planning Schedule (XML). Each row is one bucket of one item on one confirmed planning or shipping schedule, with the forecast, released, total and cumulative (CUM) quantities of that bucket. Buyers and supplier planners use it to check the demand that was communicated to a supplier, to compare the released quantity with the forecast, and to analyze the schedule in Excel rather than in the printed XML document. The report runs through Blitz Report.

### Business Challenge
*   **Supplier demand visibility:** Buyers need to see what was sent to each supplier, by item and time bucket, without opening the printed schedule for each supplier site.
*   **Forecast against release:** Supplier planners must compare the forecast and released quantities by bucket to see where the release has diverged from the plan.
*   **Cumulative tracking:** Where cumulative quantity control applies, the CUM quantity, starting CUM and last receipt must be checked against the bucket quantities.
*   **Authorization control:** The authorizations issued against each schedule item must be visible to confirm the commitment given to the supplier.

### The Solution
*   **Schedule header and item context:** Each schedule carries its number, type, subtype, status, revision, horizon, MRP, MPS and DRP plan designators, supplier and supplier site.
*   **Bucket un-pivoting:** The horizontal schedule grid, which stores up to sixty bucket columns per row type, is un-pivoted into one row per bucket using a row generator.
*   **CUM context:** The CUM period, starting cumulative quantity, enable CUM flag and last receipt number and quantity are shown beside each item.
*   **Authorizations:** Up to four authorizations per schedule item are shown with their type and schedule quantity.

### Technical Architecture (High Level)
#### Primary Tables
*   `CHV_SCHEDULE_HEADERS`: the schedule header, with number, type, status, horizon, plan designators, vendor and site.
*   `CHV_SCHEDULE_ITEMS`: the item on the schedule, with its purchasing unit of measure, CUM quantity, last receipt and purchase order.
*   `CHV_HORIZONTAL_SCHEDULES`: the horizontal schedule grid, with one row per row type and schedule item, holding up to sixty bucket cells.
*   `CHV_BUCKET_PATTERNS`: the bucket pattern name of the schedule.
*   `CHV_AUTHORIZATIONS`: the authorization type and quantity of each schedule item.
*   `CHV_CUM_PERIODS`: the CUM period of the organization.
*   `CHV_ORG_OPTIONS`: the CUM enablement flag of the organization.
*   `PO_VENDORS` and `PO_VENDOR_SITES_ALL`: the supplier and supplier site.
*   `PO_HEADERS_ALL`: the supply agreement number.
*   `PO_ASL_ATTRIBUTES`: the approved supplier list attributes, used to find the scheduler.
*   `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the last receipt and shipment number.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the item, its description and buyer.
*   `PER_ALL_PEOPLE_F`: the buyer and scheduler names.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.

#### Logical Relationships
1.  `CHV_HORIZONTAL_SCHEDULES` is joined to a row generator of sixty positions, and each position selects the matching cell from the bucket columns by bucket sequence.
2.  The cells are grouped by schedule, schedule item and bucket sequence, so each bucket has one value per row type, and buckets without a descriptor are dropped.
3.  The bucket rows join to `CHV_SCHEDULE_ITEMS` and then to `CHV_SCHEDULE_HEADERS`, which joins to the bucket pattern, the vendor and the vendor site.
4.  `CHV_SCHEDULE_ITEMS` joins to the item, the organization, the CUM options and the supply agreement.
5.  Output is ordered by schedule number, item and bucket sequence.

### Parameters & Filtering
*   **Organization:** selects the organization that issued the schedule.
*   **Supplier** and **Supplier Site:** select the supplier and the site that received it.
*   **Schedule Type:** selects planning or shipping schedules.
*   **Schedule Number:** selects one schedule.
*   **Schedule Status:** restricts the output to schedules in one status.
*   **Horizon From** and **Horizon To:** bound the schedule horizon.
*   **Exclude Zero Quantity Buckets:** when set, buckets with no quantity are removed from the output.

### Performance & Optimization
*   The bucket un-pivot uses a row generator, so the sixty bucket columns are read once and folded into rows without a union of sixty queries.
*   Buckets without a descriptor are removed by a `HAVING` filter in the grouped inline view, so empty columns do not reach the main query.
*   Authorizations and the last receipt are scalar subqueries keyed on the schedule item, each restricted by sequence or ID.
*   Purged items are excluded, and the organization restriction is applied through `ORG_ACCESS_VIEW`, with a fallback that returns all rows when the responsibility has no org access rows.

### FAQ
**Q: What do the forecast, released, total and CUM columns show?**
A: For each bucket they show the forecast quantity, the released quantity, the total quantity and the cumulative quantity sent to the supplier.

**Q: Why are there several authorization columns?**
A: The schedule item can carry up to four authorizations, and the report shows the type and schedule quantity of each one in its own column pair.

**Q: How do I see only the buckets that carry demand?**
A: Set Exclude Zero Quantity Buckets to remove buckets with no quantity.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-printed-planning-schedule)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
