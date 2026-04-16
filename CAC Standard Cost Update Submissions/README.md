---
layout: default
title: 'CAC Standard Cost Update Submissions | Oracle EBS SQL Report'
description: 'Report to show the Standard Cost Update submissions, by Cost Update Date. Including the parameters used and the overall inventory and WIP adjustment…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Standard, Cost, Update, mtl_category_sets_vl, mtl_categories_v, cst_cost_updates'
permalink: /CAC%20Standard%20Cost%20Update%20Submissions/
---

# CAC Standard Cost Update Submissions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-standard-cost-update-submissions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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



## Report Parameters
Cost Update Date From, Cost Update Date To, From Cost Type, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-standard-cost-update-submissions/) |
| Blitz Report™ XML Import | [CAC_Standard_Cost_Update_Submissions.xml](https://www.enginatics.com/xml/cac-standard-cost-update-submissions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-standard-cost-update-submissions/](https://www.enginatics.com/reports/cac-standard-cost-update-submissions/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
