---
layout: default
title: 'CAC WIP Account Detail | Oracle EBS SQL Report'
description: 'Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update. With the Show SLA Accounting parameter you…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, WIP, Account, Detail, bom_resources, mtl_units_of_measure_vl, wip_entities'
permalink: /CAC%20WIP%20Account%20Detail/
---

# CAC WIP Account Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-account-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes.  And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster.  With parameters to limit the number of report columns, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes), Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release) and Show Overheads to display or not display the overhead codes.  For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules).  Note that both Flow and Workorderless show up as the WIP Type "Flow schedule".  And WIP Standard Cost Update descriptions show up in the Transaction Reference column.

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Show SLA Accounting:  enter Yes to use the Subledger Accounting rules for your accounting information (mandatory).  If you choose No the report uses the pre-Create Accounting entries.
Show Projects:  display the project number and name.  Enter Yes or No, use to control the reported columns. (mandatory).
Show WIP Outside Processing:  display the WIP OSP item number, supplier, purchase order, purchase order line and release.  Enter Yes or No, use to control the reported columns (mandatory).
Show WIP Overheads:  display the earned WIP production overheads, including the Overhead Code and Resource Basis Amount.  Enter Yes or No, use to control the reported columns (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Accounting Line Type:  enter the accounting purpose or line type to report (optional).
WIP Transaction Type:  enter the transaction type to report (optional).
Minimum Absolute Amount:  enter the minimum debit or credit to report (optional).  To see all accounting entries, enter zero (0) and leave the other parameters blank.
Resource Code:  enter the resource codes to report (optional).
Department:  enter the routing department to report (optional).
Class Code:  enter the WIP class code to report (optional).
WIP Job or Flow Schedule:  enter the WIP Job or the Flow Schedule to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report (optional).
Assembly Number:  enter the assembly number(s) you wish to report (optional).
Operating Unit:  enter the operating unit(s) you wish to report (optional).
Ledger:  enter the ledger(s) you wish to report (optional).

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
-- +=============================================================================+*/

## Report Parameters
Transaction Date From, Transaction Date To, Show SLA Accounting, Show Projects, Show WIP Outside Processing, Show WIP Overheads, Category Set 1, Category Set 2, Category Set 3, Accounting Line Type, WIP Transaction Type, Minimum Absolute Amount, Resource Code, Department, Class Code, WIP Job or Flow Schedule, Organization Code, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [&project_tables](https://www.enginatics.com/library/?pg=1&find=&project_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Account Detail 08-Oct-2022 065519.xlsx](https://www.enginatics.com/example/cac-wip-account-detail/) |
| Blitz Report™ XML Import | [CAC_WIP_Account_Detail.xml](https://www.enginatics.com/xml/cac-wip-account-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-account-detail/](https://www.enginatics.com/reports/cac-wip-account-detail/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
