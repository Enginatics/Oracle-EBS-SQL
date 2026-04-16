---
layout: default
title: 'INV Cycle count entries and adjustments | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle count entries and adjustments report Source: Cycle count entries and adjustments report (XML) Short Name: INVARCTAXML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Cycle, count, entries, mtl_item_locations_kfv, mtl_cycle_count_items, mtl_abc_classes'
permalink: /INV%20Cycle%20count%20entries%20and%20adjustments/
---

# INV Cycle count entries and adjustments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-cycle-count-entries-and-adjustments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle count entries and adjustments report
Source: Cycle count entries and adjustments report (XML)
Short Name: INVARCTA_XML
DB package: INV_INVARCTA_XMLP_PKG

## Report Parameters
Organization Code, Cycle Count Name, Subinventory, Count Date From, Count Date To, Approved Counts Only

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_cycle_count_items](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_items), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [mtl_cc_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_cc_serial_numbers), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_cycle_count_entries](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_entries), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Cycle count unscheduled items](/INV%20Cycle%20count%20unscheduled%20items/ "INV Cycle count unscheduled items Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Cycle count entries and adjustments - Summarized view 27-Oct-2021 210011.xlsm](https://www.enginatics.com/example/inv-cycle-count-entries-and-adjustments/) |
| Blitz Report™ XML Import | [INV_Cycle_count_entries_and_adjustments.xml](https://www.enginatics.com/xml/inv-cycle-count-entries-and-adjustments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-cycle-count-entries-and-adjustments/](https://www.enginatics.com/reports/inv-cycle-count-entries-and-adjustments/) |

## INV Cycle count entries and adjustments - Case Study & Technical Analysis

### Executive Summary
The **INV Cycle count entries and adjustments** report is a critical audit and control document that details the results of the cycle counting process. It lists the items counted, the system quantity, the actual counted quantity, and most importantly, the **variance** (adjustment) required to reconcile the two. This report is the primary source for analyzing inventory shrinkage or gain and is often required for financial sign-off on inventory adjustments.

### Business Use Cases
*   **Variance Approval**: Managers review this report to approve large adjustments before they are posted to the General Ledger.
*   **Shrinkage Analysis**: Identifies items with consistent negative variances (missing stock), which may indicate theft or process errors.
*   **Accuracy Reporting**: Provides the raw data to calculate inventory record accuracy (IRA).
*   **Audit Trail**: Serves as the permanent record of what was counted, who counted it (if tracked), and what the result was.

### Technical Analysis

#### Core Tables
*   `MTL_CYCLE_COUNT_ENTRIES`: The core transaction table storing the count results (System Qty, Count Qty, Adjustment Qty).
*   `MTL_CYCLE_COUNT_HEADERS`: Defines the cycle count name and parameters.
*   `MTL_SYSTEM_ITEMS_VL`: Item master details.
*   `MTL_ITEM_LOCATIONS_KFV`: Locator details.
*   `MTL_ABC_CLASSES`: ABC classification for the items.

#### Key Joins & Logic
*   **Variance Calculation**: The report calculates `ADJUSTMENT_QUANTITY` = `COUNT_QUANTITY` - `SYSTEM_QUANTITY`.
*   **Value Calculation**: `ADJUSTMENT_VALUE` = `ADJUSTMENT_QUANTITY` * `ITEM_COST`.
*   **Status Filtering**: Can filter by entry status (e.g., 'Pending Approval', 'Completed').
*   **Approvals**: If the adjustment exceeds the approval tolerance defined in the Cycle Count Header, the entry is marked for approval.

#### Key Parameters
*   **Cycle Count Name**: The specific count definition.
*   **Subinventory**: Filter by specific storage area.
*   **Start/End Date**: The period of the count.
*   **Approved Counts Only**: If 'Yes', only shows adjustments that have been finalized.


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
