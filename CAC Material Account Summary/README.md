---
layout: default
title: 'CAC Material Account Summary | Oracle EBS SQL Report'
description: 'Report to get the Material accounting distributions, in summary, for each item, organization and subinventory. Including Ship From and Ship To information…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Material, Account, Summary, mfg_lookups, mtl_system_items_vl, org_acct_periods'
permalink: /CAC%20Material%20Account%20Summary/
---

# CAC Material Account Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-material-account-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the Material accounting distributions, in summary, for each item, organization and subinventory.  Including Ship From and Ship To information for inter-org transfers.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to also limit the report size.  Use Show Subinventories to display or not display the subinventory information. Use Show Projects to display or not display the project number and name and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description).  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Both Flow and Workorderless show up as the WIP Type "Flow schedule".   Also note this report version shows the latest item status and make buy codes, even if you run the report for prior accounting periods.

Note:  this report has identical code and logic as the CAC ICP PII Material Account Summary report, however, with the use of hidden parameters, the PII (profit in inventory) features have been turned off.

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project number and name.  Enter Yes or No, use to limit the report size (mandatory).
Show Subinventories:  display the subinventory code and description.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP:  display the WIP job or flow schedule information (WIP class, class type, WIP job, description, assembly number and assembly description).  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.27    07 Oct 2022 Douglas Volz    Correction for period name joins for interorg transactions.
-- | 1.28    16 Oct 2022 Douglas Volz    Correction for quantity calculations and PII logic.
-- | 1.30    13 Jun 2024 Douglas Volz    Removed tabs, reinstalled parameters, including org access restrictions.
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Subinventory, Show Projects, Show WIP Job, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [pii](https://www.enginatics.com/library/?pg=1&find=pii), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [&subledger_tab](https://www.enginatics.com/library/?pg=1&find=&subledger_tab), [&subinventory_table](https://www.enginatics.com/library/?pg=1&find=&subinventory_table)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Material Account Summary - Pivot by Org 16-Oct-2022 165743.xlsx](https://www.enginatics.com/example/cac-material-account-summary/) |
| Blitz Report™ XML Import | [CAC_Material_Account_Summary.xml](https://www.enginatics.com/xml/cac-material-account-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-material-account-summary/](https://www.enginatics.com/reports/cac-material-account-summary/) |


## Case Study & Technical Analysis: CAC Material Account Summary

### Executive Summary
The **CAC Material Account Summary** report is a comprehensive accounting analysis tool designed to bridge the gap between Inventory operations and the General Ledger. It provides a summarized view of material transactions, grouped by General Ledger (GL) account, Item, and Organization.
This report is essential for:
1.  **Month-End Reconciliation:** Validating that the inventory subledger matches the GL balance.
2.  **Variance Analysis:** Identifying specific items or transactions driving unexpected account balances (e.g., high Purchase Price Variance).
3.  **Inter-Company Auditing:** Tracking goods moving between organizations with clear "Ship From" and "Ship To" visibility.

### Business Challenge
In Oracle EBS, the link between a physical inventory transaction (e.g., "PO Receipt") and the resulting financial journal entry can be opaque.
*   **Volume:** A single organization can generate millions of transactions per month.
*   **Complexity:** A single transaction can trigger multiple accounting lines (Inventory, Accrual, Variance, Absorption).
*   **SLA vs. Legacy:** With the introduction of Subledger Accounting (SLA) in R12, the source of truth for accounting shifted from `MTL_TRANSACTION_ACCOUNTS` to the SLA tables (`XLA_AE_LINES`), making direct reporting more difficult.

### The Solution
This report solves these challenges by offering a flexible, dual-mode architecture:
*   **SLA-Aware:** The `Show SLA Accounting` parameter allows users to toggle between the legacy inventory accounting view and the final SLA accounting view. This is crucial for organizations that use SLA rules to modify account segments (e.g., redirecting cost centers based on project codes).
*   **Summarization:** Unlike detailed transaction registers that list every single movement, this report aggregates data by Account, Item, and Subinventory. This reduces report size and highlights *net* activity, making it easier to spot trends.
*   **Context Rich:** It enriches the accounting data with operational context:
    *   **Inter-Org Details:** Explicitly shows Shipping and Receiving organizations and FOB points.
    *   **WIP & Projects:** Optionally links material costs to specific Work Orders or Projects.

### Technical Architecture (High Level)
The query uses a sophisticated structure to handle the complexity of Oracle's inventory accounting model.
*   **PII (Profit in Inventory) CTE:** A Common Table Expression (`pii`) is defined at the start. While primarily used in the "ICP PII" version of this report, it remains here to support potential profit elimination logic for inter-company transfers.
*   **Dynamic Source Selection:**
    *   **Non-SLA Mode:** Queries `MTL_TRANSACTION_ACCOUNTS` directly. This is faster but reflects the "raw" inventory accounting before any SLA rules are applied.
    *   **SLA Mode:** Joins `MTL_MATERIAL_TRANSACTIONS` to `XLA_DISTRIBUTION_LINKS`, `XLA_AE_HEADERS`, and `XLA_AE_LINES`. This ensures the report matches the final GL entries exactly.
*   **Union Architecture:** The main body of the report is likely a `UNION ALL` (implied by the complexity description, though the snippet shows a single select, the full code often unions WIP and Inventory or different accounting sources). *Correction based on code review:* The provided code snippet shows a single main select but relies on dynamic SQL (`&subledger_tab`) to switch the underlying data source.
*   **Granularity Control:** Parameters like `Show Subinventories`, `Show Projects`, and `Show WIP` dynamically alter the `GROUP BY` clause, allowing the user to trade off between detail and performance.

### Parameters & Filtering
*   **Show SLA Accounting (Yes/No):** The master switch for the data source (Legacy vs. SLA).
*   **Transaction Date From/To:** Defines the reporting period.
*   **Show Subinventories:** Toggles subinventory-level detail.
*   **Show Projects / Show WIP:** Toggles Project and Work Order details.
*   **Category Sets:** Allows filtering by specific item categories (e.g., "Product Line").

### Performance & Optimization
*   **Dynamic Grouping:** By only grouping by the requested dimensions (Subinventory, Project, WIP), the database engine avoids unnecessary sorting and aggregation work when those details are not needed.
*   **Org Access View:** The query respects Oracle's standard security model (`org_access_view`), ensuring users only see data for organizations they are authorized to access.

### FAQ
**Q: Why do I see different accounts when I switch "Show SLA Accounting" to Yes?**
A: This indicates that your organization uses SLA rules to transform the account generated by the inventory transaction manager. The "Yes" view is the correct one for GL reconciliation.

**Q: Can I use this report for WIP reconciliation?**
A: Yes, if you enable `Show WIP`, you can see material issues and completions tied to specific jobs. However, for full WIP value analysis, the "WIP Value Report" is more specialized.

**Q: What is the "PII" logic mentioned in the header?**
A: PII stands for "Profit in Inventory". It refers to the markup added when goods are sold between internal organizations. This report shares code with a PII-specific version but has those features disabled by default to focus on standard material accounting.

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
