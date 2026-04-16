---
layout: default
title: 'INV Default Category Sets | Oracle EBS SQL Report'
description: 'Master data report that lists Inventory functional areas and their default category sets'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Default, Category, Sets, mtl_default_category_sets, mtl_category_sets_v'
permalink: /INV%20Default%20Category%20Sets/
---

# INV Default Category Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-default-category-sets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report that lists Inventory functional areas and their default category sets

## Report Parameters


## Oracle EBS Tables Used
[mtl_default_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_default_category_sets), [mtl_category_sets_v](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Default Category Sets 03-Apr-2018 110157.xlsx](https://www.enginatics.com/example/inv-default-category-sets/) |
| Blitz Report™ XML Import | [INV_Default_Category_Sets.xml](https://www.enginatics.com/xml/inv-default-category-sets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-default-category-sets/](https://www.enginatics.com/reports/inv-default-category-sets/) |

## INV Default Category Sets - Case Study & Technical Analysis

### Executive Summary
The **INV Default Category Sets** report is a configuration audit document. In Oracle EBS, different functional areas (Inventory, Purchasing, Costing, Order Management, etc.) can use different "Category Sets" to classify items. This report lists which Category Set is the "Default" for each functional area. It is essential for understanding how items are grouped for reporting and processing across the suite.

### Business Use Cases
*   **Implementation Audit**: Verifies that the system is configured correctly (e.g., "Is the 'Purchasing' functional area using the 'Purchasing Categories' set?").
*   **Reporting Context**: Helps analysts understand why an item might have a category of "Hardware" in an Inventory report but "IT Equipment" in a Purchasing report (different category sets).
*   **Master Data Governance**: Ensures consistency in how items are classified across the enterprise.

### Technical Analysis

#### Core Tables
*   `MTL_DEFAULT_CATEGORY_SETS`: The mapping table between functional areas and category sets.
*   `MTL_CATEGORY_SETS_V`: Details of the category sets.
*   `FND_LOOKUP_VALUES`: Used to decode the `FUNCTIONAL_AREA_ID` (e.g., 1=Inventory, 2=Purchasing).

#### Key Joins & Logic
*   **Functional Area Mapping**: Joins the internal ID of the functional area to its readable name.
*   **Structure Definition**: Shows the Flexfield Structure associated with the category set.

#### Key Parameters
*   *(None)*: Typically runs for the entire installation or filtered by organization if applicable (though default category sets are usually site/installation level).


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
