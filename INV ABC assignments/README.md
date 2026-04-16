---
layout: default
title: 'INV ABC assignments | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: ABC assignments report Application: Inventory Source: ABC assignments report (XML) Short Name: INVARAASXML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, R12 only, INV, ABC, assignments, org_organization_definitions, hr_operating_units, gl_sets_of_books'
permalink: /INV%20ABC%20assignments/
---

# INV ABC assignments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-abc-assignments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: ABC assignments report
Application: Inventory
Source: ABC assignments report (XML)
Short Name: INVARAAS_XML
DB package: INV_INVARAAS_XMLP_PKG

## Report Parameters
Operating Unit, Organization Code, ABC Group, Sort Option

## Oracle EBS Tables Used
[org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [mtl_abc_assignment_groups](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignment_groups), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [mtl_item_flexfields](https://www.enginatics.com/library/?pg=1&find=mtl_item_flexfields), [mtl_abc_assignments](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignments), [mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [mtl_abc_compiles](https://www.enginatics.com/library/?pg=1&find=mtl_abc_compiles), [org_group](https://www.enginatics.com/library/?pg=1&find=org_group)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Cycle count open requests listing](/INV%20Cycle%20count%20open%20requests%20listing/ "INV Cycle count open requests listing Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Cycle count unscheduled items](/INV%20Cycle%20count%20unscheduled%20items/ "INV Cycle count unscheduled items Oracle EBS SQL Report"), [INV Cycle count hit/miss analysis](/INV%20Cycle%20count%20hit-miss%20analysis/ "INV Cycle count hit/miss analysis Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV ABC assignments 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/inv-abc-assignments/) |
| Blitz Report™ XML Import | [INV_ABC_assignments.xml](https://www.enginatics.com/xml/inv-abc-assignments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-abc-assignments/](https://www.enginatics.com/reports/inv-abc-assignments/) |

## INV ABC assignments - Case Study & Technical Analysis

### Executive Summary
The **INV ABC assignments** report documents the classification of inventory items into ABC classes (A, B, C) based on their value, usage, or frequency. ABC analysis is a standard supply chain technique where 'A' items are high-value/high-priority, and 'C' items are low-value. This report shows which class each item has been assigned to, which drives cycle counting frequencies and inventory control policies.

### Business Use Cases
*   **Cycle Count Planning**: Verifies that high-value ('A') items are assigned to frequent count schedules (e.g., monthly) while low-value ('C') items are counted less often (e.g., annually).
*   **Inventory Policy Review**: Helps managers analyze if the current ABC thresholds are appropriate (e.g., "Are too many items falling into Class A?").
*   **Stocking Strategy**: 'A' items might be stocked in more secure or accessible locations; this report helps validate those location assignments.
*   **Obsolete Inventory Identification**: Items that have moved from 'A' to 'C' (or 'D') over time may be candidates for obsolescence review.

### Technical Analysis

#### Core Tables
*   `MTL_ABC_ASSIGNMENTS`: The table linking an item to an ABC class within an assignment group.
*   `MTL_ABC_CLASSES`: Defines the classes (A, B, C, etc.).
*   `MTL_ABC_ASSIGNMENT_GROUPS`: Defines the group (e.g., "Cycle Count Group", "Planning Group").
*   `MTL_ABC_COMPILES`: Stores the compilation header that calculated the ABC values.

#### Key Joins & Logic
*   **Assignment Logic**: The query joins `MTL_ABC_ASSIGNMENTS` to `MTL_SYSTEM_ITEMS` (via `INVENTORY_ITEM_ID`) and `MTL_ABC_CLASSES` (via `ABC_CLASS_ID`).
*   **Group Context**: Assignments are always within the context of an `ASSIGNMENT_GROUP_ID`. An item can be Class 'A' for Cycle Counting but Class 'B' for Planning.
*   **Scope**: Filters by Organization, as ABC analysis is organization-specific.

#### Key Parameters
*   **ABC Group**: The specific assignment group to report on.
*   **Sort Option**: Sort by Item, Class, or Value.


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
