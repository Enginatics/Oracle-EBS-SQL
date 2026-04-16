---
layout: default
title: 'CST Periodic Inventory Value | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Periodic Inventory Value Report Application: Bills of Material Source: Periodic Inventory Value Report (XML) Short…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CST, Periodic, Inventory, Value, mtl_item_categories, mtl_categories_kfv, mtl_system_items_vl'
permalink: /CST%20Periodic%20Inventory%20Value/
---

# CST Periodic Inventory Value – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-periodic-inventory-value/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Periodic Inventory Value Report
Application: Bills of Material
Source: Periodic Inventory Value Report (XML)
Short Name: CSTRPICR_XML
DB package: BOM_CSTRPICR_XMLP_PKG

## Report Parameters
Legal Entity, Cost Type, Period, Cost Group, Sort Option, Item From, Item To, Category Set, Category From, Category To, Category Organization, Currency, Exchange Rate

## Oracle EBS Tables Used
[mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [cst_pac_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_pac_item_costs), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [cst_pac_receiving_values_v](https://www.enginatics.com/library/?pg=1&find=cst_pac_receiving_values_v), [mtl_system_items](https://www.enginatics.com/library/?pg=1&find=mtl_system_items), [mtl_categories](https://www.enginatics.com/library/?pg=1&find=mtl_categories), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations), [po_lookup_codes](https://www.enginatics.com/library/?pg=1&find=po_lookup_codes), [cst_pac_periods](https://www.enginatics.com/library/?pg=1&find=cst_pac_periods), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [q_ic_main](https://www.enginatics.com/library/?pg=1&find=q_ic_main), [q_ic_rcv](https://www.enginatics.com/library/?pg=1&find=q_ic_rcv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Periodic Inventory Value - Detail 11-Sep-2024 062243.xlsx](https://www.enginatics.com/example/cst-periodic-inventory-value/) |
| Blitz Report™ XML Import | [CST_Periodic_Inventory_Value.xml](https://www.enginatics.com/xml/cst-periodic-inventory-value/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-periodic-inventory-value/](https://www.enginatics.com/reports/cst-periodic-inventory-value/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
