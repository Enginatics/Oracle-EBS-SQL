---
layout: default
last_modified_at: 2026-10-16
title: 'CST Periodic Inventory Value | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Periodic Inventory Value Report Application: Bills of Material Source: Periodic Inventory Value Report (XML) Short…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, R12 only, CST, Periodic, Inventory, Value, mtl_item_categories, mtl_categories_kfv, mtl_system_items_vl'
permalink: /CST%20Periodic%20Inventory%20Value/
report_name: 'CST Periodic Inventory Value'
report_web_name: cst-periodic-inventory-value
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Periodic Inventory Value – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-periodic-inventory-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
Imported from BI Publisher
Description: Periodic Inventory Value Report
Application: Bills of Material
Source: Periodic Inventory Value Report (XML)
Short Name: CSTRPICR_XML
DB package: BOM_CSTRPICR_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Legal Entity, Cost Type, Period, Cost Group, Sort Option, Item From, Item To, Category Set, Category From, Category To, Category Organization, Currency, Exchange Rate

## Oracle EBS Tables Used
[mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [cst_pac_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_pac_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [cst_pac_receiving_values_v](https://www.enginatics.com/library/?pg=1&find=cst_pac_receiving_values_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [mtl_system_items](https://www.enginatics.com/library/?pg=1&find=mtl_system_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [mtl_categories](https://www.enginatics.com/library/?pg=1&find=mtl_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [cst_pac_periods](https://www.enginatics.com/library/?pg=1&find=cst_pac_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Periodic%20Inventory%20Value/CST%20Periodic%20Inventory%20Value.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Periodic Inventory Value - Detail 11-Sep-2024 062243.xlsx](https://www.enginatics.com/example/cst-periodic-inventory-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value) |
| Blitz Report™ XML Import | [CST_Periodic_Inventory_Value.xml](https://www.enginatics.com/xml/cst-periodic-inventory-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value) |
| SQL Source | [CST Periodic Inventory Value.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Periodic%20Inventory%20Value/CST%20Periodic%20Inventory%20Value.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-periodic-inventory-value/](https://www.enginatics.com/reports/cst-periodic-inventory-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value) |

## Executive Summary
The **CST Periodic Inventory Value** report is specifically designed for organizations using **Periodic Average Costing (PAC)**. In PAC, costs are calculated for a specific period (e.g., a month) rather than perpetually. This report provides the inventory valuation based on these periodic costs. It is the PAC equivalent of the standard "Inventory Value Report".

## Business Challenge
*   **PAC Valuation**: Standard inventory reports often use the Perpetual cost (Frozen/Average). PAC users need reports that reflect the specific periodic cost calculated by the PAC engine.
*   **Acquisition Costs**: PAC often includes complex acquisition cost adders (freight, duty) that need to be visualized.
*   **Period-Specific**: The value of an item changes from period to period in PAC; this report captures the value for a specific PAC period.

## Solution
This report lists inventory quantities and values based on the Periodic Average Cost.

**Key Features:**
*   **PAC Period**: Parameters allow selection of the specific Costing Period.
*   **Cost Group**: PAC is often driven by Cost Groups; this report supports that structure.
*   **Receiving Value**: Can also report on the value of goods in Receiving (using `CST_PAC_RECEIVING_VALUES_V`).

## Architecture
The report queries the PAC-specific tables, which are distinct from the perpetual costing tables.

**Key Tables:**
*   `CST_PAC_ITEM_COSTS`: Stores the calculated periodic item costs.
*   `CST_PAC_PERIODS`: Defines the PAC periods.
*   `CST_COST_GROUPS`: Cost groups used in PAC.
*   `CST_PAC_RECEIVING_VALUES_V`: View for receiving value in PAC.

## Impact
*   **Regulatory Compliance**: Essential for companies in jurisdictions that require Periodic Average Costing (e.g., parts of Latin America).
*   **True Costing**: Provides a valuation that smooths out short-term fluctuations and incorporates full acquisition costs.
*   **Financial Accuracy**: Ensures the inventory value reported matches the specific methodology (PAC) used for the ledger.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-periodic-inventory-value)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
