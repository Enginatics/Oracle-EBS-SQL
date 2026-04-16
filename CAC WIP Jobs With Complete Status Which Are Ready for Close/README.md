---
layout: default
title: 'CAC WIP Jobs With Complete Status Which Are Ready for Close | Oracle EBS SQL Report'
description: 'Report WIP jobs which have a status of "Complete", do not exceed variance tolerances, have completed or exceeded the WIP start quantity, with no open…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, WIP, Jobs, Complete, fnd_lookups, mfg_lookups, wip_requirement_operations'
permalink: /CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/
---

# CAC WIP Jobs With Complete Status Which Are Ready for Close – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-which-are-ready-for-close/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report WIP jobs which have a status of "Complete", do not exceed variance tolerances, have completed or exceeded the WIP start quantity, with no open material requirements, no unearned OSP (outside processing) charges and no stuck transactions in interfaces.  When you include scrap quantities, any scrapped assemblies are counted with the completed units.  Note that for material requirements, expense items are ignored.

Parameters:
==========
Variance Amount Threshold:  maximum absolute WIP variance or current job balance that is allowed for jobs you wish to close (required).
Variance Percent Threshold: maximum absolute WIP variance percentage that is allowed for jobs you wish to close.  Based on WIP Job Balance / WIP Costs In. (required).
Include Scrap Quantities:  include scrapped assemblies in completion and component material requirements (required).
Include Bulk Supply Items:  include bulk WIP supply types in the component requirements (required).
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
-- |  1.1     19 MAR 2017 Douglas Volz  Added interface conditions for eligibility
-- |                                    and check for no applied OSP
-- |  1.3     27 MAR 2017 Douglas Volz  Fix "return more than one row" error for
-- |                                    correlated sub-query on OSP and add in check for purchase requisitions
-- |  1.4     27 APR 2017 Douglas Volz  Fix for cross-joining results
-- |  1.6     25 Oct 2017 Douglas Volz  Remove p_date_completed parameter, not needed
-- |  1.7     25 Jul 2018 Douglas Volz  Removed all categories except Inventory
-- |  1.8     25 Jul 2018 Douglas Volz  Removed all category values
-- |  1.9     11 Dec 2020 Douglas Volz  Now for Standard, Lot Based Standard and Non-
-- |                                    Standard Asset Jobs.  Added another category.
-- |  1.10    26 Jan 2021 Douglas Volz  Check for unissued materials and WIP scrap controls
-- |  1.11    11 Feb 2021 Douglas Volz  Added parameter to include scrap for requirements
-- |  1.12    05 Mar 2021 Douglas Volz  Added parameter to include bulk items for requirements.
-- |  1.13    12 Mar 2021 Douglas Volz  Add logic to ignore Phantom WIP Supply Types as
-- |                                    these requirements are never issued.
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
| Excel Example Output | [CAC WIP Jobs With Complete Status Which Are Ready for Close 10-Jul-2022 155448.xlsx](https://www.enginatics.com/example/cac-wip-jobs-with-complete-status-which-are-ready-for-close/) |
| Blitz Report™ XML Import | [CAC_WIP_Jobs_With_Complete_Status_Which_Are_Ready_for_Close.xml](https://www.enginatics.com/xml/cac-wip-jobs-with-complete-status-which-are-ready-for-close/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-jobs-with-complete-status-which-are-ready-for-close/](https://www.enginatics.com/reports/cac-wip-jobs-with-complete-status-which-are-ready-for-close/) |

## Executive Summary
This report identifies Work in Process (WIP) jobs that have a status of "Complete" and meet all the necessary criteria to be safely closed. It validates that the jobs are within specified variance tolerances, have no open material requirements, no unearned Outside Processing (OSP) charges, and no stuck transactions in the open interfaces. This tool is essential for the period-end close process, allowing the Cost Accounting team to confidently bulk-close jobs that have passed all validation checks, thereby recognizing variances and keeping the WIP valuation clean.

## Business Challenge
Closing WIP jobs is a critical step in the manufacturing accounting cycle. When a job is closed, the system calculates the final variances (difference between costs incurred and costs relieved) and posts them to the General Ledger. However, closing a job prematurely—before all transactions are processed or if there are significant unexplained variances—can lead to:
*   **Financial Inaccuracy**: Large, uninvestigated variances hitting the P&L unexpectedly.
*   **Data Integrity Issues**: "Stuck" transactions (e.g., uncosted material moves) that can no longer be processed against a closed job.
*   **Operational Friction**: The need to reopen jobs (if even possible) to fix errors, or perform manual journal entries to correct accounting.

Identifying which of the thousands of "Complete" jobs are actually *ready* to be closed requires checking multiple conditions across different tables (interfaces, material requirements, OSP status), which is manually impossible.

## Solution
The **CAC WIP Jobs With Complete Status Which Are Ready for Close** report automates this validation logic. It acts as a "green light" report, listing only those jobs that have passed a battery of integrity checks and are within acceptable variance thresholds.

**Key Validation Checks:**
*   **Status Check**: Job status must be 'Complete'.
*   **Variance Thresholds**: Total variance amount and percentage must be within user-defined limits (e.g., < $100 or < 5%).
*   **Operational Completeness**: Quantity completed must meet or exceed the start quantity (unless scrap is involved).
*   **Pending Transactions**: No records in `WIP_MOVE_TXN_INTERFACE`, `WIP_COST_TXN_INTERFACE`, or `MTL_TRANSACTIONS_INTERFACE`.
*   **Material Requirements**: No open material requirements (all required components issued).
*   **Outside Processing**: No unearned OSP charges (PO received and matched).

## Architecture
The report queries the `WIP_DISCRETE_JOBS` table as the primary source, joining with `WIP_PERIOD_BALANCES` to calculate current costs incurred and relieved. It uses `NOT EXISTS` subqueries to ensure no pending transactions exist in the interface tables.

**Key Tables:**
*   `WIP_DISCRETE_JOBS`: Job header information (status, quantities).
*   `WIP_PERIOD_BALANCES`: Source for calculating the net value (Costs In - Costs Out) of the job.
*   `WIP_REQUIREMENT_OPERATIONS`: To check for open material requirements.
*   `WIP_MOVE_TXN_INTERFACE`, `WIP_COST_TXN_INTERFACE`, `MTL_TRANSACTIONS_INTERFACE`: To check for stuck transactions.
*   `PO_REQUISITIONS_INTERFACE`: To check for pending OSP requisitions.

## Impact
*   **Accelerated Period Close**: Allows for the rapid, confident closing of the majority of completed jobs.
*   **Risk Mitigation**: Prevents the closure of jobs with unresolved errors or significant variances that require investigation.
*   **Process Efficiency**: Separates "clean" jobs from "problem" jobs, allowing analysts to focus their time on the exceptions (using the companion "Not Ready for Close" report).


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
