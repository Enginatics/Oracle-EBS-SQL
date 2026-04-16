---
layout: default
title: 'INV Physical inventory accuracy analysis | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Physical inventory accuracy analysis Application: Inventory Source: Physical inventory accuracy analysis (XML)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Physical, inventory, accuracy, mtl_physical_inventories, mtl_phy_adj_cost_v, org_organization_definitions'
permalink: /INV%20Physical%20inventory%20accuracy%20analysis/
---

# INV Physical inventory accuracy analysis – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-accuracy-analysis/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Physical inventory accuracy analysis
Application: Inventory
Source: Physical inventory accuracy analysis (XML)
Short Name: INVARPIA_XML
DB package: INV_INVARPIA_XMLP_PKG

## Report Parameters
Organization Code, Physical Inventory, Category Set 1, Category Set 2, Category Set 3, Exclude Rejected Items

## Oracle EBS Tables Used
[mtl_physical_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories), [mtl_phy_adj_cost_v](https://www.enginatics.com/library/?pg=1&find=mtl_phy_adj_cost_v), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Physical inventory accuracy analysis 31-May-2025 003750.xlsx](https://www.enginatics.com/example/inv-physical-inventory-accuracy-analysis/) |
| Blitz Report™ XML Import | [INV_Physical_inventory_accuracy_analysis.xml](https://www.enginatics.com/xml/inv-physical-inventory-accuracy-analysis/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-accuracy-analysis/](https://www.enginatics.com/reports/inv-physical-inventory-accuracy-analysis/) |

## INV Physical inventory accuracy analysis - Case Study & Technical Analysis

### Executive Summary
The **INV Physical inventory accuracy analysis** report is a key performance indicator (KPI) tool for warehouse management. It measures the effectiveness of the physical inventory process by comparing the system's "Book Quantity" against the actual "Count Quantity." It calculates accuracy percentages to help management understand how reliable their inventory data is.

### Business Challenge
Inventory accuracy is critical for supply chain planning. If the system says you have 100 units but you only have 80, you will promise orders you can't fulfill. Conversely, if you have 120 but the system says 100, you are carrying excess stock.
-   **Trust:** "Can we trust the system numbers, or do we need to double-check every time?"
-   **Root Cause Analysis:** "Are we consistently losing stock in a specific subinventory or for a specific item category?"
-   **Audit Compliance:** Auditors require proof that the variance between book and physical inventory is within acceptable limits.

### Solution
The **INV Physical inventory accuracy analysis** report provides a statistical breakdown of the count results. It highlights the absolute and relative variance for items and categories.

**Key Features:**
-   **Variance Calculation:** Shows the difference between system quantity and counted quantity.
-   **Value Impact:** Calculates the financial impact of the variance (Variance Quantity * Item Cost).
-   **Accuracy Metrics:** Provides an overall accuracy percentage for the organization or category.

### Technical Architecture
The report analyzes the results stored in the physical inventory tables after the count is completed but before (or after) adjustments are posted.

#### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORIES`**: The header definition of the physical inventory event.
-   **`MTL_PHY_ADJ_COST_V`**: A view that calculates the cost of adjustments.
-   **`MTL_SYSTEM_ITEMS_VL`**: Item definitions.

#### Core Logic
1.  **Data Retrieval:** Fetches count records linked to the specified Physical Inventory ID.
2.  **Comparison:** Compares `SYSTEM_QUANTITY` vs. `COUNT_QUANTITY`.
3.  **Costing:** Multiplies the variance by the item's current cost to determine financial impact.

### Business Impact
-   **Process Improvement:** Identifies areas (e.g., specific aisles or product lines) with poor accuracy, targeting them for process review.
-   **Financial Integrity:** Provides the backup documentation for the inventory write-off or write-on entries in the General Ledger.
-   **Planning Reliability:** Improves the quality of MRP/ASCP plans by ensuring the starting inventory position is accurate.


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
