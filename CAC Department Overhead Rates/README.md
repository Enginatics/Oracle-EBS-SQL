---
layout: default
title: 'CAC Department Overhead Rates | Oracle EBS SQL Report'
description: 'Report to show departmental overheads and rates / +=============================================================================+ -- | Copyright 2016 -…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Department, Overhead, Rates, bom_departments, cst_department_overheads, bom_resources'
permalink: /CAC%20Department%20Overhead%20Rates/
---

# CAC Department Overhead Rates – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-department-overhead-rates/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show departmental overheads and rates

/* +=============================================================================+
-- |  Copyright 2016 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_dept_ovhd_rates.sql
-- |
-- |  Parameters:
-- |  p_ledger	    -- Ledger you wish to report, enter a null or blank for all
-- |                   ledgers.
-- |  p_cost_type   -- Cost Type you wish to report, enter a null or blank for all
-- |                   cost types.
-- | 
-- |  Description:
-- |  Report to show departmental overheads and rates.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     17 Sep 2013 Douglas Volz   Initial Coding
-- |  1.1     18 Oct 2016 Douglas Volz   Added organization information
-- |  1.2      6 Sep 2019 Douglas Volz   Added last update date
-- |  1.3     27 Jan 2020 Douglas Volz   Added Operating Unit parameter
-- |  1.4     26 Apr 2020 Douglas Volz   Changed to multi-language views for 
-- |                                     operating units.+=============================================================================+*/

## Report Parameters
Cost Type, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Department Overhead Rates 23-Jun-2022 145254.xlsx](https://www.enginatics.com/example/cac-department-overhead-rates/) |
| Blitz Report™ XML Import | [CAC_Department_Overhead_Rates.xml](https://www.enginatics.com/xml/cac-department-overhead-rates/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-department-overhead-rates/](https://www.enginatics.com/reports/cac-department-overhead-rates/) |

## Case Study & Technical Analysis: CAC Department Overhead Rates

### Executive Summary
The **CAC Department Overhead Rates** report is a configuration audit tool that displays the overhead rates assigned to manufacturing departments. In Oracle EBS Cost Management, overheads can be applied at the department level (based on resource usage) rather than just at the item level. This report provides a clear view of these rates, their basis (e.g., Resource Units, Resource Value), and the associated General Ledger absorption accounts, ensuring that indirect costs are being allocated correctly to Work in Process (WIP).

### Business Challenge
Setting up departmental overheads involves linking multiple entities: Departments, Resources (Overheads), Cost Types, and Rates. Common challenges include:
*   **Rate Visibility:** It is difficult to see all overhead rates across different departments and cost types in a single screen.
*   **Basis Verification:** Ensuring that the overhead is applied on the correct basis (e.g., $10 per hour vs. 150% of labor cost).
*   **Account Alignment:** Verifying that the absorption account defined on the Overhead resource matches the financial expectation for credit absorption.
*   **Multi-Org Management:** Comparing rates across different factories (Inventory Organizations) to ensure consistency or explain variances.

### The Solution
The report solves these challenges by:
*   **Unified View:** Joining `CST_DEPARTMENT_OVERHEADS` with Department and Resource definitions to show the complete picture in one row.
*   **Basis Decoding:** Translating the numeric `BASIS_TYPE` code into a user-friendly description (e.g., "Item", "Lot", "Resource value", "Resource units").
*   **GL Integration:** Displaying the full accounting flexfield for the absorption account, allowing for immediate validation against the Chart of Accounts.
*   **Cost Type Comparison:** Allowing users to run the report for different Cost Types (e.g., "Frozen" vs. "Pending") to analyze proposed rate changes.

### Technical Architecture (High Level)
The query is a straightforward join of the Costing and Manufacturing definition tables.
*   **Core Table:** `CST_DEPARTMENT_OVERHEADS` stores the intersection of Department, Overhead Resource, and Cost Type, along with the Rate.
*   **Key Joins:**
    *   `BOM_DEPARTMENTS`: For Department codes.
    *   `BOM_RESOURCES`: For Overhead names and Absorption Accounts.
    *   `CST_COST_TYPES`: For Cost Type names.
    *   `MFG_LOOKUPS`: To decode the `BASIS_TYPE` (Lookup Type `CST_BASIS_SHORT`).

### Parameters & Filtering
*   **Cost Type:** Filter by specific cost scenario (e.g., "Frozen", "FY2024 Standard").
*   **Organization Code:** Filter by specific factory/inventory org.
*   **Operating Unit/Ledger:** Standard multi-org filters.

### Performance & Optimization
*   **Direct Joins:** The query uses standard primary key joins, making it highly efficient.
*   **Security:** Implements standard Oracle MOAC (Multi-Org Access Control) and GL Security to restrict data visibility.

### FAQ
**Q: What is the difference between "Resource Units" and "Resource Value" basis?**
A: "Resource Units" means the overhead is applied as a fixed amount per hour (or unit) of the resource used (e.g., $50 overhead per 1 hour of Labor). "Resource Value" means it is applied as a percentage of the resource's cost (e.g., 150% of the Labor rate).

**Q: Why don't I see Item-based overheads here?**
A: This report focuses on *Departmental* overheads, which are driven by routing operations. Item-based overheads (Material Overhead) are typically defined on the Item Master or Category and are reported separately (e.g., "CAC Material Overhead Setup").

**Q: Can I see the history of rate changes?**
A: The report shows the `Last_Update_Date`, which indicates when the rate was last modified. However, it does not show a full audit trail of prior values; it shows the current state for the selected Cost Type.


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
