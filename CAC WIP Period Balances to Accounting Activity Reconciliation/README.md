---
layout: default
title: 'CAC WIP Period Balances to Accounting Activity Reconciliation | Oracle EBS SQL Report'
description: 'Report to compare the monthly WIP Period Balances with the pre-Create Accounting WIP accounting entries for material, resource, overhead, outside…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, WIP, Period, Balances, wip_accounting_classes, mtl_system_items_vl, mtl_item_status_vl'
permalink: /CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/
---

# CAC WIP Period Balances to Accounting Activity Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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




## Report Parameters
Period Name, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [wip_flow_schedules](https://www.enginatics.com/library/?pg=1&find=wip_flow_schedules), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances), [mtl_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_accounts), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-wip-period-balances-to-accounting-activity-reconciliation/) |
| Blitz Report™ XML Import | [CAC_WIP_Period_Balances_to_Accounting_Activity_Reconciliation.xml](https://www.enginatics.com/xml/cac-wip-period-balances-to-accounting-activity-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/](https://www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
