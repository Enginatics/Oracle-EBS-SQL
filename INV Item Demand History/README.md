---
layout: default
title: 'INV Item Demand History | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Item demand history report Application: Inventory Source: Item demand history report (XML) Short Name: INVPRFDHXML…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Demand, History, mfg_lookups, org_organization_definitions, gl_sets_of_books'
permalink: /INV%20Item%20Demand%20History/
---

# INV Item Demand History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-demand-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Item demand history report
Application: Inventory
Source: Item demand history report (XML)
Short Name: INVPRFDH_XML
DB package: INV_INVPRFDH_XMLP_PKG

## Report Parameters
Organization Code, Category Set, Categories From, Categories To, Items From, Items To, Bucket Type, History Start Date

## Oracle EBS Tables Used
[mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [mtl_system_items_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_kfv), [mtl_demand_histories](https://www.enginatics.com/library/?pg=1&find=mtl_demand_histories), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CST Supply Chain Indented Bills of Material Cost](/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/ "CST Supply Chain Indented Bills of Material Cost Oracle EBS SQL Report"), [CST Item Cost Reports](/CST%20Item%20Cost%20Reports/ "CST Item Cost Reports Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Demand History - Default Pivot 03-Jun-2023 213208.xlsx](https://www.enginatics.com/example/inv-item-demand-history/) |
| Blitz Report™ XML Import | [INV_Item_Demand_History.xml](https://www.enginatics.com/xml/inv-item-demand-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-demand-history/](https://www.enginatics.com/reports/inv-item-demand-history/) |

## INV Item Demand History - Case Study & Technical Analysis

### Executive Summary
The **INV Item Demand History** report provides a historical view of item usage (demand) over time. It aggregates transaction data to show how much of an item was issued or sold in specific time buckets. This data is the foundation for **Inventory Forecasting** and **Min-Max Planning**.

### Business Use Cases
*   **Forecasting**: Planners use this history to predict future demand (e.g., "We used 100 units last December, so we should stock up for this December").
*   **Min-Max Calculation**: The "Calculate Min-Max Planning" program uses this history to suggest new minimum and maximum stock levels.
*   **Slow Mover Analysis**: Identifies items with zero demand over the last 12 months.

### Technical Analysis

#### Core Tables
*   `MTL_DEMAND_HISTORIES`: The summary table populated by the "Compile Demand History" concurrent program.
*   `MTL_SYSTEM_ITEMS_KFV`: Item details.

#### Key Joins & Logic
*   **Compilation**: This report relies on the `MTL_DEMAND_HISTORIES` table being up-to-date. This table is NOT real-time; it is populated by a background process that summarizes `MTL_MATERIAL_TRANSACTIONS`.
*   **Bucketing**: Demand is aggregated into buckets (Day, Week, Month) based on the compilation settings.
*   **Transaction Types**: Only specific transaction types (e.g., Sales Order Issue, WIP Issue) are typically considered "Demand".

#### Key Parameters
*   **Bucket Type**: Daily, Weekly, or Monthly.
*   **History Start Date**: The lookback period.


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
