---
layout: default
last_modified_at: 2026-10-19
title: 'INV Transaction Source Types | Oracle EBS SQL Report'
description: 'Oracle EBS Inventory SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Transaction, Source, Types, mtl_txn_source_types'
permalink: /INV%20Transaction%20Source%20Types/
report_name: 'INV Transaction Source Types'
report_web_name: inv-transaction-source-types
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Transaction Source Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-transaction-source-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Source, DFF Display

## Oracle EBS Tables Used
[mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)

## Related Reports
[INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Transaction%20Source%20Types/INV%20Transaction%20Source%20Types.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Transaction Source Types 20-Jul-2024 235051.xlsx](https://www.enginatics.com/example/inv-transaction-source-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types) |
| Blitz Report™ XML Import | [INV_Transaction_Source_Types.xml](https://www.enginatics.com/xml/inv-transaction-source-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types) |
| SQL Source | [INV Transaction Source Types.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Transaction%20Source%20Types/INV%20Transaction%20Source%20Types.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-transaction-source-types/](https://www.enginatics.com/reports/inv-transaction-source-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types) |

## INV Transaction Source Types - Case Study & Technical Analysis

### Executive Summary
The **INV Transaction Source Types** report is a system configuration report. In Oracle Inventory, every transaction has a "Source Type" that defines *where* the transaction originated (e.g., "Purchase Order", "Sales Order", "Account", "Job or Schedule"). This report lists these system-defined sources.

### Business Challenge
Understanding the "Source" of a transaction is key to understanding the business process.
-   **Reporting:** When building custom reports, developers need to know that Source Type 1 = "Purchase Order" and Source Type 2 = "Sales Order".
-   **Validation:** Users need to know which sources are available when defining new Transaction Types.

### Solution
The **INV Transaction Source Types** report lists the values from `MTL_TXN_SOURCE_TYPES`. These are mostly seeded (system-defined) values that cannot be changed, but they are critical for reference.

**Key Features:**
-   **ID Mapping:** Shows the numeric ID and the user-friendly name.
-   **Validation:** Used as the validation set for the "Source" field in many other forms.

### Technical Architecture
The report queries the seed data table.

#### Key Tables and Views
-   **`MTL_TXN_SOURCE_TYPES`**: The table storing the source definitions.

#### Core Logic
1.  **Retrieval:** Selects all records from the table.
2.  **Display:** Lists the ID, Name, and Description.

### Business Impact
-   **Developer Aid:** Essential reference for anyone writing SQL queries against `MTL_MATERIAL_TRANSACTIONS`.
-   **System Understanding:** Helps users understand the different "origins" of inventory demand and supply.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-source-types)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
