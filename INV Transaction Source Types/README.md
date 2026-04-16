---
layout: default
title: 'INV Transaction Source Types | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Transaction, Source, Types, mtl_txn_source_types'
permalink: /INV%20Transaction%20Source%20Types/
---

# INV Transaction Source Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-transaction-source-types/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Source, Show DFF Attributes

## Oracle EBS Tables Used
[mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Transaction Source Types 20-Jul-2024 235051.xlsx](https://www.enginatics.com/example/inv-transaction-source-types/) |
| Blitz Report™ XML Import | [INV_Transaction_Source_Types.xml](https://www.enginatics.com/xml/inv-transaction-source-types/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-transaction-source-types/](https://www.enginatics.com/reports/inv-transaction-source-types/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
