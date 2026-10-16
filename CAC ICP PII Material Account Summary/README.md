---
layout: default
last_modified_at: 2026-10-16
title: 'CAC ICP PII Material Account Summary | Oracle EBS SQL Report'
description: 'Use this report to eliminate your internal profit in inventory (PII) at month-end. This report to sums up the material accounting entries for each item…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, ICP, PII, Material, cst_item_cost_details, bom_resources, cst_cost_types'
permalink: /CAC%20ICP%20PII%20Material%20Account%20Summary/
report_name: 'CAC ICP PII Material Account Summary'
report_web_name: cac-icp-pii-material-account-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC ICP PII Material Account Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-material-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Use this report to eliminate your internal profit in inventory (PII) at month-end.  This report to sums up the material accounting entries for each item, organization, subinventory with the original amount, profit in inventory and net amounts.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  Use Show Subinventories to display or not display the subinventory information. Use Show Projects to display or not display the project number and name and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description).  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Both Flow and Workorderless show up as the WIP Type "Flow schedule".  And for WIP Completions and WIP Completion Returns, this report also has a column "PII Zero Component Quantity" indicating if the underlying components, which have PII, were not issued to the job.  If not, the PII amount for WIP completions, for WIP jobs that were open, may be overstated as the PII is actually still sitting in the onhand inventory.

Note:  there is a hidden parameter, Numeric Sign for PII, which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts into your PII Cost Type.  Defaulted as positive (+1).

Note:  The SQL logic and code for this report is identical to the CAC Material Account Summary report.

Parameters:
===========
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project number and name.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP:  display the WIP job or flow schedule information (WIP class, class type, WIP job, description, assembly number and assembly description).  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. 
-- +=============================================================================+
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- | 1.27    07 Oct 2022 Douglas Volz    Correction for period name joins for interorg transactions.
-- | 1.28    16 Oct 2022 Douglas Volz    Correction for quantity calculations and PII logic.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
PII Cost Type, PII Sub-Element, Transaction Date From, Transaction Date To, Show SLA Accounting, Show Subinventory, Show Projects, Show WIP Job, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [wip_flow_schedules](https://www.enginatics.com/library/?pg=1&find=wip_flow_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)

## Related Reports
[CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20Material%20Account%20Summary/CAC%20ICP%20PII%20Material%20Account%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII Material Account Summary - Pivot by Org 16-Oct-2022 163618.xlsx](https://www.enginatics.com/example/cac-icp-pii-material-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary) |
| Blitz Report™ XML Import | [CAC_ICP_PII_Material_Account_Summary.xml](https://www.enginatics.com/xml/cac-icp-pii-material-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary) |
| SQL Source | [CAC ICP PII Material Account Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20Material%20Account%20Summary/CAC%20ICP%20PII%20Material%20Account%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-icp-pii-material-account-summary/](https://www.enginatics.com/reports/cac-icp-pii-material-account-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary) |

## Case Study & Technical Analysis: CAC ICP PII Material Account Summary

### Executive Summary
The **CAC ICP PII Material Account Summary** report is a high-level financial analysis tool designed to streamline the month-end elimination of **Profit in Inventory (PII)**. Unlike detailed transaction reports, this summary aggregates material accounting entries by General Ledger account, Organization, and Item. It provides a clear "Before and After" view: the original transaction amount, the calculated PII amount, and the resulting Net amount. This is essential for preparing manual journal entries or validating automated elimination processes.

### Business Challenge
Multinational corporations often transfer inventory between subsidiaries at a markup (transfer price). For consolidated financial reporting, this internal profit must be eliminated until the goods are sold to an external customer.
*   **Complexity:** Thousands of daily transactions make manual calculation impossible.
*   **Aggregation:** Finance needs to know the total PII movement per GL Account (e.g., "How much PII moved from 'In-Transit' to 'Inventory' this month?"), not the detail of every truckload.
*   **WIP Complications:** When items with PII are issued to Manufacturing (WIP), the profit is capitalized into the WIP asset. Tracking this flow is notoriously difficult.

### The Solution
This report acts as a "PII Subledger," summarizing the financial impact of profit movements.
*   **Three-Column Analysis:** For every account line, it displays:
    1.  **Transaction Amount:** The standard inventory value (including profit).
    2.  **PII Amount:** The calculated profit portion.
    3.  **Net Amount:** The true cost basis (excluding profit).
*   **Flexible Aggregation:** Users can summarize by Subinventory, Project, or WIP Job, depending on the granularity required for their elimination entries.
*   **WIP Intelligence:** It includes logic to detect "PII Zero Component Quantity" scenarios, warning users if a WIP Completion has PII calculated but the underlying components (which carry the PII) were not actually issued to the job.

### Technical Architecture (High Level)
The report leverages a similar architecture to the "Material Account Detail" report but adds a heavy aggregation layer.
*   **PII CTE:** Pre-calculates the PII unit cost per item/org using the specified `PII Cost Type` and `PII Sub-Element`.
*   **Aggregation Core:** The main query groups data by `GL_CODE_COMBINATIONS`, `ORGANIZATION_ID`, `INVENTORY_ITEM_ID`, and optional dimensions (Subinventory, Project, WIP).
*   **SLA Compatibility:** It dynamically switches between `MTL_TRANSACTION_ACCOUNTS` (Legacy) and `XLA_DISTRIBUTION_LINKS` (SLA) based on the `Show SLA Accounting` parameter, ensuring the summary matches the final GL balances.

### Parameters & Filtering
*   **PII Cost Type & Sub-Element:** Defines the specific cost element representing the intercompany profit.
*   **Show Subinventory / Projects / WIP:** These "Show" parameters control the `GROUP BY` clause, allowing the report to expand or collapse detail levels.
*   **Numeric Sign for PII:** A hidden parameter that handles the sign convention (positive or negative) used for PII in the cost type, ensuring the math works for both contra-asset and statistical setups.

### Performance & Optimization
*   **Pre-Aggregation:** By aggregating at the database level, the report reduces the number of rows returned to Excel from millions (transactions) to thousands (account summaries).
*   **Materialized View (Concept):** The logic effectively creates an on-the-fly materialized view of the PII movements, which is computationally intensive but optimized via the PII CTE and indexed date range scans.

### FAQ
**Q: How does the "PII Zero Component Quantity" logic work?**
A: For WIP Completions, the report checks if the components issued to the job actually had PII. If a job is completed (receiving PII) but no PII-bearing components were issued, the report flags this. This prevents "phantom profit" from being recognized in WIP when it's actually still sitting in Raw Materials.

**Q: Why do I see a "Net Amount" of zero for some lines?**
A: This usually happens for purely statistical transactions or if the PII amount equals the total transaction amount (which would be an error in cost setup).

**Q: Can I use this for "Flash" reporting?**
A: Yes. By running with `Show SLA Accounting = No`, you can get a near real-time view of PII movements before the Create Accounting process has run for the period.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-material-account-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
