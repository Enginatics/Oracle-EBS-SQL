---
layout: default
title: 'CAC ICP PII Material Account Detail | Oracle EBS SQL Report'
description: 'Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction. Including profit in inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting - Profit in Inventory, Cost Accounting - Transactions, Enginatics, R12 only, CAC, ICP, PII, Material, mfg_lookups, mtl_system_items_vl, org_acct_periods'
permalink: /CAC%20ICP%20PII%20Material%20Account%20Detail/
---

# CAC ICP PII Material Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-material-account-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction.  Including profit in inventory amounts based on your PII cost type.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  Use Show Projects to display or not display the project information (project number, name, task and project cost collection status) and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description).  To get all positive and negative amounts above a threshold value, use the Absolute Transaction Amount parameter.  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Both Flow and Workorderless show up as the WIP Type "Flow schedule".

Note:  The SQL logic and code for this report is identical to the CAC Material Account Summary report.

Hidden Parameters:
================
Numeric Sign for PII:  allows you to set the sign of the profit in inventory amounts, defaulted to "1" (mandatory).

Parameters:
===========
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project information.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP:  display the WIP job or flow schedule information.  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Accounting Line Type:  enter the accounting purpose or line type to report (optional). 
Transaction Type:  select the material transaction type, such as PO Receipt, Return to Vendor or Account Alias Issue (optional).
Transaction Source Type:  select the material transaction source, such as Purchase Order or Account Alias (optional).
Transaction Id:  enter the transaction number or identifier to report (optional).
Minimum Absolute Amount:  enter the minimum debit or credit to report (optional).  To see all accounting entries, enter zero (0).
Only Zero Amounts:  use this parameter to find entries with a zero transaction amount (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc. All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.30    21 Oct 2022 Douglas Volz    Logic change for Internal RMA order numbers.
-- | 1.31    28 Jul 2025 Douglas Volz    Added Reason Codes and GL & OU Security Profiles.

## Report Parameters
PII Cost Type, PII Sub-Element, Transaction Date From, Transaction Date To, Show SLA Accounting, Show Projects, Show WIP Job, Category Set 1, Category Set 2, Category Set 3, Accounting Line Type, Transaction Type, Transaction Source Type, Transaction Id, Minimum Absolute Amount, Only Zero Amounts, Organization Code, Item Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [pii](https://www.enginatics.com/library/?pg=1&find=pii), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [&pii_lookup_table](https://www.enginatics.com/library/?pg=1&find=&pii_lookup_table), [select](https://www.enginatics.com/library/?pg=1&find=select), [decode](https://www.enginatics.com/library/?pg=1&find=decode), [organization_id](https://www.enginatics.com/library/?pg=1&find=organization_id), [fob_point](https://www.enginatics.com/library/?pg=1&find=fob_point), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [reference_account](https://www.enginatics.com/library/?pg=1&find=reference_account), [inv_sub_ledger_id](https://www.enginatics.com/library/?pg=1&find=inv_sub_ledger_id), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [transaction_source_type_id](https://www.enginatics.com/library/?pg=1&find=transaction_source_type_id), [&show_document_number](https://www.enginatics.com/library/?pg=1&find=&show_document_number), [transaction_id](https://www.enginatics.com/library/?pg=1&find=transaction_id), [transfer_transaction_id](https://www.enginatics.com/library/?pg=1&find=transfer_transaction_id), [parent_transaction_id](https://www.enginatics.com/library/?pg=1&find=parent_transaction_id), [transaction_date](https://www.enginatics.com/library/?pg=1&find=transaction_date), [creation_date](https://www.enginatics.com/library/?pg=1&find=creation_date), [created_by](https://www.enginatics.com/library/?pg=1&find=created_by), [reason_id](https://www.enginatics.com/library/?pg=1&find=reason_id), [regexp_replace](https://www.enginatics.com/library/?pg=1&find=regexp_replace), [transaction_type_id](https://www.enginatics.com/library/?pg=1&find=transaction_type_id), [accounting_line_type](https://www.enginatics.com/library/?pg=1&find=accounting_line_type), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Cost Accounting - Profit in Inventory](https://www.enginatics.com/library/?pg=1&category[]=Cost%20Accounting%20-%20Profit%20in%20Inventory), [Cost Accounting - Transactions](https://www.enginatics.com/library/?pg=1&category[]=Cost%20Accounting%20-%20Transactions), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII Material Account Detail 14-Oct-2022 070903.xlsx](https://www.enginatics.com/example/cac-icp-pii-material-account-detail/) |
| Blitz Report™ XML Import | [CAC_ICP_PII_Material_Account_Detail.xml](https://www.enginatics.com/xml/cac-icp-pii-material-account-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-icp-pii-material-account-detail/](https://www.enginatics.com/reports/cac-icp-pii-material-account-detail/) |

## Case Study & Technical Analysis: CAC ICP PII Material Account Detail

### Executive Summary
The **CAC ICP PII Material Account Detail** report is a forensic accounting tool that bridges the gap between operational inventory transactions and financial profit elimination. It provides a granular, transaction-by-transaction view of material movements, overlaid with the specific **Intercompany Profit (ICP)** or **Profit in Inventory (PII)** value associated with each item. This allows finance teams to audit exactly *which* transactions contributed to the PII balance in the General Ledger.

### Business Challenge
Eliminating intercompany profit is often done at a high level (e.g., "Total Inventory * Margin %"). However, this approach fails when:
*   **Margins Vary:** Different items have different profit margins.
*   **Transaction Timing:** Profit is only realized when the item is sold to a third party. Internal transfers just move the profit around.
*   **Audit Trails:** Auditors ask, "Why did the PII elimination account change by $50,000 this month?" A high-level summary cannot answer this.
*   **Reconciliation:** When the General Ledger PII balance doesn't match the calculated PII in inventory, finding the culprit transaction is like finding a needle in a haystack.

### The Solution
This report solves the reconciliation challenge by attaching the PII value to every single material transaction.
*   **Transaction-Level PII:** It calculates `Transaction Quantity * PII Unit Cost` for every receipt, issue, and transfer.
*   **Accounting Visibility:** It shows the actual Debit and Credit accounts hit by the transaction, allowing users to see if the PII was correctly moved or expensed.
*   **SLA Integration:** It supports both the legacy inventory accounting (`MTL_TRANSACTION_ACCOUNTS`) and the modern Subledger Accounting (`XLA_DISTRIBUTION_LINKS`) to ensure the data matches the final GL entries.

### Technical Architecture (High Level)
The query combines a specialized PII calculation with a massive transaction detail extract.
*   **PII CTE:** A Common Table Expression (`pii`) pre-calculates the PII unit cost for every item/organization combination based on the user-specified `PII Cost Type` and `PII Sub-Element`.
*   **Main Query:** This joins the PII CTE to the material transaction tables (`MTL_MATERIAL_TRANSACTIONS`, `MTL_TRANSACTION_ACCOUNTS` or `XLA_...`).
*   **Dynamic Accounting:** The `Show SLA Accounting` parameter toggles the logic to pull account numbers either from the raw inventory subledger or the final SLA distribution links, handling the complexity of R12 accounting engines.

### Parameters & Filtering
*   **PII Cost Type & Sub-Element:** Critical parameters that define *what* the system considers "Profit."
*   **Transaction Date Range:** Allows for focused period-end auditing.
*   **Show SLA Accounting:** "Yes" provides the most accurate GL view; "No" provides a faster operational view.
*   **Show Projects / WIP:** Optional flags to bring in Project Manufacturing or Work in Process context, which can be performance-intensive.
*   **Minimum Absolute Amount:** Filters out small "noise" transactions to focus on material variances.

### Performance & Optimization
*   **CTE Strategy:** Calculating PII costs in a CTE once per item/org is far more efficient than recalculating it for every single transaction row.
*   **Indexed Filtering:** The query relies heavily on `TRANSACTION_DATE` and `ORGANIZATION_ID` indexes to limit the dataset before joining to the heavy accounting tables.

### FAQ
**Q: Why does the report show PII for "Issue to WIP" transactions?**
A: When raw materials are issued to a job, the profit embedded in those materials moves from "Raw Material Inventory" to "WIP Inventory." This report tracks that movement to ensure the PII isn't accidentally written off or lost during production.

**Q: Can I use this to reconcile my PII GL Account?**
A: Yes. By filtering for your PII GL Account in the output (using Excel filters on the account segments), you can sum the "PII Amount" column and compare it to the "Transaction Amount" to see if the manual or automated entries match the theoretical PII movement.

**Q: What is the "Numeric Sign for PII" parameter?**
A: Some companies store PII as a negative cost element (contra-asset) to net it out, while others store it as a positive statistical element. This parameter ensures the report sums the values correctly regardless of the setup.


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
