---
layout: default
title: 'CAC Missing Material Accounting Transactions | Oracle EBS SQL Report'
description: 'Report to find material accounting entries where the material transaction''s costed flag says that the transaction has been costed but the material…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Missing, Material, Accounting, wip_entities, mfg_lookups, wip_discrete_jobs'
permalink: /CAC%20Missing%20Material%20Accounting%20Transactions/
---

# CAC Missing Material Accounting Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-missing-material-accounting-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to find material accounting entries where the material transaction's costed flag says that the transaction has been costed but the material accounting entries do not exist.  If you enter Yes for "Only Costed Items" the report ignores material transactions where the transaction item cost does not exist (null value) or where the item's inventory asset setting in the item master is set to No.  If you enter No for "Only Costed Items" the report includes material transactions where the item cost does not exist or where the item's inventory asset setting is set to No.  To get all transactions which are missing the material accounting entries, even for transactions where the transaction amounts are too small, set the "Only Costed Items" to No and the Minimum Transaction Amount to zero (0).  

Notes:
1)  For PO Receipts the Transaction Cost column displays the purchase order unit price.
2)  For Cost Updates the Transaction Cost column displays the item cost differences between the old and new costs.
3)  The Item Cost column shows average or standard costs at the time and date of the transaction.
4)  For Pick Transactions, Move Order Transfers, Subinventory Transfers and Direct Transfers, the Transfer Transaction Id column indicates the second half of the transfer, for the receipt back into the receiving subinventory (which never has any material accounting entries).

Parameters:
Transaction Date From:  Starting transaction date, mandatory
Transaction Date:  Ending transaction date, mandatory
Minimum Transaction Amount:  The absolute smallest transaction amount to be reported
Only Costed Items:  Only include items where the item master asset flag is set to Yes and where the material transaction has a non-null item cost
Category Set 1:  The first item category set to report, typically the Cost or Product Line Category Set
Category Set 2:  The second item category set to report, typically the Inventory Category Set
Item Number:  Specific item number you wish to report (optional)
Organization Code:  Specific inventory organization you wish to report (optional)
Operating Unit:  Operating Unit you wish to report, leave blank for all operating units (optional) 
Ledger:  general ledger you wish to report, leave blank for all ledgers (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2023 Douglas Volz Consulting, Inc. 
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this  permission. 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.1     11 Nov 2009 Douglas Volz   Added Org Code and transaction ID
-- |  1.2     12 Nov 2009 Douglas Volz   Added item and description
-- |  1.3     06 Jan 2010 Douglas Volz   Made dates a parameter
-- |  1.4     12 Jan 2010 Douglas Volz   Added quantity and unit cost columns
-- |  1.5     14 Jul 2022 Douglas Volz   Added comparison to WIP material accounting
-- |  1.6     19 Jul 2022 Douglas Volz   Modify to be run for all material transactions
-- |  1.7     20 Jul 2022 Douglas Volz   Add parameter for only costed items and transactions.
-- |  1.8     21 Jul 2022 Douglas Volz   Added transaction cost, WIP job and job status
-- |  1.9     23 Jul 2022 Douglas Volz   Added Ledger and Operating Unit columns.
-- |  1.10    25 Jul 2022 Douglas Volz   Added transfer transaction id column
-- |  1.11    11 Jul 2023 Douglas Volz   Fix for expense subinventories, remove tabs and restrict to only orgs you have access to. 
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Minimum Transaction Amount, Only Costed Items, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Missing Material Accounting Transactions 23-Jul-2022 161255.xlsx](https://www.enginatics.com/example/cac-missing-material-accounting-transactions/) |
| Blitz Report™ XML Import | [CAC_Missing_Material_Accounting_Transactions.xml](https://www.enginatics.com/xml/cac-missing-material-accounting-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-missing-material-accounting-transactions/](https://www.enginatics.com/reports/cac-missing-material-accounting-transactions/) |

## Case Study & Technical Analysis: CAC Missing Material Accounting Transactions

### Executive Summary
The **CAC Missing Material Accounting Transactions** report is a critical health check for the Costing process. It identifies "Costed" material transactions that failed to generate accounting entries. In a healthy system, this report should be empty. If rows appear, it indicates data corruption or a stuck process that requires immediate IT intervention.

### Business Challenge
*   **Financial Integrity**: If a shipment occurs ($100 credit to Inventory) but no accounting is generated, the GL Inventory balance will remain $100 higher than reality.
*   **Period Close**: You cannot close the inventory period if transactions are uncosted, but "Missing Accounting" transactions often slip through the standard close check because they are technically flagged as "Costed".
*   **Root Cause**: Often caused by code bugs, database triggers, or severe performance issues during the Cost Manager run.

### Solution
This report finds the gap.
*   **Logic**: Looks for rows in `mtl_material_transactions` where `costed_flag IS NULL` (meaning costed) BUT no rows exist in `mtl_transaction_accounts`.
*   **Filters**: Can ignore "Expense" items (which might not generate accounting depending on setup) and zero-cost items.
*   **Context**: Shows the Transaction Type and ID to help the DBA investigate.

### Technical Architecture
*   **Tables**: `mtl_material_transactions` (MMT), `mtl_transaction_accounts` (MTA).
*   **Join**: `MMT.transaction_id = MTA.transaction_id (+)`.
*   **Condition**: `MTA.transaction_id IS NULL`.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Period to check.
*   **Only Costed Items**: (Optional) To filter out items that shouldn't have accounting anyway (Asset = No).

### Performance
*   **Efficient**: Uses an anti-join pattern (NOT EXISTS or Outer Join IS NULL) which is generally efficient on indexed transaction IDs.

### FAQ
**Q: How do I fix these?**
A: You typically cannot fix them from the front end. You may need to "Uncost" the transaction (set `costed_flag = 'N'`) via SQL to force the Cost Manager to try again.

**Q: Are expense items included?**
A: By default, yes, but the "Only Costed Items" parameter allows you to exclude them if your policy is not to account for expense item movements.


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
