---
layout: default
title: 'INV Item Category Sets | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Category, Sets, mtl_categories_b_kfv, mtl_category_set_valid_cats, mtl_categories_b'
permalink: /INV%20Item%20Category%20Sets/
---

# INV Item Category Sets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-category-sets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters


## Oracle EBS Tables Used
[mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [mtl_category_set_valid_cats](https://www.enginatics.com/library/?pg=1&find=mtl_category_set_valid_cats), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_category_sets_v](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Item Category Assignment](/INV%20Item%20Category%20Assignment/ "INV Item Category Assignment Oracle EBS SQL Report"), [MRP Sourcing Rules and Bills of Distribution](/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/ "MRP Sourcing Rules and Bills of Distribution Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Category Sets 18-Jan-2018 222818.xlsx](https://www.enginatics.com/example/inv-item-category-sets/) |
| Blitz Report™ XML Import | [INV_Item_Category_Sets.xml](https://www.enginatics.com/xml/inv-item-category-sets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-category-sets/](https://www.enginatics.com/reports/inv-item-category-sets/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
