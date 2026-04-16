---
layout: default
title: 'GMI Cycle Count Forms | Oracle EBS SQL Report'
description: 'Imported Oracle standard Cycle Count Forms Report of Oracle OPM PI report Source: Cycle Count Forms (XML) Short Name: PIR05XML DB package: GMIPIR05XMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, GMI, Cycle, Count, Forms, ic_whse_mst, ic_phys_cnt, ic_cycl_hdr'
permalink: /GMI%20Cycle%20Count%20Forms/
---

# GMI Cycle Count Forms – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gmi-cycle-count-forms/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard Cycle Count Forms Report of Oracle OPM PI report
Source: Cycle Count Forms (XML)
Short Name: PIR05_XML
DB package: GMI_PIR05_XMLP_PKG

## Report Parameters
Warehouse Code, Cycle, From Count, To Count, Sort By

## Oracle EBS Tables Used
[ic_whse_mst](https://www.enginatics.com/library/?pg=1&find=ic_whse_mst), [ic_phys_cnt](https://www.enginatics.com/library/?pg=1&find=ic_phys_cnt), [ic_cycl_hdr](https://www.enginatics.com/library/?pg=1&find=ic_cycl_hdr), [ic_item_mst_vl](https://www.enginatics.com/library/?pg=1&find=ic_item_mst_vl), [ic_lots_mst](https://www.enginatics.com/library/?pg=1&find=ic_lots_mst)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GMI Cycle Count Forms 25-Dec-2021 171514.xlsx](https://www.enginatics.com/example/gmi-cycle-count-forms/) |
| Blitz Report™ XML Import | [GMI_Cycle_Count_Forms.xml](https://www.enginatics.com/xml/gmi-cycle-count-forms/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gmi-cycle-count-forms/](https://www.enginatics.com/reports/gmi-cycle-count-forms/) |

## GMI Cycle Count Forms - Case Study & Technical Analysis

### Executive Summary
The **GMI Cycle Count Forms** report is a specialized inventory document used in Oracle Process Manufacturing (OPM). It generates the physical count sheets (forms) that warehouse personnel use to record the actual on-hand quantities of items during a cycle count. This report is the operational "instruction sheet" for the counting process, ensuring that the correct items and lots are counted in the correct locations.

### Business Use Cases
*   **Physical Inventory Execution**: Provides the paper or digital document used by warehouse staff to perform the count.
*   **Blind Counting**: Can be configured to hide the system on-hand quantity ("Blind Count"), forcing the counter to record what they actually see rather than verifying what the system says.
*   **Lot Control Verification**: Specifically designed for OPM environments where lot control and expiration dates are critical; the form includes fields to verify lot numbers.
*   **Audit Compliance**: The signed count sheets serve as physical evidence of the inventory verification process for auditors.

### Technical Analysis

#### Core Tables
*   `IC_WHSE_MST`: Stores warehouse definitions.
*   `IC_PHYS_CNT`: The physical inventory count header/detail.
*   `IC_CYCL_HDR`: The cycle count header definition.
*   `IC_ITEM_MST_VL`: Item master table (OPM specific).
*   `IC_LOTS_MST`: Lot master table (OPM specific).

#### Key Joins & Logic
*   **OPM Data Model**: Unlike discrete inventory (which uses `MTL_%` tables), this report uses the legacy OPM tables (`IC_%`) or their converged R12 equivalents.
*   **Count Generation**: The report logic selects items that have been scheduled for counting in the `IC_CYCL_HDR` batch.
*   **Sorting**: Organizes the output by Warehouse, Location, and Item to create an efficient "walking path" for the counter.

#### Key Parameters
*   **Warehouse Code**: The specific facility to count.
*   **Cycle**: The specific cycle count batch ID.
*   **From/To Count**: Range of count IDs to print.


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
