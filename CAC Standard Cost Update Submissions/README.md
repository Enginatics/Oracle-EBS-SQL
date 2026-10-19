---
layout: default
last_modified_at: 2026-10-19
title: 'CAC Standard Cost Update Submissions | Oracle EBS SQL Report'
description: 'Report to show the Standard Cost Update submissions, by Cost Update Date. Including the parameters used and the overall inventory and WIP adjustment…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Standard, Cost, Update, mtl_category_sets_vl, mtl_categories_v, cst_cost_updates'
permalink: /CAC%20Standard%20Cost%20Update%20Submissions/
report_name: 'CAC Standard Cost Update Submissions'
report_web_name: cac-standard-cost-update-submissions
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Standard Cost Update Submissions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-standard-cost-update-submissions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show the Standard Cost Update submissions, by Cost Update Date.  Including the parameters used and the overall inventory and WIP adjustment values.

Parameters:
Cost Update Date From:  starting cost update date, based on standard cost submission history (required).
Cost Update Date To: ending cost update date, based on standard cost submission history (required).
From Cost Type:  enter the cost type implemented by the Standard Cost Update into the Frozen costs (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_cost_update_submissions_rept.sql
-- | 
-- | Version Modified on Modified by    Description
-- | ======= =========== ============== =========================================
-- |  1.0    28 Sep 2023 Douglas Volz   Initial coding
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Update Date From, Cost Update Date To, From Cost Type, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Standard%20Cost%20Update%20Submissions/CAC%20Standard%20Cost%20Update%20Submissions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/cac-standard-cost-update-submissions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions) |
| Blitz Report™ XML Import | [CAC_Standard_Cost_Update_Submissions.xml](https://www.enginatics.com/xml/cac-standard-cost-update-submissions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions) |
| SQL Source | [CAC Standard Cost Update Submissions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Standard%20Cost%20Update%20Submissions/CAC%20Standard%20Cost%20Update%20Submissions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-standard-cost-update-submissions/](https://www.enginatics.com/reports/cac-standard-cost-update-submissions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions) |

## Case Study & Technical Analysis: CAC Standard Cost Update Submissions

### Executive Summary
The **CAC Standard Cost Update Submissions** report is an audit trail for the Standard Costing process. It tracks the execution of the "Update Standard Cost" program, providing a history of *when* costs were updated, *who* ran the update, and *what* the financial impact was.

### Business Challenge
*   **Audit Compliance**: Auditors need to see evidence that cost updates were authorized and executed correctly.
*   **Impact Analysis**: "We took a $1M hit to inventory value last month. Which update caused it?"
*   **Troubleshooting**: "Did we update the costs for the 'Spare Parts' category yet?"

### Solution
This report queries the cost update history.
*   **Header Info**: Update Date, Description, User.
*   **Scope**: Shows which Item Range, Category, or Cost Type was used.
*   **Values**: Shows the total Inventory Adjustment and WIP Adjustment values generated by the update.

### Technical Architecture
*   **Tables**: `cst_cost_updates`, `cst_cost_types`.
*   **Logic**: The `cst_cost_updates` table stores the header information for every run of the Standard Cost Update program.

### Parameters
*   **Cost Update Date From/To**: (Mandatory) The period to audit.

### Performance
*   **Fast**: There are relatively few cost updates in a year.

### FAQ
**Q: Does this show the specific items updated?**
A: No, this is a *Header* level report. For item details, you would use the "Standard Cost Update Adjustment" report (standard Oracle).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-standard-cost-update-submissions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
