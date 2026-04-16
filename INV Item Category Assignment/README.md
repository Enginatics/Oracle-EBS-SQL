---
layout: default
title: 'INV Item Category Assignment | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Item categories report Application: Inventory Source: Item categories report (XML) Short Name: INVIRCATXML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, INV, Item, Category, Assignment, mtl_categories_kfv, mtl_category_set_valid_cats, mtl_categories_b'
permalink: /INV%20Item%20Category%20Assignment/
---

# INV Item Category Assignment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-category-assignment/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Item categories report
Application: Inventory
Source: Item categories report (XML)
Short Name: INVIRCAT_XML
DB package: INV_INVIRCAT_XMLP_PKG

## Report Parameters
Category Set, Organization Code, Category From, Category To, Item From, Item To, Cat. Set Control Level Violated

## Oracle EBS Tables Used
[mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_category_set_valid_cats](https://www.enginatics.com/library/?pg=1&find=mtl_category_set_valid_cats), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_category_sets_v](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_v), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [MRP Sourcing Rules and Bills of Distribution](/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/ "MRP Sourcing Rules and Bills of Distribution Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-item-category-assignment/) |
| Blitz Report™ XML Import | [INV_Item_Category_Assignment.xml](https://www.enginatics.com/xml/inv-item-category-assignment/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-category-assignment/](https://www.enginatics.com/reports/inv-item-category-assignment/) |

## INV Item Category Assignment - Case Study & Technical Analysis

### Executive Summary
The **INV Item Category Assignment** report provides a detailed listing of which items are assigned to which categories within a specific Category Set. Since an item can belong to multiple category sets (e.g., one for Sales, one for Purchasing, one for Planning), this report allows users to view the specific assignments for a targeted purpose.

### Business Use Cases
*   **Catalog Management**: Used to review and clean up item classifications (e.g., "Show me all items in the 'Electronics' category").
*   **New Item Setup Verification**: Ensures that new items have been assigned to the correct categories, which often drives account derivation and reporting.
*   **Sourcing Analysis**: Procurement teams use this to group items by purchasing category to analyze spend.

### Technical Analysis

#### Core Tables
*   `MTL_ITEM_CATEGORIES`: The intersection table linking Items to Categories.
*   `MTL_CATEGORIES_B`: The category definitions.
*   `MTL_CATEGORY_SETS_B`: The category set definitions.
*   `MTL_SYSTEM_ITEMS_B`: The item master.

#### Key Joins & Logic
*   **Category Set Context**: The query MUST filter by `CATEGORY_SET_ID`. Without this, the results would be a meaningless mix of different classification schemes.
*   **Organization Context**: Category assignments can be Master Level (same for all orgs) or Org Level (specific to an org). The report respects this control level.

#### Key Parameters
*   **Category Set**: The specific classification scheme to report on (Mandatory).
*   **Category From/To**: Range of categories to include.
*   **Item From/To**: Range of items.


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
