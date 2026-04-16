---
layout: default
title: 'CAC WIP Jobs With Complete Status But Not Ready for Close | Oracle EBS SQL Report'
description: 'Report WIP jobs which have a status of "Complete" but exceed variance tolerances, have uncompleted assemblies, open material requirements, unearned OSP…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, WIP, Jobs, Complete, fnd_lookups, mfg_lookups, wip_requirement_operations'
permalink: /CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/
---

# CAC WIP Jobs With Complete Status But Not Ready for Close – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-but-not-ready-for-close/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Variance Amount Threshold, Variance Percent Threshold, Include Scrap Quantities, Include Bulk Supply Items, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, WIP Job, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b), [wip_parameters](https://www.enginatics.com/library/?pg=1&find=wip_parameters), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [wip_cost_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_cost_txn_interface), [rcv_transactions_interface](https://www.enginatics.com/library/?pg=1&find=rcv_transactions_interface), [po_requisitions_interface](https://www.enginatics.com/library/?pg=1&find=po_requisitions_interface), [mtl_transactions_interface](https://www.enginatics.com/library/?pg=1&find=mtl_transactions_interface), [wip_move_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_move_txn_interface), [wsm_split_merge_transactions](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_transactions), [wsm_sm_starting_jobs](https://www.enginatics.com/library/?pg=1&find=wsm_sm_starting_jobs), [wsm_sm_resulting_jobs](https://www.enginatics.com/library/?pg=1&find=wsm_sm_resulting_jobs), [wsm_split_merge_txn_interface](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_txn_interface), [wsm_starting_jobs_interface](https://www.enginatics.com/library/?pg=1&find=wsm_starting_jobs_interface), [wsm_resulting_jobs_interface](https://www.enginatics.com/library/?pg=1&find=wsm_resulting_jobs_interface), [wsm_resulting_lots_interface](https://www.enginatics.com/library/?pg=1&find=wsm_resulting_lots_interface), [wsm_lot_split_merges_interface](https://www.enginatics.com/library/?pg=1&find=wsm_lot_split_merges_interface)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Jobs With Complete Status But Not Ready for Close 10-Jul-2022 163050.xlsx](https://www.enginatics.com/example/cac-wip-jobs-with-complete-status-but-not-ready-for-close/) |
| Blitz Report™ XML Import | [CAC_WIP_Jobs_With_Complete_Status_But_Not_Ready_for_Close.xml](https://www.enginatics.com/xml/cac-wip-jobs-with-complete-status-but-not-ready-for-close/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-jobs-with-complete-status-but-not-ready-for-close/](https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-but-not-ready-for-close/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
