---
layout: default
last_modified_at: 2026-10-26
title: 'CAC ICP PII Material Account Detail | Oracle EBS SQL Report'
description: 'Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction. Including profit in inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, ICP, PII, Material, mtl_parameters, cst_item_cost_details, cst_cost_types'
permalink: /CAC%20ICP%20PII%20Material%20Account%20Detail/
report_name: 'CAC ICP PII Material Account Detail'
report_web_name: cac-icp-pii-material-account-detail
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC ICP PII Material Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-material-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to get the Material accounting distributions, in detail, for each item, organization and individual transaction.  Including profit in inventory amounts based on your PII cost type.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  Use Show Projects to display or not display the project information (project number, name, task and project cost collection status) and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description).  To get all positive and negative amounts above a threshold value, use the Absolute Transaction Amount parameter.  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Both Flow and Workorderless show up as the WIP Type "Flow schedule".

Note:  The SQL logic and code for this report is identical to the CAC Material Account Summary report.

Hidden Parameters:
================
Numeric Sign for PII:  allows you to set the sign of the profit in inventory amounts, defaulted to "1" (mandatory).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc. All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- |  1.32    24 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.30    21 Oct 2022 Douglas Volz    Logic change for Internal RMA order numbers.
-- | 1.31    28 Jul 2025 Douglas Volz    Added Reason Codes and GL & OU Security Profiles.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
PII Cost Type, PII Sub-Element, Transaction Date From, Transaction Date To, Show SLA Accounting, Show Projects, Show WIP Job, Category Set 1, Category Set 2, Category Set 3, Accounting Line Type, Transaction Type, Transaction Source Type, Transaction Id, Minimum Absolute Amount, Only Zero Amounts, Organization Code, Item Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [wip_flow_schedules](https://www.enginatics.com/library/?pg=1&find=wip_flow_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC WIP Material Relief](/CAC%20WIP%20Material%20Relief/ "CAC WIP Material Relief Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20Material%20Account%20Detail/CAC%20ICP%20PII%20Material%20Account%20Detail.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII Material Account Detail 14-Oct-2022 070903.xlsx](https://www.enginatics.com/example/cac-icp-pii-material-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail) |
| Blitz Report™ XML Import | [CAC_ICP_PII_Material_Account_Detail.xml](https://www.enginatics.com/xml/cac-icp-pii-material-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail) |
| SQL Source | [CAC ICP PII Material Account Detail.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20Material%20Account%20Detail/CAC%20ICP%20PII%20Material%20Account%20Detail.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-icp-pii-material-account-detail/](https://www.enginatics.com/reports/cac-icp-pii-material-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-detail)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
