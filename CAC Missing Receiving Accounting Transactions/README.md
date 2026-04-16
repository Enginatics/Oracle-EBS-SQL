---
layout: default
title: 'CAC Missing Receiving Accounting Transactions | Oracle EBS SQL Report'
description: 'Report to find receiving transactions where the receiving accounting entries do not exist, for PO receipts into receiving and for returns from inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Missing, Receiving, Accounting, org_acct_periods, rcv_transactions, fnd_lookup_values'
permalink: /CAC%20Missing%20Receiving%20Accounting%20Transactions/
---

# CAC Missing Receiving Accounting Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-missing-receiving-accounting-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to find receiving transactions where the receiving accounting entries do not exist, for PO receipts into receiving and for returns from inventory and outside processing (work in process).  To get all transactions which are missing receiving accounting entries, even for transactions where the transaction amounts are too small, set the Minimum Transaction Amount to zero (0).  And note the quantities and purchase order unit prices are expressed in the item's primary unit of measure. 

Note:  To find missing purchase order deliveries into inventory or work in process, use the CAC Missing Material Transactions and the CAC Missing WIP Transactions reports.

/* +=============================================================================+
-- |  Copyright 2022 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  find_missing_receiving_accounting_entries.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- Starting transaction date, mandatory
-- |  p_trx_date_to      -- Ending transaction date, mandatory
-- |  p_minimum_amount   -- The absolute smallest transaction amount to be reported
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |  p_item_number      -- Specific item number you wish to report (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report to find receiving transactions where the receiving accounting entries do not
-- |  exist.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     14 Jul 2022 Douglas Volz   Initial Coding
-- |  1.1     15 Jul 2022 Douglas Volz   Added PO number, PO Line, decode on receipt
-- |                                     quantity.
-- |  1.2     18 Jul 2022 Douglas Volz   Correct logic for CORRECT transaction types.
-- |  1.3     23 Jul 2022 Douglas Volz   Added Parent Transaction Type to report.
-- |                                     Additional exclusions for CORRECT transactions.
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Minimum Transaction Amount, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Missing Receiving Accounting Transactions 23-Jul-2022 171912.xlsx](https://www.enginatics.com/example/cac-missing-receiving-accounting-transactions/) |
| Blitz Report™ XML Import | [CAC_Missing_Receiving_Accounting_Transactions.xml](https://www.enginatics.com/xml/cac-missing-receiving-accounting-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-missing-receiving-accounting-transactions/](https://www.enginatics.com/reports/cac-missing-receiving-accounting-transactions/) |

## Case Study & Technical Analysis: CAC Missing Receiving Accounting Transactions

### Executive Summary
The **CAC Missing Receiving Accounting Transactions** report is the Receiving equivalent of the Material Missing Accounting report. It identifies Receiving transactions (Receipts, Deliveries, Returns) that have been processed but failed to generate the necessary accounting entries in the Receiving Subledger (`rcv_receiving_sub_ledger`).

### Business Challenge
*   **Accrual Reconciliation**: The "Received Not Invoiced" (Accrual) account relies on these entries. If they are missing, the Accrual Reconciliation report will be wrong.
*   **Inventory Value**: A "Delivery" transaction moves cost from Receiving Inspection to Inventory. If the accounting is missing, the Inspection account won't clear.
*   **Compliance**: Every financial event must have a GL impact.

### Solution
This report identifies the orphans.
*   **Logic**: Checks `rcv_transactions` against `rcv_receiving_sub_ledger`.
*   **Scope**: Includes PO Receipts, RMAs, and OSP receipts.
*   **Exclusions**: Filters out transaction types that don't generate accounting (e.g., some internal moves).

### Technical Architecture
*   **Tables**: `rcv_transactions` (RT), `rcv_receiving_sub_ledger` (RRSL).
*   **Join**: `RT.transaction_id = RRSL.rcv_transaction_id (+)`.
*   **Condition**: `RRSL.rcv_transaction_id IS NULL`.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Period.
*   **Minimum Transaction Amount**: (Optional) To ignore zero-dollar receipts.

### Performance
*   **Fast**: Receiving volumes are typically lower than Material volumes.

### FAQ
**Q: Why does this happen?**
A: Often due to the "Receiving Transaction Processor" failing or the "Create Accounting - Receiving" program not picking up the event.

**Q: Does it include "Correct" transactions?**
A: Yes, corrections should generate accounting (reversing the original entry), so they are checked as well.


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
