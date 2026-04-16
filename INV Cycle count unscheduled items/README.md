---
layout: default
title: 'INV Cycle count unscheduled items | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle count unscheduled items report Source: Cycle count unscheduled items report (XML) Short Name: INVARUIRXML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Cycle, count, unscheduled, mfg_lookups, mtl_abc_classes, mtl_system_items_vl'
permalink: /INV%20Cycle%20count%20unscheduled%20items/
---

# INV Cycle count unscheduled items – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-count-unscheduled-items/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle count unscheduled items report
Source: Cycle count unscheduled items report (XML)
Short Name: INVARUIR_XML
DB package: INV_INVARUIR_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name

## Oracle EBS Tables Used
[mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_cycle_count_items](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_items), [mtl_cycle_count_classes](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_classes), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report"), [INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-cycle-count-unscheduled-items/) |
| Blitz Report™ XML Import | [INV_Cycle_count_unscheduled_items.xml](https://www.enginatics.com/xml/inv-cycle-count-unscheduled-items/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-count-unscheduled-items/](https://www.enginatics.com/reports/inv-cycle-count-unscheduled-items/) |

## INV Cycle count unscheduled items - Case Study & Technical Analysis

### Executive Summary
The **INV Cycle count unscheduled items** report identifies items that are part of a cycle count definition (header) but have **not** been scheduled for counting within a specific timeframe. This is a "gap analysis" report used to ensure that no items are falling through the cracks of the cycle counting process, which is critical for maintaining 100% inventory coverage over the course of a year.

### Business Use Cases
*   **Coverage Verification**: Ensures that every item in the warehouse is being counted at least once per year (or as defined by its ABC class).
*   **Scheduler Troubleshooting**: If the auto-scheduler is running but items aren't appearing on count sheets, this report helps identify which items are being skipped.
*   **New Item Audit**: Verifies that newly created items have been properly picked up by the cycle count logic.

### Technical Analysis

#### Core Tables
*   `MTL_CYCLE_COUNT_ITEMS`: The list of items eligible for the cycle count.
*   `MTL_CC_SCHEDULE_REQUESTS`: The table checked to see if a schedule exists.
*   `MTL_CYCLE_COUNT_HEADERS`: The cycle count definition.

#### Key Joins & Logic
*   **Exclusion Logic**: The report selects items from `MTL_CYCLE_COUNT_ITEMS` where there is NO corresponding record in `MTL_CC_SCHEDULE_REQUESTS` (or `MTL_CYCLE_COUNT_ENTRIES`) for the given period.
*   **Class Logic**: It often groups by ABC class to show, for example, "Which 'A' items haven't been counted this month?".

#### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Organization Code**: The inventory organization.


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
