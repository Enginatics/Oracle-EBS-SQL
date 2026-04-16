---
layout: default
title: 'INV Unit Of Measure Upload | Oracle EBS SQL Report'
description: 'INV Unit Of Measure Upload ====================== Note: This upload can only be used in R12.2 or later. This upload can be used to create and update Unit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Unit, Measure, mtl_units_of_measure_vl, mtl_uom_classes_vl, uom_qry'
permalink: /INV%20Unit%20Of%20Measure%20Upload/
---

# INV Unit Of Measure Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-unit-of-measure-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
INV Unit Of Measure Upload
======================
Note: This upload can only be used in R12.2 or later.

This upload can be used to create and update Unit of Measure Classes and Units of Measures

## Report Parameters
Upload Mode, Unit of Measure Class

## Oracle EBS Tables Used
[mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_uom_classes_vl](https://www.enginatics.com/library/?pg=1&find=mtl_uom_classes_vl), [uom_qry](https://www.enginatics.com/library/?pg=1&find=uom_qry)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[INV Unit Of Measure Conversion Upload](/INV%20Unit%20Of%20Measure%20Conversion%20Upload/ "INV Unit Of Measure Conversion Upload Oracle EBS SQL Report"), [CAC WIP Account Value](/CAC%20WIP%20Account%20Value/ "CAC WIP Account Value Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-unit-of-measure-upload/) |
| Blitz Report™ XML Import | [INV_Unit_Of_Measure_Upload.xml](https://www.enginatics.com/xml/inv-unit-of-measure-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-unit-of-measure-upload/](https://www.enginatics.com/reports/inv-unit-of-measure-upload/) |

## INV Unit Of Measure Upload - Case Study & Technical Analysis

### Executive Summary
The **INV Unit Of Measure Upload** is a foundational setup tool. It allows for the creation and maintenance of the UOM Classes (e.g., "Weight", "Count", "Volume") and the individual Units of Measure (e.g., "Kg", "Lb", "Each", "Dozen"). This is typically used during the initial system implementation or when expanding into new markets.

### Business Challenge
Defining UOMs is the bedrock of the inventory system.
-   **Standardization:** "We need to ensure that 'Kilogram' is defined as 'KG' across all our global instances."
-   **Compliance:** "We are expanding to the US and need to add imperial units (Lbs, Oz) to our metric system."
-   **Volume:** Manually defining 50 different units of measure and their classes is tedious.

### Solution
The **INV Unit Of Measure Upload** allows for the bulk definition of these codes. It ensures consistency and completeness.

**Key Features:**
-   **Class Definition:** Create UOM Classes (e.g., Quantity, Weight, Time).
-   **Unit Definition:** Create specific UOMs (e.g., Ea, Doz, Gross).
-   **Standard Conversions:** Define the base unit for the class (e.g., "Each" is the base for Quantity).

### Technical Architecture
The tool populates the core UOM definition tables.

#### Key Tables and Views
-   **`MTL_UNITS_OF_MEASURE_VL`**: The table storing individual UOM definitions.
-   **`MTL_UOM_CLASSES_VL`**: The table storing UOM Class definitions.

#### Core Logic
1.  **Upload:** Reads the Class and Unit definitions from Excel.
2.  **Validation:** Checks for duplicate codes or names.
3.  **Creation:** Inserts records into the UOM tables.

### Business Impact
-   **Global Consistency:** Ensures that all business units speak the same "language" regarding quantities.
-   **Implementation Speed:** Accelerates the initial setup of the inventory module.
-   **Data Quality:** Prevents the creation of duplicate or ambiguous units (e.g., "ea" vs "EA").


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
