---
layout: default
last_modified_at: 2026-10-26
title: 'INV Transaction Types | Oracle EBS SQL Report'
description: 'Oracle EBS Inventory SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Transaction, Types, mtl_transaction_types, mtl_txn_source_types'
permalink: /INV%20Transaction%20Types/
report_name: 'INV Transaction Types'
report_web_name: inv-transaction-types
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Transaction Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-transaction-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Source, Transaction Source Type, DFF Display

## Oracle EBS Tables Used
[mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)

## Related Reports
[INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Transaction%20Types/INV%20Transaction%20Types.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Transaction Types 21-Jul-2024 010119.xlsx](https://www.enginatics.com/example/inv-transaction-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types) |
| Blitz Report™ XML Import | [INV_Transaction_Types.xml](https://www.enginatics.com/xml/inv-transaction-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types) |
| SQL Source | [INV Transaction Types.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Transaction%20Types/INV%20Transaction%20Types.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-transaction-types/](https://www.enginatics.com/reports/inv-transaction-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types) |

## INV Transaction Types - Case Study & Technical Analysis

### Executive Summary
The **INV Transaction Types** report is a configuration document that lists all the defined "Actions" that can be performed on inventory. Examples include "PO Receipt", "Subinventory Transfer", "Miscellaneous Issue", and "WIP Assembly Return". This report defines the rules for each action.

### Business Challenge
Transaction Types control the financial and operational behavior of a movement.
-   **Financial Impact:** "Does this 'Sample Issue' hit the Marketing Expense account or the Scrap account?"
-   **Process Control:** "Does this 'RMA Receipt' require a Quality Inspection?"
-   **Location Control:** "Can I perform this transaction in a WMS-enabled organization?"

### Solution
The **INV Transaction Types** report details the setup of each transaction type. It shows the link between the user-facing name (e.g., "Misc Issue") and the system behavior (e.g., "Issue from Stores").

**Key Features:**
-   **Action Definition:** Shows the "Source Type" (e.g., Inventory) and "Action" (e.g., Issue from Stores).
-   **Financial Flags:** Indicates if the transaction is "Project Enabled" or "Location Required".
-   **Status Control:** Shows if the transaction is valid for certain material statuses.

### Technical Architecture
The report queries the transaction type definition table.

#### Key Tables and Views
-   **`MTL_TRANSACTION_TYPES`**: The master table for transaction definitions.
-   **`MTL_TXN_SOURCE_TYPES`**: The source type linked to the transaction.

#### Core Logic
1.  **Retrieval:** Selects all records from `MTL_TRANSACTION_TYPES`.
2.  **Context:** Joins to `MTL_TXN_SOURCE_TYPES` to explain the source.
3.  **Validation:** Checks flags for Status Control and Location Control.

### Business Impact
-   **Process Standardization:** Ensures that everyone uses the correct transaction type for a given business scenario (e.g., using "Scrap Issue" instead of "Misc Issue").
-   **Financial Accuracy:** Ensures that transactions drive the correct accounting entries.
-   **System Governance:** Documents the allowed inventory movements for audit purposes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-transaction-types)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
