---
layout: default
last_modified_at: 2026-10-19
title: 'CAC WIP Jobs With Complete Status But Not Ready for Close | Oracle EBS SQL Report'
description: 'Report WIP jobs which have a status of "Complete" but exceed variance tolerances, have uncompleted assemblies, open material requirements, unearned OSP…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, WIP, Jobs, Complete, fnd_lookups, mfg_lookups, wip_requirement_operations'
permalink: /CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/
report_name: 'CAC WIP Jobs With Complete Status But Not Ready for Close'
report_web_name: cac-wip-jobs-with-complete-status-but-not-ready-for-close
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Jobs With Complete Status But Not Ready for Close – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-but-not-ready-for-close/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report WIP jobs which have a status of "Complete" but exceed variance tolerances, have uncompleted assemblies, open material requirements, unearned OSP (outside processing) charges or stuck transactions in interfaces.  When you include scrap quantities, any scrapped assemblies are counted with the completed units.  Note that for material requirements, expense items are ignored.

Parameters:
==========
Variance Amount Threshold:  absolute maximum WIP variance or current job balance that is allowed for jobs you wish to close (required).
Variance Percent Threshold:  absolute maximum WIP variance percentage that is allowed for jobs you wish to close.  Based on WIP Job Balance / WIP Costs In. (required).
Include Scrap Quantities:  include scrapped assemblies in completion and component material requirements, enter Yes to include scrapped assembly quantities, enter No to exclude (required).
Include Bulk Supply Items:  include bulk WIP supply types in the component requirements, enter Yes to include bulk quantity requirements, enter No to exclude (required).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Class Code:  enter the WIP class code to report (optional).
WIP Job:  enter the WIP Job to report (optional).
Assembly Number:  enter the specific assembly number(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2017 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- | 
-- |  Original Author: Douglas A. Volz
-- |
-- |  Version Modified on Modified  by  Description
-- |  ======= =========== ============= =========================================
-- |  1.0     16 MAR 2017 Douglas Volz  Initial Coding
-- |  1.1     19 MAR 2017 Douglas Volz  Added interface conditions for eligibility  and check for no applied OSP
-- |  1.3     27 MAR 2017 Douglas Volz  Fix "return more than one row" error for
-- |                                    correlated sub-query on OSP and add in check for purchase requisitions
-- |  1.4     27 APR 2017 Douglas Volz  Fix for cross-joining results
-- |  1.6     25 Oct 2017 Douglas Volz  Remove p_date_completed parameter, not needed
-- |  1.7     25 Jul 2018 Douglas Volz  Removed all categories except Inventory
-- |  1.8     25 Jul 2018 Douglas Volz  Removed all category values
-- |  1.9     11 Dec 2020 Douglas Volz  Now for Standard, Lot Based Standard and Non-Standard Asset Jobs.
-- |  1.10    26 Jan 2021 Douglas Volz  Check for unissued materials and WIP scrap controls.  And now
-- |                                    use multi-language tables or views.
-- |  1.11    11 Feb 2021 Douglas Volz  Added parameter to include scrap for requirements
-- |  1.12    05 Mar 2021 Douglas Volz  Added parameter to include bulk items for requirements.
-- |  1.13    12 Mar 2021 Douglas Volz  Add logic to ignore Phantom WIP Supply Types as these requirements are never issued.
-- |  1.14    15 Apr 2021 Douglas Volz  Added Date Released
-- |  1.15    10 Jul 2022 Douglas Volz  Added WIP Variance Percentage parameter.
-- |  1.16    21 Jan 2024 Douglas Volz  Bug fix for Pending Material and Pending Shop Floor
-- |                                    Move.  Remove tabs and add inventory access controls.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Variance Amount Threshold, Variance Percent Threshold, Include Scrap Quantities, Include Bulk Supply Items, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, WIP Job, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_parameters](https://www.enginatics.com/library/?pg=1&find=wip_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_cost_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_cost_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [rcv_transactions_interface](https://www.enginatics.com/library/?pg=1&find=rcv_transactions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [po_requisitions_interface](https://www.enginatics.com/library/?pg=1&find=po_requisitions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_transactions_interface](https://www.enginatics.com/library/?pg=1&find=mtl_transactions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_move_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_move_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_split_merge_transactions](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_sm_starting_jobs](https://www.enginatics.com/library/?pg=1&find=wsm_sm_starting_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_sm_resulting_jobs](https://www.enginatics.com/library/?pg=1&find=wsm_sm_resulting_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_split_merge_txn_interface](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_starting_jobs_interface](https://www.enginatics.com/library/?pg=1&find=wsm_starting_jobs_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_resulting_jobs_interface](https://www.enginatics.com/library/?pg=1&find=wsm_resulting_jobs_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_resulting_lots_interface](https://www.enginatics.com/library/?pg=1&find=wsm_resulting_lots_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_lot_split_merges_interface](https://www.enginatics.com/library/?pg=1&find=wsm_lot_split_merges_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wsm_lot_job_interface](https://www.enginatics.com/library/?pg=1&find=wsm_lot_job_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_period_balances](https://www.enginatics.com/library/?pg=1&find=wip_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)

## Related Reports
[CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Summary](/CAC%20ICP%20PII%20Material%20Account%20Summary/ "CAC ICP PII Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Jobs With Complete Status But Not Ready for Close 10-Jul-2022 163050.xlsx](https://www.enginatics.com/example/cac-wip-jobs-with-complete-status-but-not-ready-for-close/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close) |
| Blitz Report™ XML Import | [CAC_WIP_Jobs_With_Complete_Status_But_Not_Ready_for_Close.xml](https://www.enginatics.com/xml/cac-wip-jobs-with-complete-status-but-not-ready-for-close/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close) |
| SQL Source | [CAC WIP Jobs With Complete Status But Not Ready for Close.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-jobs-with-complete-status-but-not-ready-for-close/](https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-but-not-ready-for-close/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close) |

## Case Study & Technical Analysis: CAC WIP Jobs With Complete Status But Not Ready for Close

### Executive Summary
The **CAC WIP Jobs With Complete Status But Not Ready for Close** report is a "Pre-Close" validation tool. In Oracle WIP, changing a job status to "Closed" is irreversible and triggers final variance accounting. This report prevents premature closing by flagging jobs that have unresolved issues.

### Business Challenge
*   **Orphaned Costs**: If you close a job while a Purchase Order is still open (unbilled), the invoice variance might get stuck or go to a suspense account.
*   **Data Integrity**: Closing a job with unissued components means your inventory accuracy is wrong (the system thinks you used 0, but you physically used 10).
*   **Variance Spikes**: Closing a job with a huge variance (e.g., 500%) usually indicates a data entry error that should be fixed *before* closing.

### Solution
This report acts as a gatekeeper.
*   **Checks**:
    *   **Unissued Material**: Are there open requirements?
    *   **Pending Transactions**: Are there records stuck in the Open Interface?
    *   **Variance Tolerance**: Does the variance exceed the threshold (Amount or %)?
    *   **Open POs**: Are there unreceived OSP items?

### Technical Architecture
*   **Tables**: `wip_discrete_jobs`, `wip_requirement_operations`, `po_headers/lines`.
*   **Logic**: Complex set of `EXISTS` checks to validate all conditions.

### Parameters
*   **Variance Amount/Percent Threshold**: (Mandatory) Define what "Too big" means.
*   **Include Scrap**: (Mandatory) Whether to count scrap as "Complete".

### Performance
*   **Moderate**: Checks multiple sub-tables (Requirements, POs, Interfaces).

### FAQ
**Q: What should I do with the jobs on this report?**
A: Fix the issue (Issue the material, Receive the PO, Fix the interface error) *then* close the job.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-jobs-with-complete-status-but-not-ready-for-close)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
