---
layout: default
last_modified_at: 2026-10-16
title: 'INV Unit Of Measure Upload | Oracle EBS SQL Report'
description: 'INV Unit Of Measure Upload ====================== Note: This upload can only be used in R12.2 or later. This upload can be used to create and update Unit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Unit, Measure, mtl_uom_classes_vl, mtl_units_of_measure_vl'
permalink: /INV%20Unit%20Of%20Measure%20Upload/
report_name: 'INV Unit Of Measure Upload'
report_web_name: inv-unit-of-measure-upload
---

# INV Unit Of Measure Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-unit-of-measure-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload).

## Overview
INV Unit Of Measure Upload
======================
Note: This upload can only be used in R12.2 or later.

This upload can be used to create and update Unit of Measure Classes and Units of Measures

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Unit of Measure Class

## Oracle EBS Tables Used
[mtl_uom_classes_vl](https://www.enginatics.com/library/?pg=1&find=mtl_uom_classes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)

## Related Reports
[CAC WIP Account Value](/CAC%20WIP%20Account%20Value/ "CAC WIP Account Value Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status But Not Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status But Not Ready for Close Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Unit%20Of%20Measure%20Upload/INV%20Unit%20Of%20Measure%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-unit-of-measure-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload) |
| Blitz Report™ XML Import | [INV_Unit_Of_Measure_Upload.xml](https://www.enginatics.com/xml/inv-unit-of-measure-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload) |
| SQL Source | [INV Unit Of Measure Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Unit%20Of%20Measure%20Upload/INV%20Unit%20Of%20Measure%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-unit-of-measure-upload/](https://www.enginatics.com/reports/inv-unit-of-measure-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-unit-of-measure-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
