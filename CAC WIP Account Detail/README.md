---
layout: default
last_modified_at: 2026-10-26
title: 'CAC WIP Account Detail | Oracle EBS SQL Report'
description: 'Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update. With the Show SLA Accounting parameter you…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, WIP, Account, Detail, cst_cost_updates, mtl_parameters, wip_transaction_accounts'
permalink: /CAC%20WIP%20Account%20Detail/
report_name: 'CAC WIP Account Detail'
report_web_name: cac-wip-account-detail
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the number of report columns, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes), Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release) and Show Overheads to display or not display the overhead codes.  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Note that both Flow and Workorderless show up as the WIP Type "Flow schedule".  And WIP Standard Cost Update descriptions show up in the Transaction Reference column.

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
-- |  1.21   25 Jan 2024 Douglas Volz    Added Std Cost Update Description to Transaction Reference column.
-- |                     Andy Haack      Added organization security restriction by org_access_view oav.
-- |  1.22    24 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Projects, Show WIP Outside Processing, Show WIP Overheads, Category Set 1, Category Set 2, Category Set 3, Accounting Line Type, WIP Transaction Type, Minimum Absolute Amount, Resource Code, Department, Class Code, WIP Job or Flow Schedule, Organization Code, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [wip_transaction_accounts](https://www.enginatics.com/library/?pg=1&find=wip_transaction_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [wip_transactions](https://www.enginatics.com/library/?pg=1&find=wip_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [wip_flow_schedules](https://www.enginatics.com/library/?pg=1&find=wip_flow_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)

## Related Reports
[CAC WIP Period Balances to Accounting Activity Reconciliation](/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/ "CAC WIP Period Balances to Accounting Activity Reconciliation Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Account%20Detail/CAC%20WIP%20Account%20Detail.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Account Detail 08-Oct-2022 065519.xlsx](https://www.enginatics.com/example/cac-wip-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail) |
| Blitz Report™ XML Import | [CAC_WIP_Account_Detail.xml](https://www.enginatics.com/xml/cac-wip-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail) |
| SQL Source | [CAC WIP Account Detail.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Account%20Detail/CAC%20WIP%20Account%20Detail.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-account-detail/](https://www.enginatics.com/reports/cac-wip-account-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail) |

## Case Study & Technical Analysis: CAC WIP Account Detail

### Executive Summary
The **CAC WIP Account Detail** report is the forensic tool for Work in Process (WIP) accounting. It provides a line-by-line listing of every accounting entry generated by WIP transactions. This level of detail is required to diagnose complex variance issues or reconcile specific job costs.

### Business Challenge
*   **Variance Investigation**: "Job X has a $5,000 material usage variance. Which specific component caused it?"
*   **SLA Auditing**: "Did the Subledger Accounting rules correctly re-direct the labor absorption to the new cost center?"
*   **Project Manufacturing**: Tracing costs for a specific Project/Task through the manufacturing process.

### Solution
This report exposes the subledger.
*   **Granularity**: One row per accounting line (Debit/Credit).
*   **Context**: Includes Job Name, Transaction Type (e.g., "WIP Component Issue"), Resource Code, and Overhead Code.
*   **SLA Support**: Can toggle between the raw WIP transaction accounts and the final SLA-generated accounts.

### Technical Architecture
*   **Tables**: `wip_transaction_accounts` (Pre-SLA), `xla_ae_lines` (Post-SLA), `wip_entities`.
*   **Logic**: Joins the accounting lines back to the operational tables (`bom_resources`, `mtl_system_items`) for readable descriptions.

### Parameters
*   **Show SLA Accounting**: (Mandatory) "Yes" for GL matching.
*   **Transaction Date From/To**: (Mandatory) Period to analyze.
*   **WIP Job**: (Optional) Filter for a specific problem job.

### Performance
*   **Heavy**: WIP generates high transaction volumes. Always filter by Date and preferably Organization.

### FAQ
**Q: Does this show "WIP Value"?**
A: No, this shows the *Activity* (Flow) during the period. For the *Balance* (Stock), use the "WIP Account Value" report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-account-detail)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
