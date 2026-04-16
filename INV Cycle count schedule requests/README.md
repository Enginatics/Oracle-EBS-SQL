---
layout: default
title: 'INV Cycle count schedule requests | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle count schedule requests report Source: Cycle count schedule requests report (XML) Short Name: INVARRTAXML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Cycle, count, schedule, mtl_cycle_count_headers, mtl_cc_schedule_requests, mtl_item_locations_kfv'
permalink: /INV%20Cycle%20count%20schedule%20requests/
---

# INV Cycle count schedule requests – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-count-schedule-requests/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle count schedule requests report
Source: Cycle count schedule requests report (XML)
Short Name: INVARRTA_XML
DB package: INV_INVARRTA_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name, Start Date, End Date, Category Set 1, Category Set 2, Category Set 3

## Oracle EBS Tables Used
[mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_cc_schedule_requests](https://www.enginatics.com/library/?pg=1&find=mtl_cc_schedule_requests), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle count unscheduled items](/INV%20Cycle%20count%20unscheduled%20items/ "INV Cycle count unscheduled items Oracle EBS SQL Report"), [INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-cycle-count-schedule-requests/) |
| Blitz Report™ XML Import | [INV_Cycle_count_schedule_requests.xml](https://www.enginatics.com/xml/inv-cycle-count-schedule-requests/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-count-schedule-requests/](https://www.enginatics.com/reports/inv-cycle-count-schedule-requests/) |

## INV Cycle count schedule requests - Case Study & Technical Analysis

### Executive Summary
The **INV Cycle count schedule requests** report documents the *intent* to count. It lists the items that have been selected by the automatic scheduler or manually requested for counting. This is the upstream step before "Entries" are generated. It helps inventory managers understand what the system is planning to count based on the frequency rules (e.g., "Count 'A' items 12 times a year").

### Business Use Cases
*   **Schedule Validation**: Verifies that the automatic scheduler is picking up the correct items.
*   **Workload Planning**: Helps warehouse managers estimate the labor required for the upcoming week's counts.
*   **Coverage Analysis**: Ensures that all items in a specific category or subinventory are being scheduled.

### Technical Analysis

#### Core Tables
*   `MTL_CC_SCHEDULE_REQUESTS`: Stores the request to count an item.
*   `MTL_CYCLE_COUNT_HEADERS`: The cycle count definition.
*   `MTL_SYSTEM_ITEMS_VL`: Item details.

#### Key Joins & Logic
*   **Auto-Schedule Logic**: The system generates records in `MTL_CC_SCHEDULE_REQUESTS` based on the item's ABC class and the last count date.
*   **Request to Entry**: A schedule request becomes an "Entry" (`MTL_CYCLE_COUNT_ENTRIES`) once the "Generate Cycle Count Requests" program is run. This report shows the state *before* or *during* that generation.

#### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Category Set**: Filter by item category to check scheduling for specific product lines.


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
