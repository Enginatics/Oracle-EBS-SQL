---
layout: default
title: 'INV Cycle count hit/miss analysis | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle count hit/miss analysis report Source: Cycle count hit/miss analysis (XML) Short Name: INVARHMAXML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Cycle, count, hit/miss, mfg_lookups, mtl_abc_classes, mtl_cycle_count_classes'
permalink: /INV%20Cycle%20count%20hit-miss%20analysis/
---

# INV Cycle count hit/miss analysis – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-count-hit-miss-analysis/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle count hit/miss analysis report
Source: Cycle count hit/miss analysis (XML)
Short Name: INVARHMA_XML
DB package: INV_INVARHMA_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name, Count Date From, Count Date To

## Oracle EBS Tables Used
[mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [mtl_cycle_count_classes](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_classes), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mtl_cycle_count_items](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_items), [mtl_cycle_count_entries](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_entries)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle count unscheduled items](/INV%20Cycle%20count%20unscheduled%20items/ "INV Cycle count unscheduled items Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Cycle count hit miss analysis 10-Mar-2026 205843.xlsx](https://www.enginatics.com/example/inv-cycle-count-hit-miss-analysis/) |
| Blitz Report™ XML Import | [INV_Cycle_count_hit_miss_analysis.xml](https://www.enginatics.com/xml/inv-cycle-count-hit-miss-analysis/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-count-hit-miss-analysis/](https://www.enginatics.com/reports/inv-cycle-count-hit-miss-analysis/) |

## INV Cycle count hit-miss analysis - Case Study & Technical Analysis

### Executive Summary
The **INV Cycle count hit/miss analysis** report is a performance metric report used to evaluate the accuracy of the inventory records. It classifies each count as a "Hit" (accurate within tolerance) or a "Miss" (inaccurate). This report is essential for measuring the effectiveness of the inventory management process and is often a key KPI for warehouse managers.

### Business Use Cases
*   **KPI Reporting**: Calculates the "Inventory Record Accuracy" percentage (Hits / Total Counts).
*   **Tolerance Tuning**: Helps determine if current tolerances are too strict (too many misses) or too loose (100% hits but poor operational reality).
*   **Root Cause Analysis**: By grouping misses by ABC class or Subinventory, managers can identify problem areas (e.g., "Why do we have so many misses in the Bulk Zone?").

### Technical Analysis

#### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: Stores the count results.
*   `MTL_CYCLE_COUNT_CLASSES`: Defines the hit/miss tolerances for each class.
*   `MTL_ABC_CLASSES`: The ABC classes (A, B, C).

#### Key Joins & Logic
*   **Hit/Miss Logic**: The system compares the `ADJUSTMENT_QUANTITY` (or value) against the tolerances defined in `MTL_CYCLE_COUNT_CLASSES`.
    *   If `ABS(Variance) <= Tolerance`, it's a **Hit**.
    *   Otherwise, it's a **Miss**.
*   **Aggregation**: The report typically aggregates these counts to show percentages by Class or Subinventory.

#### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Start/End Date**: The period to analyze.


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
