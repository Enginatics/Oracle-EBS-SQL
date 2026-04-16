---
layout: default
title: 'CAC Department Overhead Setup Errors | Oracle EBS SQL Report'
description: 'This report displays two types of department overhead setup errors. First, show overheads which are not assigned to departments, but, have been assigned…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Department, Overhead, Setup, cst_resource_overheads, bom_department_resources, bom_departments'
permalink: /CAC%20Department%20Overhead%20Setup%20Errors/
---

# CAC Department Overhead Setup Errors – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-department-overhead-setup-errors/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This report displays two types of department overhead setup errors.  First, show overheads which are not assigned to departments, but, have been assigned to resources and those resources have been assigned to these departments as well.  This error is called "Overhead Rates Not In Department".  The second error is when resources which have been assigned to departments but these resources have not been assigned to the overheads which also have been assigned to these departments.  This error is "Overheads Not Set Up with Resources".  When either error you will not earn these overheads when you roll up or charge these resources.

To fix the "Overhead Rates Not In Department" error, go to the Overhead Define Form, click on the Rates button and enter a department overhead rate for that overhead.  To fix the  "Overheads Not Set Up with Resources" error, again go to the Overhead Define Form, click on the Resources button and enter the missing resource for that overhead.  

Parameters:
===========
Cost Type:  enter Pending or Frozen or other cost type name. 
Exclude Outside Processing:  enter Yes to exclude outside processing resources from this report.  Enter No to include outside processing resources.  Defaults to Yes (mandatory). 
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- | Copyright 2016 - 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_ovhd_dept_errors.sql
-- | 
-- |  Description:
-- |  Report to show department overheads setup errors.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     08 Nov 2016 Douglas Volz   Added Cost Element
-- |  1.2     12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters
-- |                                     and change to gl.short_name.
-- |  1.3     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- |  1.4     09 Sep 2023 Douglas Volz   Added new report for missing resource/overhead
-- |                                     associations.  Removed tabs and restrict to only
-- |                                     orgs you have access to, using the org access view.
-- +=============================================================================+*/


## Report Parameters
Cost Type, Include Outside Processing, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads), [bom_department_resources](https://www.enginatics.com/library/?pg=1&find=bom_department_resources), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [CAC Department Overhead Rates](/CAC%20Department%20Overhead%20Rates/ "CAC Department Overhead Rates Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Department Overhead Setup Errors 23-Jun-2022 145628.xlsx](https://www.enginatics.com/example/cac-department-overhead-setup-errors/) |
| Blitz Report™ XML Import | [CAC_Department_Overhead_Setup_Errors.xml](https://www.enginatics.com/xml/cac-department-overhead-setup-errors/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-department-overhead-setup-errors/](https://www.enginatics.com/reports/cac-department-overhead-setup-errors/) |

## Case Study & Technical Analysis: CAC Department Overhead Setup Errors

### Executive Summary
The **CAC Department Overhead Setup Errors** report is a critical diagnostic tool for Oracle EBS Cost Management. It identifies "broken links" in the overhead configuration chain that result in under-absorption of costs. Specifically, it detects scenarios where the necessary relationships between Departments, Resources, and Overheads are partially defined but incomplete, causing the overhead calculation engine to silently fail (i.e., calculate $0 overhead) during cost rollups or WIP transactions.

### Business Challenge
Departmental overheads rely on a triangular relationship:
1.  **Department ↔ Resource:** The resource (e.g., Labor) must exist in the department.
2.  **Department ↔ Overhead:** The overhead (e.g., Factory Burden) must have a rate in that department.
3.  **Resource ↔ Overhead:** The resource must be linked to the overhead to "earn" it.

If any leg of this triangle is missing, the overhead is not applied. These errors are often invisible until month-end analysis reveals low absorption rates. Common scenarios include:
*   **Scenario A (Rate Missing):** A resource is set up to earn an overhead, but the overhead has no rate defined for the specific department where the resource is used.
*   **Scenario B (Link Missing):** A department has both resources and overhead rates defined, but the specific resource hasn't been told to trigger that overhead.

### The Solution
This report proactively scans for these inconsistencies using a two-pronged approach:
*   **"Overhead Rates Not In Department":** Identifies cases where the Resource-Overhead link exists, but the Department-Overhead rate is missing.
*   **"Overheads Not Set Up with Resources":** Identifies cases where the Department-Overhead rate exists and the Resource is present, but the Resource-Overhead link is missing.

### Technical Architecture (High Level)
The query uses a `UNION ALL` structure to combine two distinct validation logic blocks.
*   **Block 1: Missing Rates**
    *   Drivers: `CST_RESOURCE_OVERHEADS` (CRO) and `BOM_DEPARTMENT_RESOURCES` (BDR).
    *   Validation: `NOT EXISTS` in `CST_DEPARTMENT_OVERHEADS` (CDO).
    *   Logic: If a resource in a department is linked to an overhead, that overhead *must* have a rate in that department.
*   **Block 2: Missing Links** (Inferred from standard pattern)
    *   Drivers: `CST_DEPARTMENT_OVERHEADS` (CDO) and `BOM_DEPARTMENT_RESOURCES` (BDR).
    *   Validation: `NOT EXISTS` in `CST_RESOURCE_OVERHEADS` (CRO).
    *   Logic: If a department has an overhead rate and a resource, they should likely be linked (though this can sometimes be intentional, the report highlights it for review).

### Parameters & Filtering
*   **Cost Type:** The specific cost scenario being validated (e.g., "Frozen").
*   **Exclude Outside Processing:** Option to ignore OSP resources, which often have different overhead rules.
*   **Organization Code:** Filter by specific factory.

### Performance & Optimization
*   **Negative Logic:** The use of `NOT EXISTS` is the most efficient way to find "missing" records in large datasets compared to `MINUS` or `NOT IN`.
*   **Indexed Access:** Relies on standard foreign keys (`DEPARTMENT_ID`, `RESOURCE_ID`, `OVERHEAD_ID`).

### FAQ
**Q: If I see an error here, does it mean my General Ledger is wrong?**
A: It means your WIP absorption is likely lower than intended. If you have already processed transactions, you may have under-absorbed overheads, which will manifest as a variance or lower inventory value.

**Q: Is "Overheads Not Set Up with Resources" always an error?**
A: Not necessarily. You might have a department with two resources (Labor and Machine) and an overhead that applies *only* to Machine. In that case, the Labor resource *should not* be linked to the overhead. However, this report flags it so you can confirm the omission is intentional.

**Q: How do I fix "Overhead Rates Not In Department"?**
A: Go to the **Department** form, click **Rates**, and add the missing overhead code and rate for that department.


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
