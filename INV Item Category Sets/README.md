---
layout: default
last_modified_at: 2026-10-19
title: 'INV Item Category Sets | Oracle EBS SQL Report'
description: 'Oracle EBS Inventory SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Item, Category, Sets, mtl_categories_b_kfv, mtl_category_set_valid_cats, mtl_categories_b'
permalink: /INV%20Item%20Category%20Sets/
report_name: 'INV Item Category Sets'
report_web_name: inv-item-category-sets
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Item Category Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-category-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets), [mtl_category_set_valid_cats](https://www.enginatics.com/library/?pg=1&find=mtl_category_set_valid_cats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets), [mtl_category_sets_v](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)

## Related Reports
[INV Item Category Assignment](/INV%20Item%20Category%20Assignment/ "INV Item Category Assignment Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [MRP Sourcing Rules and Bills of Distribution](/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/ "MRP Sourcing Rules and Bills of Distribution Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [OPM Recipe Details](/OPM%20Recipe%20Details/ "OPM Recipe Details Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Category%20Sets/INV%20Item%20Category%20Sets.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Category Sets 18-Jan-2018 222818.xlsx](https://www.enginatics.com/example/inv-item-category-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets) |
| Blitz Report™ XML Import | [INV_Item_Category_Sets.xml](https://www.enginatics.com/xml/inv-item-category-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets) |
| SQL Source | [INV Item Category Sets.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Category%20Sets/INV%20Item%20Category%20Sets.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-category-sets/](https://www.enginatics.com/reports/inv-item-category-sets/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets) |

## INV Item Category Sets - Case Study & Technical Analysis

### Executive Summary
The **INV Item Category Sets** report is a configuration reference document that details the structure of the Category Sets defined in the system. It lists the Category Sets (e.g., "Inventory", "Purchasing", "Cost Class") and the specific Categories that are valid for use within each set. This is essential for understanding the classification hierarchy available to users.

### Business Use Cases
*   **Master Data Governance**: Used to audit the allowed categories within a set (e.g., ensuring "Office Supplies" is not a valid category in the "Raw Materials" set).
*   **System Configuration**: Documents the setup of the Flexfield structures used for categorization.
*   **Integration Planning**: When integrating with external systems, this report provides the valid list of category values that can be mapped.

### Technical Analysis

#### Core Tables
*   `MTL_CATEGORY_SETS_V`: The header definition of the category set.
*   `MTL_CATEGORY_SET_VALID_CATS`: The intersection table defining which categories are allowed in the set (if "Validate Flag" is on).
*   `MTL_CATEGORIES_B`: The category definitions themselves.

#### Key Joins & Logic
*   **Validation Logic**: If `VALIDATE_FLAG` is 'Y' in the category set definition, users can only assign categories listed in `MTL_CATEGORY_SET_VALID_CATS`. If 'N', they can assign any category defined in the underlying Flexfield structure.
*   **Structure ID**: Links the category set to the specific Key Flexfield structure (e.g., "Item Categories", "PO Categories").

#### Key Parameters
*   *(None)*: Typically lists all category sets.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-category-sets)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
