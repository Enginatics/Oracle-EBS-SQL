---
layout: default
title: 'CAC WIP Account Summary | Oracle EBS SQL Report'
description: 'Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update. With the Show SLA Accounting parameter you…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, WIP, Account, Summary, wip_entities, wip_accounting_classes, mtl_system_items_vl'
permalink: /CAC%20WIP%20Account%20Summary/
---

# CAC WIP Account Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-account-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the report size, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes) and Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release).  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Note that both Flow and Workorderless show up as the WIP Type "Flow schedule".

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project number and name.  Enter Yes or No, use to limit the report size. (mandatory).
Show WIP Jobs:  display the WIP job, description, department and resource.  Enter Yes or No, use to limit the report size (mandatory).
Show WIP Outside Processing:  display the WIP OSP item number, supplier, purchase order, purchase order line and release.  Enter Yes or No, use to limit the report size (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Assembly Number:  enter the specific assembly number(s) you wish to report (optional).
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
-- |   1.13   11 Mar 2021 Douglas Volz   Added Flow Schedules and Workorderless WIP
-- |                                     and removed redundant joins and tables to 
-- |                                     improve performance.
-- |   1.14   22 Mar 2021 Douglas Volz   Add WIP Job parameter.
-- |   1.15   20 Dec 2021 Douglas Volz   Add WIP Department.
-- |   1.16   12 Aug 2022 Douglas Volz   Combine with WIP Account Summary No SLA report
-- |                                     and add Show WIP Job and Show WIP OSP parameters.
-- |   1.17   14 Aug 2022 Douglas Volz   Screen out zero job close variances for Flow Schedules.
-- |  1.18   22 Aug 2022 Douglas Volz    Improve performance with outer joins and streamline dynamic SQL.
-- |  1.19   26 Feb 2023 Douglas Volz    Fix to show job close variances.
-- |  1.20   20 Jun 2024 Douglas Volz    Remove tabs, reinstall missing parameters and org access controls.
-- +=============================================================================+*/





## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Projects, Show WIP Job, Show WIP Outside Processing, Category Set 1, Category Set 2, Category Set 3, Assembly Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [&project_tables](https://www.enginatics.com/library/?pg=1&find=&project_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Account Summary 17-Aug-2022 204307.xlsx](https://www.enginatics.com/example/cac-wip-account-summary/) |
| Blitz Report™ XML Import | [CAC_WIP_Account_Summary.xml](https://www.enginatics.com/xml/cac-wip-account-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-account-summary/](https://www.enginatics.com/reports/cac-wip-account-summary/) |


## Case Study & Technical Analysis: CAC WIP Account Summary

### Executive Summary
The **CAC WIP Account Summary** report is the primary tool for reconciling Work in Process (WIP) value. It provides a summarized view of all financial activity within the factory floor, bridging the gap between operational manufacturing transactions and the General Ledger.
This report is essential for:
1.  **WIP Reconciliation:** Validating that the WIP Valuation account balance in the GL matches the net activity of the shop floor.
2.  **Variance Analysis:** Identifying the sources of manufacturing variances (Material Usage, Resource Efficiency, etc.) at a high level before drilling down.
3.  **Cost Element Analysis:** Breaking down WIP costs into their components (Material, Labor, Overhead, OSP) to understand cost drivers.

### Business Challenge
WIP is often the most complex area of inventory accounting.
*   **High Volume:** A single job can have hundreds of material issues, resource charges, and overhead allocations.
*   **Multiple Sources:** Costs hit WIP from Inventory (Material Issues), Payroll/Timecards (Resource Transactions), Purchasing (OSP), and Cost Updates.
*   **Accounting Complexity:** Different transaction types (Issue, Completion, Scrap, Variance Close) trigger different accounting rules.
*   **SLA Impact:** As with other subledgers, Subledger Accounting (SLA) can transform the raw WIP accounting, making direct table queries inaccurate for GL reconciliation.

### The Solution
This report simplifies WIP accounting by aggregating transactions into meaningful buckets.
*   **Cost Element Breakdown:** Instead of just a total amount, it pivots the data to show columns for:
    *   **Material:** Raw materials issued to jobs.
    *   **Material Overhead:** Indirect costs associated with materials.
    *   **Resource:** Labor and machine time charged.
    *   **Outside Processing (OSP):** Services performed by external vendors.
    *   **Overhead:** Factory burden absorbed by the job.
*   **Dual-Mode Architecture:**
    *   **SLA Mode:** Joins to `XLA_DISTRIBUTION_LINKS` to show the final, transformed accounting entries.
    *   **Legacy Mode:** Queries `WIP_TRANSACTION_ACCOUNTS` directly for a faster, operational view.
*   **Flexible Granularity:**
    *   **Summary View:** By default, it groups by Account and Assembly, perfect for high-level reconciliation.
    *   **Detail View:** Users can enable "Show WIP Jobs" or "Show Projects" to drill down to specific work orders or project codes.

### Technical Architecture (High Level)
The query uses a dynamic `FROM` clause (likely hidden in the `&subledger_tab` variable) to switch between data sources.
*   **Core Data Source:**
    *   **Non-SLA:** `WIP_TRANSACTION_ACCOUNTS` (WTA) is the primary source. It links `WIP_TRANSACTIONS` to `GL_CODE_COMBINATIONS`.
    *   **SLA:** The query likely joins `WIP_TRANSACTIONS` -> `WIP_TRANSACTION_ACCOUNTS` -> `XLA_DISTRIBUTION_LINKS` -> `XLA_AE_LINES`.
*   **Pivot Logic:** The `SUM(DECODE(cost_element_id...))` logic pivots the vertical transaction rows into horizontal columns for each cost element. This makes the report much easier to read than a standard transaction register.
*   **WIP Type Handling:** It handles standard Discrete Jobs as well as Flow Schedules and Workorderless Completions, ensuring a complete picture of manufacturing activity.

### Parameters & Filtering
*   **Show SLA Accounting:** The critical switch for GL reconciliation.
*   **Show WIP Jobs:** Toggles job-level detail.
*   **Show Projects:** Toggles project-level detail.
*   **Show WIP Outside Processing:** Adds details about OSP vendors and POs.
*   **Transaction Date From/To:** Defines the accounting period.

### Performance & Optimization
*   **Aggregation:** The primary value of this report is its ability to aggregate millions of WIP transactions into a manageable number of GL summary lines.
*   **Dynamic SQL:** By only joining to `WIP_ENTITIES` or `PA_PROJECTS` when requested, the query avoids unnecessary overhead in summary mode.

### FAQ
**Q: Why do I see "Cost Update" transactions?**
A: If you change the standard cost of an item that is currently sitting in a WIP job, the system revalues the WIP balance. This "Cost Update" transaction ensures the job's value reflects the new standard.

**Q: How do I find the "Job Close Variance"?**
A: Look for the "WIP Variance" transaction type. When a job is closed, any remaining balance (difference between inputs and outputs) is written off to a variance account. This report summarizes those write-offs.

**Q: Does this report show "Repetitive Schedules"?**
A: The description notes that it covers Discrete, Flow, and Workorderless, but *not* Repetitive Schedules. Repetitive manufacturing uses a different accounting model in Oracle EBS.

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
