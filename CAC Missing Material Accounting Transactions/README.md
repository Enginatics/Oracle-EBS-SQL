---
layout: default
last_modified_at: 2026-10-19
title: 'CAC Missing Material Accounting Transactions | Oracle EBS SQL Report'
description: 'Report to find material accounting entries where the material transaction''s costed flag says that the transaction has been costed but the material…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Missing, Material, Accounting, wip_entities, mfg_lookups, wip_discrete_jobs'
permalink: /CAC%20Missing%20Material%20Accounting%20Transactions/
report_name: 'CAC Missing Material Accounting Transactions'
report_web_name: cac-missing-material-accounting-transactions
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Missing Material Accounting Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-missing-material-accounting-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Minimum Transaction Amount, Only Costed Items, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Missing%20Material%20Accounting%20Transactions/CAC%20Missing%20Material%20Accounting%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Missing Material Accounting Transactions 23-Jul-2022 161255.xlsx](https://www.enginatics.com/example/cac-missing-material-accounting-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions) |
| Blitz Report™ XML Import | [CAC_Missing_Material_Accounting_Transactions.xml](https://www.enginatics.com/xml/cac-missing-material-accounting-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions) |
| SQL Source | [CAC Missing Material Accounting Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Missing%20Material%20Accounting%20Transactions/CAC%20Missing%20Material%20Accounting%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-missing-material-accounting-transactions/](https://www.enginatics.com/reports/cac-missing-material-accounting-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-missing-material-accounting-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
