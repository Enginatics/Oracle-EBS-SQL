---
layout: default
title: 'CAC Inventory Periods Not Closed or Summarized | Oracle EBS SQL Report'
description: 'Report to find all inventory accounting periods which are either still open or closed but not summarized. When you close the inventory accounting period…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inventory, Periods, Not, hrfv_organization_hierarchies, org_acct_periods, mtl_parameters'
permalink: /CAC%20Inventory%20Periods%20Not%20Closed%20or%20Summarized/
---

# CAC Inventory Periods Not Closed or Summarized – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-periods-not-closed-or-summarized/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to find all inventory accounting periods which are either still open or closed but not summarized.  When you close the inventory accounting period, the Period Close Reconciliation Report creates a very useful month-end summary of your inventory quantities and balances, by item, subinventory or intransit, cost group and inventory organization.  You can use this information to create a efficient month-end inventory value report.
Note:  this report automatically looks for hierarchies which might be used with the Open Period Control and the Close Period Control Oracle programs.  Looking for the translated values of "Close", "Open" and "Period" in the Hierarchy Name.

/* +=============================================================================+
-- | Copyright 2018 - 2020 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_inv_periods_not_closed_rept.sql
-- |
-- |  Parameters:
-- |  p_org_hierarchy_name   -- select the organization hierarchy used to open and
-- |                            close your inventory organizations (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |
-- |  Description:
-- |  Report to find all inventory accounting periods which are either still open,
-- |  or closed but not summarized.  When you close the inventory accounting period,
-- |  the Period Close Reconciliation Report creates a very useful month-end
-- |  summary of your inventory quantities and balances, by item, subinventory or
-- |  intransit, cost group and inventory organization.  You can use this 
-- |  information to create a efficient month-end inventory value report.
-- | 
-- |  History for xxx_inv_periods_not_closed_rept.sql
-- |
-- |  Version Modified on Modified  by    Description
-- |  ======= =========== =============== =========================================
-- |  1.0     06 Dec 2018 Douglas Volz    Report created based on Period Status Report
-- |  1.1     09 Feb 2020 Douglas Volz    Added Org, Ledger and Operating Unit parameters
-- |  1.2     08 Mar 2020 Douglas Volz    Improvements to finding the Hierarchy Name,
-- |                                      looking for the words Open, Close or Period.
-- |  1.3     27 Apr 2020 Douglas Volz    Changed to multi-language views for the
-- |                                      inventory orgs and operating units.
-- |  1.4     16 Aug 2020 Douglas Volz    Fix for revision 1.2 for Organization Hierarchy.
-- +=============================================================================+*/


## Report Parameters
Hierarchy Name, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[hrfv_organization_hierarchies](https://www.enginatics.com/library/?pg=1&find=hrfv_organization_hierarchies), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Periods Not Closed or Summarized 23-Jun-2022 162437.xlsx](https://www.enginatics.com/example/cac-inventory-periods-not-closed-or-summarized/) |
| Blitz Report™ XML Import | [CAC_Inventory_Periods_Not_Closed_or_Summarized.xml](https://www.enginatics.com/xml/cac-inventory-periods-not-closed-or-summarized/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-periods-not-closed-or-summarized/](https://www.enginatics.com/reports/cac-inventory-periods-not-closed-or-summarized/) |

## Case Study & Technical Analysis: CAC Inventory Periods Not Closed or Summarized

### Executive Summary
The **CAC Inventory Periods Not Closed or Summarized** report is a period-close management utility. It scans the inventory organization hierarchy to identify any accounting periods that are either still "Open" or "Closed but not Summarized." This report is a vital checklist for the Finance team to ensure that the month-end close process is complete and that the system is ready for financial reporting.

### Business Challenge
Closing inventory is a multi-step process across many organizations.
*   **Process Gaps**: A period might be "Closed" (preventing new transactions) but the "Period Close Reconciliation" process (which summarizes balances) might have failed or not been run.
*   **Reporting Accuracy**: If a period is not summarized, month-end inventory reports will be empty or inaccurate because the snapshot tables (`cst_period_close_summary`) are not populated.
*   **Hierarchy Management**: In large enterprises, it's hard to track the status of 50+ orgs manually.

### Solution
This report provides a status dashboard.
*   **Exception Based**: Lists only the periods that require attention (Open or Unsummarized).
*   **Hierarchy Aware**: Can report based on the "Period Control" hierarchy, grouping orgs logically.
*   **Actionable**: If a period appears here, the action is clear: either Close it or run the summarization program.

### Technical Architecture
The report checks the status flags in `org_acct_periods`:
*   **Open Check**: Looks for `open_flag = 'Y'`.
*   **Summarized Check**: Looks for `summarized_flag = 'N'` (or equivalent status) for periods that are supposed to be closed.
*   **Hierarchy**: Joins to `per_organization_structures` to respect the reporting hierarchy.

### Parameters
*   **Hierarchy Name**: (Optional) To group the output.
*   **Org Code**: (Optional) To check a specific org.
*   **Period Name**: (Implied) Usually checks the current or recent periods.

### Performance
*   **Instant**: Queries a small status table. Very fast.

### FAQ
**Q: What does "Summarized" mean?**
A: When you close a period, Oracle runs a background process to calculate the ending balance for every item and store it in a summary table. This is "Summarization."

**Q: Why is summarization important?**
A: Most high-performance month-end reports (like the "CAC Inventory and Intransit Value" report) read from the summary table, not the raw transactions. If it's not summarized, those reports return zero.

**Q: Can I close a period without summarizing?**
A: Yes, but it's not recommended. The system allows it, but your reporting will be broken until the summarization completes.


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
