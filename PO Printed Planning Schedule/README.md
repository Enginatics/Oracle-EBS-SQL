---
layout: default
title: 'PO Printed Planning Schedule | Oracle EBS SQL Report'
description: 'Migration of the Oracle standard concurrent program Printed Planning Schedule (XML) (CHVPRSCHXML) from Supplier Scheduling. Shows, for each confirmed…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Printed, Planning, Schedule, per_all_people_f, po_asl_attributes, chv_cum_periods'
permalink: /PO%20Printed%20Planning%20Schedule/
---

# PO Printed Planning Schedule – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-printed-planning-schedule/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Migration of the Oracle standard concurrent program Printed Planning Schedule (XML) (CHVPRSCH_XML) from Supplier Scheduling. Shows, for each confirmed planning/shipping schedule, the time-phased demand grid sent to the supplier - one row per schedule, item and time bucket - with forecast, released, total and cumulative (CUM+) quantities per bucket, plus the schedule header, item, CUM and authorization context. The horizontal schedule grid (chv_horizontal_schedules, up to 60 bucket columns) is un-pivoted into rows for analysis in Excel.

## Report Parameters
Organization, Supplier, Supplier Site, Schedule Type, Schedule Number, Schedule Status, Horizon From, Horizon To, Exclude Zero Quantity Buckets

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [po_asl_attributes](https://www.enginatics.com/library/?pg=1&find=po_asl_attributes), [chv_cum_periods](https://www.enginatics.com/library/?pg=1&find=chv_cum_periods), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [chv_authorizations](https://www.enginatics.com/library/?pg=1&find=chv_authorizations), [chv_horizontal_schedules](https://www.enginatics.com/library/?pg=1&find=chv_horizontal_schedules), [table](https://www.enginatics.com/library/?pg=1&find=table), [chv_schedule_items](https://www.enginatics.com/library/?pg=1&find=chv_schedule_items), [chv_schedule_headers](https://www.enginatics.com/library/?pg=1&find=chv_schedule_headers), [chv_bucket_patterns](https://www.enginatics.com/library/?pg=1&find=chv_bucket_patterns), [chv_org_options](https://www.enginatics.com/library/?pg=1&find=chv_org_options), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PO Supplier Scheduling On-Time Delivery](/PO%20Supplier%20Scheduling%20On-Time%20Delivery/ "PO Supplier Scheduling On-Time Delivery Oracle EBS SQL Report"), [PO Approved Supplier List Upload](/PO%20Approved%20Supplier%20List%20Upload/ "PO Approved Supplier List Upload Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Printed Planning Schedule 01-Jun-2026 020822.xlsx](https://www.enginatics.com/example/po-printed-planning-schedule/) |
| Blitz Report™ XML Import | [PO_Printed_Planning_Schedule.xml](https://www.enginatics.com/xml/po-printed-planning-schedule/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-printed-planning-schedule/](https://www.enginatics.com/reports/po-printed-planning-schedule/) |



---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
