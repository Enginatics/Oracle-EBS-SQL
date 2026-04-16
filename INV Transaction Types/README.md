---
layout: default
title: 'INV Transaction Types | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Transaction, Types, mtl_transaction_types, mtl_txn_source_types'
permalink: /INV%20Transaction%20Types/
---

# INV Transaction Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-transaction-types/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Source, Transaction Source Type, Show DFF Attributes

## Oracle EBS Tables Used
[mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Transaction Types 21-Jul-2024 010119.xlsx](https://www.enginatics.com/example/inv-transaction-types/) |
| Blitz Report™ XML Import | [INV_Transaction_Types.xml](https://www.enginatics.com/xml/inv-transaction-types/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-transaction-types/](https://www.enginatics.com/reports/inv-transaction-types/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
