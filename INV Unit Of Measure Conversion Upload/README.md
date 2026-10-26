---
layout: default
last_modified_at: 2026-10-26
title: 'INV Unit Of Measure Conversion Upload | Oracle EBS SQL Report'
description: 'INV Unit Of Measure Conversion Upload ============================= In R12.2 and later: This upload enables the user to - upload new unit of measure…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Unit, Measure, Conversion, mtl_uom_conversions, mtl_units_of_measure_vl, mtl_uom_classes_vl'
permalink: /INV%20Unit%20Of%20Measure%20Conversion%20Upload/
report_name: 'INV Unit Of Measure Conversion Upload'
report_web_name: inv-unit-of-measure-conversion-upload
---

# INV Unit Of Measure Conversion Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-unit-of-measure-conversion-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload).

## Overview
INV Unit Of Measure Conversion Upload
=============================
In R12.2 and later:
This upload enables the user to 
- upload new unit of measure conversions
- update existing unit of measure conversions. 

The upload supports the following unit of measure conversion types:
- Standard, Intra-Class and Inter-Class, Lot Specific Inter-class

In R12.1:
The functionality is restricted to creating new Item specific Intra-Class and Inter-Class conversions only.
Update of existing unit of measure conversions is not supported in R12.1
Creation of Standard and Lot specific unit of measure conversions is not supported in R12.1

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Conversion Type, From Unit of Measure Class, From Unit of Measure, To Unit of Measure Class, To Unit of Measure, Item, Lot Number

## Oracle EBS Tables Used
[mtl_uom_conversions](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [mtl_uom_classes_vl](https://www.enginatics.com/library/?pg=1&find=mtl_uom_classes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [mtl_uom_class_conversions](https://www.enginatics.com/library/?pg=1&find=mtl_uom_class_conversions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [mtl_lot_uom_class_conversions](https://www.enginatics.com/library/?pg=1&find=mtl_lot_uom_class_conversions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Templates](/INV%20Item%20Templates/ "INV Item Templates Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Unit%20Of%20Measure%20Conversion%20Upload/INV%20Unit%20Of%20Measure%20Conversion%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-unit-of-measure-conversion-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload) |
| Blitz Report™ XML Import | [INV_Unit_Of_Measure_Conversion_Upload.xml](https://www.enginatics.com/xml/inv-unit-of-measure-conversion-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload) |
| SQL Source | [INV Unit Of Measure Conversion Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Unit%20Of%20Measure%20Conversion%20Upload/INV%20Unit%20Of%20Measure%20Conversion%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-unit-of-measure-conversion-upload/](https://www.enginatics.com/reports/inv-unit-of-measure-conversion-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload) |

## INV Unit Of Measure Conversion Upload - Case Study & Technical Analysis

### Executive Summary
The **INV Unit Of Measure Conversion Upload** is a master data management tool. It allows for the bulk creation and update of UOM conversions (e.g., "1 Box = 10 Each"). This is essential for companies with complex packaging hierarchies or those that buy in one UOM and issue in another.

### Business Challenge
Managing UOM conversions is complex and critical.
-   **New Product Introduction:** Launching a new product line often requires defining dozens of conversions (Pallet -> Case -> Box -> Each).
-   **Supplier Changes:** "The supplier changed the box size from 12 to 10. We need to update the conversion for 50 items."
-   **Data Integrity:** If a conversion is missing, the system cannot receive the goods, stopping the warehouse receiving dock.

### Solution
The **INV Unit Of Measure Conversion Upload** streamlines the maintenance of these rules. It supports Standard, Intra-Class, and Inter-Class conversions.

**Key Features:**
-   **Bulk Creation:** Define conversions for hundreds of items at once.
-   **Lot Specific:** (R12.2+) Supports Lot-Specific conversions (e.g., "Lot A has a potency of 90%", "Lot B has a potency of 95%").
-   **Update Capability:** Allows updating existing conversion rates (R12.2+).

### Technical Architecture
The tool interacts with the UOM conversion tables, often using the `INV_UOM_API` or direct interface tables.

#### Key Tables and Views
-   **`MTL_UOM_CONVERSIONS`**: Standard and Inter-Class conversions.
-   **`MTL_UOM_CLASS_CONVERSIONS`**: Intra-Class conversions.
-   **`MTL_LOT_UOM_CLASS_CONVERSIONS`**: Lot-specific conversions.

#### Core Logic
1.  **Upload:** Reads the Item, From UOM, To UOM, and Rate from Excel.
2.  **Validation:** Checks that the UOMs exist and the item is valid.
3.  **Processing:** Calls the API to create or update the conversion record.

### Business Impact
-   **Operational Continuity:** Ensures that receiving and shipping processes are not blocked by missing master data.
-   **Accuracy:** Reduces the risk of "fat finger" errors when defining critical conversion factors (e.g., entering 100 instead of 10).
-   **Efficiency:** Saves hours of manual setup time during product launches.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-conversion-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
