---
layout: default
title: 'INV Cycle count open requests listing | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle count open requests listing report Source: Cycle count open requests listing (XML) Short Name: INVAROREXML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Cycle, count, open, mtl_cc_serial_numbers, mfg_lookups, mtl_item_locations_kfv'
permalink: /INV%20Cycle%20count%20open%20requests%20listing/
---

# INV Cycle count open requests listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-count-open-requests-listing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle count open requests listing report
Source: Cycle count open requests listing (XML)
Short Name: INVARORE_XML
DB package: INV_INVARORE_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name, Overdue Requests Only

## Oracle EBS Tables Used
[mtl_cc_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_cc_serial_numbers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_item_flexfields](https://www.enginatics.com/library/?pg=1&find=mtl_item_flexfields), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_cycle_count_items](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_items), [mtl_cycle_count_entries](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_entries), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report"), [INV Cycle count unscheduled items](/INV%20Cycle%20count%20unscheduled%20items/ "INV Cycle count unscheduled items Oracle EBS SQL Report"), [INV Print Cycle Count Entries Open Interface data](/INV%20Print%20Cycle%20Count%20Entries%20Open%20Interface%20data/ "INV Print Cycle Count Entries Open Interface data Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Cycle count schedule requests](/INV%20Cycle%20count%20schedule%20requests/ "INV Cycle count schedule requests Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-cycle-count-open-requests-listing/) |
| Blitz Report™ XML Import | [INV_Cycle_count_open_requests_listing.xml](https://www.enginatics.com/xml/inv-cycle-count-open-requests-listing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-count-open-requests-listing/](https://www.enginatics.com/reports/inv-cycle-count-open-requests-listing/) |

## INV Cycle count open requests listing - Case Study & Technical Analysis

### Executive Summary
The **INV Cycle count open requests listing** report focuses specifically on cycle count entries that are **incomplete**. An "open request" is a generated count task that has not yet been fully processed (counted, entered, and approved). This report is a "To-Do List" for the inventory team to ensure all counts are closed out before the period end.

### Business Use Cases
*   **Backlog Management**: Identifies counts that were generated but never executed (e.g., lost tags, forgotten aisles).
*   **Period Close Prep**: Oracle Inventory often requires all cycle count entries to be processed before certain period-end activities; this report identifies the blockers.
*   **Overdue Analysis**: Highlights counts that have been open longer than the standard SLA.

### Technical Analysis

#### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: The primary source, filtered for open statuses.
*   `MTL_CC_SCHEDULE_REQUESTS`: The schedule request that spawned the entry.

#### Key Joins & Logic
*   **Open Status Filter**: The query specifically looks for `ENTRY_STATUS_CODE` NOT IN (Completed, Recount).
*   **Late Logic**: If "Overdue Requests Only" is selected, it compares the `CREATION_DATE` or `COUNT_DUE_DATE` against the current date.

#### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Overdue Requests Only**: Flag to show only late counts.


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
