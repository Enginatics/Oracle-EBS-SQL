---
layout: default
last_modified_at: 2026-10-16
title: 'CAC WIP Period Balances to Accounting Activity Reconciliation | Oracle EBS SQL Report'
description: 'Report to compare the monthly WIP Period Balances with the pre-Create Accounting WIP accounting entries for material, resource, overhead, outside…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, WIP, Period, Balances, wip_accounting_classes, mtl_system_items_vl, mtl_item_status_vl'
permalink: /CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/
report_name: 'CAC WIP Period Balances to Accounting Activity Reconciliation'
report_web_name: cac-wip-period-balances-to-accounting-activity-reconciliation
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Period Balances to Accounting Activity Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to compare the monthly WIP Period Balances with the pre-Create Accounting WIP accounting entries for material, resource, overhead, outside processing, job close variance and standard cost update transactions.  With WIP class, job status, name and other details.  This report shows both WIP jobs which were open during the accounting period as well as jobs closed during the accounting period.  If the stored WIP period balances agree to the period WIP accounting activity, the "Difference" columns have a zero amount.

//* +=============================================================================+
-- | Copyright 2022 Douglas Volz Consulting, Inc.                                |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_reconcile_wip_balances.sql
-- |
-- |  Parameters:
-- |  p_period_name          -- The desired accounting period you wish to report
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- | Description:
-- | Report to compare the monthly WIP transactions against the WIP period balances.
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     07 Apr 2021 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.1     10 Jul 2022 Douglas Volz   Add Ledger and Operating Unit columns
-- | 1.2     19 Oct 2022 Douglas Volz   Bug fix for missing organization join
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [wip_flow_schedules](https://www.enginatics.com/library/?pg=1&find=wip_flow_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [cst_std_cost_adj_values](https://www.enginatics.com/library/?pg=1&find=cst_std_cost_adj_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)

## Related Reports
[CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status But Not Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status But Not Ready for Close Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-wip-period-balances-to-accounting-activity-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation) |
| Blitz Report™ XML Import | [CAC_WIP_Period_Balances_to_Accounting_Activity_Reconciliation.xml](https://www.enginatics.com/xml/cac-wip-period-balances-to-accounting-activity-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation) |
| SQL Source | [CAC WIP Period Balances to Accounting Activity Reconciliation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/](https://www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation) |

## Executive Summary
The **CAC WIP Period Balances to Accounting Activity Reconciliation** report is a forensic accounting tool designed to reconcile the Work in Process (WIP) subledger. It compares the stored WIP Period Balances (the snapshot of WIP value) against the detailed accounting activity (the actual debits and credits) for the period. Ideally, the net activity for the period should exactly match the change in the period balance. Any difference indicates a data corruption or a system bug, making this report essential for ensuring the integrity of the WIP subledger.

## Business Challenge
The WIP subledger is complex, with value flowing in from multiple sources (Material Issues, Resource Transactions, Overheads) and flowing out via Completions and Scrap.
*   **Subledger Integrity**: Sometimes, due to data corruption or patching issues, the summary table (`WIP_PERIOD_BALANCES`) gets out of sync with the detailed transaction tables (`WIP_TRANSACTION_ACCOUNTS`).
*   **Reconciliation**: If the subledger summary doesn't match the detailed accounting entries, the General Ledger balance (which comes from the accounting entries) will not match the WIP Valuation report (which often uses the balances).
*   **Audit Compliance**: Auditors require proof that the subsidiary ledger balances are mathematically correct and supported by transactions.

## Solution
This report performs a three-way match logic (conceptually) to ensure that:
`Beginning Balance + Net Activity = Ending Balance`
It specifically compares the `WIP_PERIOD_BALANCES` for the period against the sum of `WIP_TRANSACTION_ACCOUNTS` (and related tables) for the same period.

**Key Features:**
*   **Difference Detection**: Calculates a "Difference" column. In a healthy system, this should be zero.
*   **Transaction Type Breakdown**: Analyzes activity by type: Material, Resource, Overhead, OSP, Job Close Variance, and Cost Updates.
*   **Job Level Granularity**: Performs the reconciliation at the individual WIP Job level, allowing for precise identification of problem records.

## Architecture
The query aggregates data from the transaction accounting tables and compares it to the period balance table.

**Key Tables:**
*   `WIP_PERIOD_BALANCES`: The summary table holding the value of WIP at the start and end of periods.
*   `WIP_TRANSACTION_ACCOUNTS`: The accounting lines for resource and overhead transactions.
*   `MTL_TRANSACTION_ACCOUNTS`: The accounting lines for material transactions.
*   `WIP_DISCRETE_JOBS`: Job header details.

## Impact
*   **Data Health Monitoring**: Acts as an early warning system for data corruption in the WIP module.
*   **Audit Readiness**: Provides the detailed reconciliation evidence required for financial audits.
*   **Troubleshooting**: Pinpoints exactly which job and which transaction type is causing a balancing issue, significantly reducing the time required to resolve variances.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-period-balances-to-accounting-activity-reconciliation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
