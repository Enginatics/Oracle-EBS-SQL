---
layout: default
last_modified_at: 2026-10-16
title: 'CAC WIP Account Value | Oracle EBS SQL Report'
description: 'Report to show WIP values and all accounts for discrete manufacturing, in summary by inventory, organization, with WIP class, job status, name and other…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, WIP, Account, Value, mtl_parameters, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20WIP%20Account%20Value/
report_name: 'CAC WIP Account Value'
report_web_name: cac-wip-account-value
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Account Value – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show WIP values and all accounts for discrete manufacturing, in summary by inventory, organization, with WIP class, job status, name and other details.  This report uses the valuation accounts from each discrete job and reports both jobs which were open during the accounting period as well as jobs closed during the accounting period.  You can also run this report for earlier accounting periods and still get the correct amounts and the jobs that were open at that time.

Parameters
==========
Period Name:  the accounting period you wish to report (mandatory).
Include Expense WIP:  enter Yes to include Expense WIP jobs.  Defaults to No.
Job Status:  enter a specific job status (optional).
Category Sets 1 - 3:  any item category you wish (optional).
Item Number:  specific item you wish to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     29 Oct 2009 Douglas Volz   Based on XXX_WIP_VALUE_REPT.sql
-- |  1.13    22 May 2017 Douglas Volz   Added cost item category
-- |  1.14    10 Jul 2017 Douglas Volz   Added column to indicate a WIP job was converted
-- |                                     from the Legacy Systems
-- |  1.15    26 Jul 2018 Douglas Volz   Modified for chart of accounts and for categories
-- |  1.16    04 Dec 2018 Douglas Volz   Modified for chart of accounts and removed converted 
-- |                                     job column. Fixed outer join for completion subinventories
-- |  1.17    19 Jun 2019 Douglas Volz   Changed to G/L short name, for brevity, added
-- |                                     inventory category.  Added Date Released column.
-- |  1.17    19 Jun 2019 Douglas Volz   Changed to G/L short name, for brevity, added
-- |                                     inventory category.  Added Date Released column.
-- |  1.18    24 Oct 2019 Douglas Volz   Added aging dates, creation date and date released columns
-- |  1.19    06 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.20    24 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, item categories and operating units.
-- |                                     And put the WIP Costs In, WIP Costs Out, WIP
-- |                                     Relief and WIP Value as the last report columns.
-- |                                     Add Project Number and Project Name columns.
-- |  1.21    17 Aug 2020 Douglas Volz   Change categories to use category_concat_segs not segment1
-- |  1.22    09 Oct 2020 Douglas Volz   Added unit of measure column
-- |  1.23    13 Mar 2022 Douglas Volz   Added WIP job description column.
-- |  1.24    27 Feb 2025 Douglas Volz   Removed tabs, fixed OU and GL security profiles.
-- |  1.25    17 Mar 2025 Douglas Volz   WIP performance improvements.
-- |  1.26    31 Aug 2025 Douglas Volz  Added Job Status parameter.
+=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Include Expense WIP, Job Status, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)

## Related Reports
[CAC WIP Period Balances to Accounting Activity Reconciliation](/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/ "CAC WIP Period Balances to Accounting Activity Reconciliation Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Account%20Value/CAC%20WIP%20Account%20Value.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Account Value 10-Jul-2022 131938.xlsx](https://www.enginatics.com/example/cac-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value) |
| Blitz Report™ XML Import | [CAC_WIP_Account_Value.xml](https://www.enginatics.com/xml/cac-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value) |
| SQL Source | [CAC WIP Account Value.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Account%20Value/CAC%20WIP%20Account%20Value.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-account-value/](https://www.enginatics.com/reports/cac-wip-account-value/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value) |

## Case Study & Technical Analysis: CAC WIP Account Value

### Executive Summary
The **CAC WIP Account Value** report is the standard "WIP Inventory Value" report. It calculates the value of Work in Process as of a specific period end. This value represents the "Asset" on the balance sheet—materials issued, labor charged, and overheads absorbed, minus any completions or scrap.

### Business Challenge
*   **Balance Sheet Validation**: The Controller needs a detailed list of jobs that make up the $10M "WIP Inventory" asset.
*   **Aging**: "Why is this job from 2019 still open and carrying value?" (Stale WIP).
*   **Costing Method**: Works for both Standard (Variance based) and Average (Actual Cost based) costing.

### Solution
This report calculates the balance.
*   **Formula**: `Costs In (Material + Resource + Overhead) - Costs Out (Completion + Scrap) = Ending Balance`.
*   **Status**: Shows if the job is Open, Complete, or Closed (if run for a prior period).
*   **Breakdown**: Columns for Material, Labor, Overhead, OSP, etc.

### Technical Architecture
*   **Tables**: `wip_period_balances`, `wip_discrete_jobs`.
*   **Logic**: Uses the snapshot table `wip_period_balances` which stores the value at the end of each period.

### Parameters
*   **Period Name**: (Mandatory) The target period.
*   **Include Expense WIP**: (Optional) Toggle to show non-asset jobs (e.g., Maintenance).

### Performance
*   **Fast**: Queries summary tables rather than summing individual transactions.

### FAQ
**Q: Why is my WIP value negative?**
A: Usually timing. You completed the assembly (Credit) *before* you issued the components (Debit). This is a process error called "Negative WIP".

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-value)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
