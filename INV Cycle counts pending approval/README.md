---
layout: default
title: 'INV Cycle counts pending approval | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle counts pending approval report Source: Cycle counts pending approval report (XML) Short Name: INVARCPAXML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Cycle, counts, pending, mtl_cc_serial_numbers, mtl_item_locations_kfv, mtl_system_items_vl'
permalink: /INV%20Cycle%20counts%20pending%20approval/
---

# INV Cycle counts pending approval – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-counts-pending-approval/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle counts pending approval report
Source: Cycle counts pending approval report (XML)
Short Name: INVARCPA_XML
DB package: INV_INVARCPA_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name, Category Set 1, Category Set 2, Category Set 3, Sort By

## Oracle EBS Tables Used
[mtl_cc_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_cc_serial_numbers), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_cycle_count_items](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_items), [mtl_cycle_count_entries](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_entries), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report"), [INV Cycle count schedule requests](/INV%20Cycle%20count%20schedule%20requests/ "INV Cycle count schedule requests Oracle EBS SQL Report"), [INV Cycle count unscheduled items](/INV%20Cycle%20count%20unscheduled%20items/ "INV Cycle count unscheduled items Oracle EBS SQL Report"), [INV Transaction Register](/INV%20Transaction%20Register/ "INV Transaction Register Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-cycle-counts-pending-approval/) |
| Blitz Report™ XML Import | [INV_Cycle_counts_pending_approval.xml](https://www.enginatics.com/xml/inv-cycle-counts-pending-approval/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-counts-pending-approval/](https://www.enginatics.com/reports/inv-cycle-counts-pending-approval/) |

## INV Cycle counts pending approval - Case Study & Technical Analysis

### Executive Summary
The **INV Cycle counts pending approval** report is a workflow management tool for inventory supervisors. It lists all cycle count entries where the variance (difference between system and physical count) exceeds the pre-defined approval tolerances. These entries are "stuck" in a pending state until a manager reviews and approves (or rejects/recounts) them.

### Business Use Cases
*   **Approval Workflow**: The primary "inbox" for managers to review large adjustments before they hit the General Ledger.
*   **Fraud Detection**: Large variances needing approval are often the first indicator of theft or significant process failures.
*   **Period Close**: All pending approvals must be resolved before the inventory period can be closed effectively (or at least before the adjustments are reflected in finance).

### Technical Analysis

#### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: The count entries.
*   `MTL_CYCLE_COUNT_HEADERS`: Defines the approval tolerances.
*   `MTL_ABC_CLASSES`: Used if tolerances are defined by ABC class.

#### Key Joins & Logic
*   **Status Filter**: Filters for `ENTRY_STATUS_CODE` = 2 (Pending Approval).
*   **Tolerance Check**: The system automatically places an entry in this status if:
    *   `ABS(Variance Qty) > Quantity Tolerance` OR
    *   `ABS(Variance Value) > Value Tolerance`.
*   **Sorting**: Often sorted by value to prioritize the biggest hits.

#### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Sort By**: Options usually include Item, Location, or Variance Value.


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
