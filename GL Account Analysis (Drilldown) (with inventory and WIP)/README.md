---
layout: default
title: 'GL Account Analysis (Drilldown) (with inventory and WIP) | Oracle EBS SQL Report'
description: 'This report is used by the GL Financial Statement and Drilldown report, to show Subledger details. Detail GL transaction report with one line per…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Account, Analysis, (Drilldown), (with, gl_code_combinations_kfv, xla_event_types_tl, gl_daily_conversion_types'
permalink: /GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/
---

# GL Account Analysis (Drilldown) (with inventory and WIP) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-analysis-drilldown-with-inventory-and-wip/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
** This report is used by the GL Financial Statement and Drilldown report, to show Subledger details. **

Detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency. This also has inventory and WIP details.

## Report Parameters
Ledger, Ledger ID, Period, Journal Source, Journal Category, Batch, Status, Batch ID, Journal, Journal Header ID, Journal Line Num, Concatenated Segments, Balance Type, Budget Name, Encumbrance Type, Show Segments with Descriptions, Restrict CCIDs through GTT, Restrict JHI through GTT, Show Journal Line DFF Attributes

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [xla_event_types_tl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_tl), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [fnd_document_sequences](https://www.enginatics.com/library/?pg=1&find=fnd_document_sequences), [gl_je_lines_recon](https://www.enginatics.com/library/?pg=1&find=gl_je_lines_recon), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl), [hr_all_positions_f_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_positions_f_tl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-account-analysis-drilldown-with-inventory-and-wip/) |
| Blitz Report™ XML Import | [GL_Account_Analysis_Drilldown_with_inventory_and_WIP.xml](https://www.enginatics.com/xml/gl-account-analysis-drilldown-with-inventory-and-wip/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-account-analysis-drilldown-with-inventory-and-wip/](https://www.enginatics.com/reports/gl-account-analysis-drilldown-with-inventory-and-wip/) |

## GL Account Analysis (Drilldown) (with inventory and WIP) - Case Study & Technical Analysis

### Executive Summary

The **GL Account Analysis (Drilldown) (with inventory and WIP)** report is an advanced extension of the standard drilldown capability, specifically enhanced for manufacturing and supply chain intensive organizations. In addition to the standard financial drilldown features, this report provides deep visibility into **Inventory** and **Work in Process (WIP)** transactions.

It is designed to support complex cost accounting analysis by linking General Ledger balances not just to subledger accounting entries, but all the way down to specific material transactions, job operations, and sales orders. This level of detail is essential for reconciling inventory value, analyzing manufacturing variances, and auditing cost of goods sold.

### Business Challenge

For manufacturing companies, the link between the General Ledger and the shop floor is often opaque. Standard reports may show a "Material Overhead" or "WIP Variance" entry in the GL, but determining *which* specific job or material movement caused it can be difficult. Common pain points include:

*   **Opaque Cost Accounting:** Difficulty in tracing GL entries back to specific discrete jobs or inventory adjustments.
*   **Reconciliation Gaps:** Challenges in reconciling the Inventory Subledger (or WIP value) with the General Ledger.
*   **Variance Investigation:** Inability to quickly identify the root cause of material usage or efficiency variances.

### The Solution

This report bridges the gap between Finance and Operations by incorporating specific logic to decode Inventory and WIP transactions. It provides a unified view that speaks the language of both the accountant (Debits, Credits, Accounts) and the operations manager (Item Numbers, Job Names, Transaction Types).

#### Key Features:

*   **Enhanced Drilldown:** Extends the standard drilldown to include `MTL_MATERIAL_TRANSACTIONS` and `WIP_TRANSACTIONS`.
*   **Operational Context:** Displays Item Codes, Job Names, Sales Order Numbers, and Transaction Types alongside financial amounts.
*   **Cost Element Visibility:** Helps analyze costs by element (Material, Labor, Overhead, etc.).
*   **Unified Reporting:** Eliminates the need to run separate Inventory and WIP reports to explain GL balances.

### Technical Architecture

This report builds upon the standard GL-SLA architecture but adds specialized joins for the Inventory (Application ID 401) and WIP (Application ID 706) applications.

#### Key Tables Involved:

*   **Standard GL/SLA Tables:** `GL_JE_LINES`, `XLA_AE_LINES`, `GL_IMPORT_REFERENCES`.
*   **Inventory Tables:**
    *   `MTL_MATERIAL_TRANSACTIONS`: The core table for all inventory movements.
    *   `MTL_SYSTEM_ITEMS_B`: For item descriptions and details.
    *   `MTL_TRANSACTION_TYPES`: To identify the nature of the movement (e.g., PO Receipt, Misc Issue).
*   **WIP Tables:**
    *   `WIP_TRANSACTIONS`: For resource and overhead transactions.
    *   `WIP_ENTITIES`: To identify Discrete Jobs or Repetitive Schedules.
    *   `WIP_LINES`: For repetitive schedule details.
*   **Order Management:** `MTL_SALES_ORDERS` and `OE_ORDER_HEADERS_ALL` for linking COGS to sales orders.

#### Critical Joins:

The report uses the `SOURCE_DISTRIBUTION_ID_NUM_1` (and similar columns) in `XLA_DISTRIBUTION_LINKS` to join to `MTL_MATERIAL_TRANSACTIONS.TRANSACTION_ID` or `WIP_TRANSACTIONS.TRANSACTION_ID`. This precise linking ensures that the financial impact is correctly attributed to the physical event.

### Parameters & Filtering

The report supports a comprehensive set of parameters to isolate specific cost activities:

*   **Standard GL Filters:** Ledger, Period, Account Range.
*   **Inventory Filters:** Organization, Subinventory, Item Category.
*   **WIP Filters:** Job Name, Line Name, Department.
*   **Transaction Context:** Transaction Type, Source Type.

### Performance & Optimization

Querying high-volume inventory tables requires careful optimization:

*   **Partition Pruning:** If the underlying tables are partitioned, the query is structured to take advantage of this (e.g., by Transaction Date).
*   **Materialized Views:** In some environments, reliance on standard Oracle materialized views for inventory balances may be leveraged, though this report focuses on transactional detail.
*   **Selective Joins:** The logic conditionally joins to Inventory or WIP tables only when the GL source indicates a relevant transaction type, preventing unnecessary processing overhead.

### FAQ

**Q: Does this report show the specific item that was sold?**
A: Yes, for Cost of Goods Sold (COGS) entries, the report links back to the material transaction to display the Item Number and Description.

**Q: Can I see which Discrete Job generated a variance?**
A: Yes, for WIP variance accounts, the report displays the specific Job Name (WIP Entity Name) associated with the entry.

**Q: Why do I see multiple lines for a single inventory transaction?**
A: A single material movement can generate multiple accounting entries (e.g., Inventory Valuation, Deferred COGS, COGS). This report displays each accounting line to provide a complete financial picture.


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
