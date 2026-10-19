---
layout: default
last_modified_at: 2026-10-19
title: 'INV Aging | Oracle EBS SQL Report'
description: 'The Inventory Aging Report indicates how long an inventory item has been in a FIFO warehouse. You can define bucket days to identify the period from when…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, R12 only, INV, Aging, ar_aging_buckets, ar_aging_bucket_lines_b, ar_aging_bucket_lines_tl'
permalink: /INV%20Aging/
report_name: 'INV Aging'
report_web_name: inv-aging
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Aging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
The Inventory Aging Report indicates how long an inventory item has been in a FIFO warehouse. You can define bucket days to identify the period from when an item is in the inventory.
NOTES: 
This report will only run for clients running R12.2.8 or later.
This report requires the profile 'INV: FIFO for Original Receipt Date' to be set to Yes in order to return data.

For customers encountering an error running this Blitz report, please first verify the Oracle standard report Inventory Aging Report(XML) can be run in the same instance.
If the standard Oracle report does not complete successfully, or returns no data, then you will need apply a patch in order to use this report.

Please refer to the following My Oracle Support documents for the related patches:
Does the Inventory Aging Report Work for Process Manufacturing (OPM) Organizations? (Doc ID 2914438.1) refers to one off Patch 28858086:R12.INV.C in order to use the Inventory Aging Report.
Inventory Aging Report (XML) Does Not Show Correct Quantity In The Age Buckets For Few Items (Doc ID 2880403.1) refers to Patch 33663520:R12.INV.C for the latest bug fixes for the Inventory Aging Report.

Imported from BI Publisher
Application: Inventory
Source: Inventory Aging Report(XML)
Short Name: INVAGERP_XML
DB package: INV_AGERPXML_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Category Set, Category From, Category To, Item From, Item To, Level, Cost Group From, Cost Group To, Order By, Buckets Days, Include Expense Items, Include Expense Subinventories

## Oracle EBS Tables Used
[ar_aging_buckets](https://www.enginatics.com/library/?pg=1&find=ar_aging_buckets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [ar_aging_bucket_lines_b](https://www.enginatics.com/library/?pg=1&find=ar_aging_bucket_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [ar_aging_bucket_lines_tl](https://www.enginatics.com/library/?pg=1&find=ar_aging_bucket_lines_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [mtl_secondary_inventories_fk_v](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories_fk_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [mtl_item_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PO Approved Supplier List Upload](/PO%20Approved%20Supplier%20List%20Upload/ "PO Approved Supplier List Upload Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Aging/INV%20Aging.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Aging - Default Pivot 20-Aug-2024 085922.xlsx](https://www.enginatics.com/example/inv-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging) |
| Blitz Report™ XML Import | [INV_Aging.xml](https://www.enginatics.com/xml/inv-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging) |
| SQL Source | [INV Aging.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Aging/INV%20Aging.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-aging/](https://www.enginatics.com/reports/inv-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging) |

## INV Aging - Case Study & Technical Analysis

### Executive Summary
The **INV Aging** report provides a detailed analysis of inventory age, categorizing on-hand stock into time buckets (e.g., 0-30 days, 31-60 days, 180+ days). This is a critical tool for identifying slow-moving and obsolete inventory (SLOB), calculating inventory reserves, and managing working capital. It helps organizations understand not just *how much* stock they have, but *how old* it is.

### Business Use Cases
*   **Obsolescence Provisioning**: Finance teams use this report to calculate the "Inventory Reserve" or "Write-down" required for old stock (e.g., "Reserve 50% for items older than 1 year").
*   **Warehouse Space Management**: Identifies old stock taking up valuable warehouse space, triggering disposal or discount sales.
*   **Working Capital Optimization**: Highlights capital tied up in non-performing assets.
*   **FIFO/LIFO Analysis**: Helps validate that the First-In-First-Out (FIFO) flow is actually happening physically.

### Technical Analysis

#### Core Tables
*   `MTL_ONHAND_QUANTITIES_DETAIL`: The primary source of current on-hand stock.
*   `MTL_MATERIAL_TRANSACTIONS`: Used to trace the receipt date of the items (especially for FIFO logic).
*   `CST_COST_GROUPS`: Used for costing context.
*   `AR_AGING_BUCKETS`: Reuses the AR aging bucket definitions to define the time ranges.

#### Key Joins & Logic
*   **FIFO Logic**: The most complex part of this report is determining the "age" of commingled stock. Since Oracle Inventory (without WMS/LPNs) doesn't always track the specific receipt date of a specific unit, the report often uses a **FIFO algorithm**: it looks at the current on-hand quantity and "walks back" through the receipt history (`MTL_MATERIAL_TRANSACTIONS`) to attribute the stock to the most recent receipts.
*   **Bucket Allocation**: Once the age is determined, the quantity and value are allocated to the appropriate bucket (e.g., 0-30, 31-60).
*   **Valuation**: Multiplies the quantity by the current item cost (from `CST_ITEM_COSTS` or `CST_QUANTITY_LAYERS`).

#### Key Parameters
*   **Buckets Days**: Defines the aging intervals.
*   **Cost Group**: Filter for specific cost groups (Project Manufacturing).
*   **Category Set**: Filter by item category (e.g., "Finished Goods").

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-aging)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
