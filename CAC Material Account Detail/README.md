---
layout: default
title: 'CAC Material Account Detail | Oracle EBS SQL Report'
description: 'Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction. Including Ship From and Ship To…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting - Transactions, Enginatics, R12 only, CAC, Material, Account, Detail, mfg_lookups, mtl_system_items_vl, org_acct_periods'
permalink: /CAC%20Material%20Account%20Detail/
---

# CAC Material Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-material-account-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction.  Including Ship From and Ship To information for inter-org transfers.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  Use Show Projects to display or not display the project information (project number, name, task and project cost collection status) and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description).  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Both Flow and Workorderless show up as the WIP Type "Flow schedule".  And to get all positive and negative amounts above a threshold value, use the Minimum Absolute Amount parameter.

Note:  this report has identical code and logic as the CAC ICP PII Material Account Detail report, however, but with the use of hidden parameters, the PII (profit in inventory) features have been turned off.

Parameters:
===========
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
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.29    19 Oct 2022 Douglas Volz    Performance improvements for PII item costs and WIP components.
-- | 1.30    21 Oct 2022 Douglas Volz    Logic change for resolving Internal RMA order numbers.
-- | 1.31    28 Jul 2025 Douglas Volz    Added Reason Codes and GL & OU Security Profiles.
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Projects, Show WIP Job, Category Set 1, Category Set 2, Category Set 3, Accounting Line Type, Transaction Type, Transaction Source Type, Transaction Id, Minimum Absolute Amount, Only Zero Amounts, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [pii](https://www.enginatics.com/library/?pg=1&find=pii), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [&pii_lookup_table](https://www.enginatics.com/library/?pg=1&find=&pii_lookup_table), [select](https://www.enginatics.com/library/?pg=1&find=select), [decode](https://www.enginatics.com/library/?pg=1&find=decode), [organization_id](https://www.enginatics.com/library/?pg=1&find=organization_id), [fob_point](https://www.enginatics.com/library/?pg=1&find=fob_point), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [reference_account](https://www.enginatics.com/library/?pg=1&find=reference_account), [inv_sub_ledger_id](https://www.enginatics.com/library/?pg=1&find=inv_sub_ledger_id), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [transaction_source_type_id](https://www.enginatics.com/library/?pg=1&find=transaction_source_type_id), [&show_document_number](https://www.enginatics.com/library/?pg=1&find=&show_document_number), [transaction_id](https://www.enginatics.com/library/?pg=1&find=transaction_id), [transfer_transaction_id](https://www.enginatics.com/library/?pg=1&find=transfer_transaction_id), [parent_transaction_id](https://www.enginatics.com/library/?pg=1&find=parent_transaction_id), [transaction_date](https://www.enginatics.com/library/?pg=1&find=transaction_date), [creation_date](https://www.enginatics.com/library/?pg=1&find=creation_date), [created_by](https://www.enginatics.com/library/?pg=1&find=created_by), [reason_id](https://www.enginatics.com/library/?pg=1&find=reason_id), [regexp_replace](https://www.enginatics.com/library/?pg=1&find=regexp_replace), [transaction_type_id](https://www.enginatics.com/library/?pg=1&find=transaction_type_id), [accounting_line_type](https://www.enginatics.com/library/?pg=1&find=accounting_line_type), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Cost Accounting - Transactions](https://www.enginatics.com/library/?pg=1&category[]=Cost%20Accounting%20-%20Transactions), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Material Account Detail 14-Oct-2022 070720.xlsx](https://www.enginatics.com/example/cac-material-account-detail/) |
| Blitz Report™ XML Import | [CAC_Material_Account_Detail.xml](https://www.enginatics.com/xml/cac-material-account-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-material-account-detail/](https://www.enginatics.com/reports/cac-material-account-detail/) |

## Case Study & Technical Analysis: CAC Material Account Detail

### Executive Summary
The **CAC Material Account Detail** report is the ultimate reconciliation tool for Inventory Accounting. It provides a granular, line-by-line view of the accounting distributions generated by material transactions. Whether you are investigating a specific variance, auditing a high-value adjustment, or reconciling the General Ledger, this report provides the "Subledger" truth.

### Business Challenge
*   **Reconciliation**: When the GL balance doesn't match the Inventory Valuation report, accountants need to find the specific transactions causing the difference.
*   **SLA Complexity**: With Subledger Accounting (SLA), the final GL account might differ from the default account on the transaction. Tracing this transformation is difficult.
*   **Project Accounting**: For project-based organizations, verifying that costs hit the correct Project and Task is critical for billing.

### Solution
This report exposes the full accounting lifecycle.
*   **Dual Mode**: Can report either the "Raw" accounting (from `mtl_transaction_accounts`) or the "Final" SLA accounting (from `xla_distribution_links`), depending on the parameter.
*   **Context**: Includes WIP Job, Project, and Inter-org transfer details to explain *why* the entry occurred.
*   **Filtering**: Powerful filters for Transaction Type, Source, and Amount allow users to isolate specific issues (e.g., "Show me all Account Alias Issues over $10,000").

### Technical Architecture
*   **Core Tables**: `mtl_material_transactions` (MMT) and `mtl_transaction_accounts` (MTA).
*   **SLA Integration**: If "Show SLA" is Yes, it joins to `xla_distribution_links`, `xla_ae_headers`, and `xla_ae_lines`.
*   **Performance**: Uses the `pii` (Profit in Inventory) logic structure but adapted for standard reporting.

### Parameters
*   **Transaction Date From/To**: (Mandatory) Reporting period.
*   **Show SLA Accounting**: (Mandatory) Toggle for SLA vs. Legacy accounting.
*   **Show Projects/WIP**: (Mandatory) Toggles to control report width and detail.
*   **Minimum Absolute Amount**: (Optional) To filter out penny variances.

### Performance
*   **Heavy**: This report queries the largest tables in the system. Running it for a full year or "All Items" is not recommended.
*   **Optimization**: Always filter by Date Range and Organization.

### FAQ
**Q: Why do I see two sets of entries?**
A: If you have "Show SLA" enabled, you might be seeing the secondary ledger entries or multiple accounting representations.

**Q: What is "Transfer Transaction ID"?**
A: For inter-org transfers, this links the Shipment transaction to the Receipt transaction, allowing you to see both sides of the entry.

**Q: Does it show encumbrances?**
A: No, this report focuses on Actuals (Cost Accounting). Encumbrances are handled in Purchasing/GL.


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
