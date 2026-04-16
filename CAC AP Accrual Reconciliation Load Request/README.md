---
layout: default
title: 'CAC AP Accrual Reconciliation Load Request | Oracle EBS SQL Report'
description: 'Report to show when the A/P Accrual Reconciliation Load program was run and by whom, including the Ledger, Operating Unit, Build Id, Request Id, Creation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Accrual, Reconciliation, Load, cst_reconciliation_build, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20AP%20Accrual%20Reconciliation%20Load%20Request/
---

# CAC AP Accrual Reconciliation Load Request – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-load-request/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show when the A/P Accrual Reconciliation Load program was run and by whom, including the Ledger, Operating Unit, Build Id, Request Id, Creation Date and Last Updated By.

Parameters:
===========
Beginning Creation Date:  enter the starting creation date to report, based on the operating unit for your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2019 - 2025 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     31 Oct 2019 Douglas Volz   Initial Coding
-- |  1.1     28 Jan 2025 Douglas Volz   Added creation date parameter
-- |  1.2     15 Feb 2025 Douglas Volz   Added Operating Unit and Ledger Security
-- |                                     Profile Controls and parameters.
-- +=============================================================================+*/

## Report Parameters
Beginning Creation Date, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_reconciliation_build](https://www.enginatics.com/library/?pg=1&find=cst_reconciliation_build), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC AP Accrual Reconciliation Summary by Match Type](/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/ "CAC AP Accrual Reconciliation Summary by Match Type Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC AP Accrual Accounts Setup](/CAC%20AP%20Accrual%20Accounts%20Setup/ "CAC AP Accrual Accounts Setup Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-ap-accrual-reconciliation-load-request/) |
| Blitz Report™ XML Import | [CAC_AP_Accrual_Reconciliation_Load_Request.xml](https://www.enginatics.com/xml/cac-ap-accrual-reconciliation-load-request/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-ap-accrual-reconciliation-load-request/](https://www.enginatics.com/reports/cac-ap-accrual-reconciliation-load-request/) |

## Case Study & Technical Analysis: CAC AP Accrual Reconciliation Load Request

### Executive Summary
The **CAC AP Accrual Reconciliation Load Request** report is an audit and diagnostic tool designed for Cost Accountants and Finance Managers. It tracks the execution history of the "Accrual Reconciliation Load Run" program, which is a prerequisite for reconciling the Accounts Payable (AP) accrual accounts. By providing visibility into *when* the load was run, *who* ran it, and for *which* operating units, this report helps ensure that the accrual data is up-to-date before month-end reconciliation activities begin.

### Business Challenge
The AP Accrual Reconciliation process in Oracle EBS relies on a concurrent program to populate the reconciliation tables (`CST_RECONCILIATION_BUILD`). Organizations often face challenges such as:
*   **Stale Data:** Users attempting to reconcile accounts using outdated data because the load program hasn't been run recently.
*   **Process Visibility:** Uncertainty about whether the load program was successfully executed for a specific Operating Unit or Ledger.
*   **Audit Compliance:** Lack of a clear audit trail showing who triggered the data refresh and when, which is critical for financial controls.

### The Solution
The **CAC AP Accrual Reconciliation Load Request** report solves these issues by providing a clear history of the load program's execution. It enables users to:
*   **Verify Data Freshness:** Confirm the "Run To Date" to ensure the reconciliation data includes the latest transactions.
*   **Monitor Schedule Compliance:** Check if the load program is being run according to the month-end close schedule.
*   **Identify Process Owners:** See exactly which user (`Created_By`) initiated the request, facilitating accountability and communication.

### Technical Architecture (High Level)
The report queries the specific build history table used by the Cost Management module.
*   **Core Table:** `CST_RECONCILIATION_BUILD` stores the history of each load request, including the build ID and date ranges.
*   **Context:** `HR_ALL_ORGANIZATION_UNITS_VL` and `GL_LEDGERS` provide the organizational context, linking the technical build ID to business units.
*   **Security:** The report incorporates robust security logic, respecting both Ledger Security (via `GL_ACCESS_SET_NORM_ASSIGN`) and Operating Unit Security (via `MO_GLOB_ORG_ACCESS_TMP`), ensuring users only see history for entities they are authorized to access.

### Parameters & Filtering
The report supports the following parameters:
*   **Beginning Creation Date:** Filters the history to show only load requests created on or after a specific date, useful for focusing on the current period.
*   **Operating Unit:** Allows filtering by specific operating units to audit a particular entity.
*   **Ledger:** Enables filtering by the general ledger to see all related operating units.

### Performance & Optimization
The report is designed for high performance:
*   **Direct Table Access:** It queries the build history table directly rather than calculating accruals, making it instantaneous.
*   **Efficient Joins:** Uses standard foreign key joins between the build table, organization definitions, and user tables.
*   **Security Profiles:** The security clauses are optimized to use standard Oracle temporary tables and profile options, ensuring consistent performance even in complex multi-org environments.

### FAQ
**Q: What is the "Build ID"?**
A: The Build ID is a unique system-generated identifier for each execution of the Accrual Load program. It links the request to the specific set of data populated in the reconciliation tables.

**Q: Why is the "Run To Date" important?**
A: The "Run To Date" indicates the cutoff date for transactions included in that specific load. If you are reconciling for January, you need to ensure the load was run with a "Run To Date" of at least Jan 31st.

**Q: Does this report show the actual accrual balance?**
A: No, this is a metadata report about the *process* of loading data. To see the actual balances and transactions, you would use reports like "CST AP and PO Accrual Reconciliation".


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
