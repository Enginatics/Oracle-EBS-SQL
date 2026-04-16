---
layout: default
title: 'CAC Department Overhead Setup | Oracle EBS SQL Report'
description: 'Report to show the departments and the overhead codes assigned to each department. In addition, this report displays the corresponding overhead and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Department, Overhead, Setup, cst_department_overheads, cst_resource_overheads, bom_departments'
permalink: /CAC%20Department%20Overhead%20Setup/
---

# CAC Department Overhead Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-department-overhead-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the departments and the overhead codes assigned to each department.  In addition, this report displays the corresponding overhead and resource rates.

Note:  if a resource does not have a cost, the Resource Rate column has a blank or empty value.

Parameters:
===========
Cost Type:  enter the cost type you wish to use to report.  If left blank, depending on your Costing Method, it defaults to your AvgRates or Frozen Cost Type (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2016 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_dept_ovhd_setup.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 Oct 2016 Douglas Volz   Initial Coding
-- |  1.1     07 Nov 2016 Douglas Volz   Added Department / Resource relationships
-- |  1.2     17 Jul 2018 Douglas Volz   Made Cost Type parameter optional
-- |  1.3     12 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters
-- |                                     and change to gl.short_name.  Added Last
-- |                                     rate update column to report.
-- |  1.4     27 Apr 2020 Douglas Volz   Changed to multi-language views for the 
-- |                                     inventory orgs and operating units.
-- |  1.5     22 Jan 2024 Douglas Volz   Add select statement for cst_resource_costs, overheads
-- |                                     were not reported if the resource cost was missing.
-- |                                     Added resource "Allow Costs" column.  Removed
-- |                                     tabs and added inventory access controls.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads), [cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_department_resources](https://www.enginatics.com/library/?pg=1&find=bom_department_resources), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC Department Overhead Rates](/CAC%20Department%20Overhead%20Rates/ "CAC Department Overhead Rates Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Department Overhead Setup 23-Jun-2022 145432.xlsx](https://www.enginatics.com/example/cac-department-overhead-setup/) |
| Blitz Report™ XML Import | [CAC_Department_Overhead_Setup.xml](https://www.enginatics.com/xml/cac-department-overhead-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-department-overhead-setup/](https://www.enginatics.com/reports/cac-department-overhead-setup/) |

## Case Study & Technical Analysis: CAC Department Overhead Setup

### Executive Summary
The **CAC Department Overhead Setup** report provides a comprehensive view of the relationship between Manufacturing Departments, Overhead codes, and the Resources that drive them. Unlike the simpler "Department Overhead Rates" report, this analysis focuses on the *linkage* (association) between Overheads and Resources. It validates that overheads are correctly attached to the productive resources (like Labor or Machine) within a department, ensuring that when labor is charged, the appropriate overhead is automatically applied.

### Business Challenge
In Oracle EBS, overheads can be applied based on "Resource Units" or "Resource Value". This requires a two-step setup:
1.  Define the Overhead and its Rate (Department Overhead).
2.  Associate the Overhead with a specific Resource (Resource Overhead).

Common configuration errors include:
*   **Missing Associations:** An overhead rate is defined for a department, but it is not linked to any resource, so it never gets earned.
*   **Incorrect Basis:** An overhead is set to "Resource Value" basis but is linked to a resource that has a $0 cost, resulting in $0 overhead absorption.
*   **Inconsistent Rates:** The resource rate and the overhead rate are not aligned with the budget.
*   **"Allow Costs" Mismatch:** Resources are set to "Allow Costs = No" but are expected to drive overhead absorption.

### The Solution
This report bridges the gap between the Department definition and the Costing definition by:
*   **Mapping Relationships:** Explicitly showing which Resource (e.g., "LABOR-01") drives which Overhead (e.g., "MFG-OH").
*   **Rate Visibility:** Displaying both the Overhead Rate and the underlying Resource Rate side-by-side.
*   **Cost Type Flexibility:** Supporting "Frozen" (Standard) costs as well as "Average" or simulation cost types.
*   **Validation Flags:** Including the "Allow Costs" flag to highlight resources that are defined but financially disabled.

### Technical Architecture (High Level)
The query joins the Department Overhead table with the Resource Overhead association table.
*   **Core Tables:**
    *   `CST_DEPARTMENT_OVERHEADS` (CDO): Defines the overhead rate for a department.
    *   `CST_RESOURCE_OVERHEADS` (CRO): Links the overhead to a specific resource.
    *   `BOM_DEPARTMENT_RESOURCES` (BDR): Validates the resource exists in that department.
*   **Complex Logic:**
    *   **Resource Cost Retrieval:** Uses a subquery (inline view) to fetch `CST_RESOURCE_COSTS`. This is necessary to handle cases where a resource might exist but has no cost record (which would otherwise cause rows to drop in a standard join).
    *   **Basis Decoding:** Translates `BASIS_TYPE` from `MFG_LOOKUPS`.

### Parameters & Filtering
*   **Cost Type:** Defaults to the organization's primary cost type (Frozen or Average) if left blank.
*   **Organization Code:** Filter by specific inventory organizations.
*   **Operating Unit/Ledger:** Standard multi-org filters.

### Performance & Optimization
*   **Inline View for Costs:** The query uses a specific subquery structure for `CST_RESOURCE_COSTS` to ensure performance and data integrity (avoiding Cartesian products or dropped rows for uncosted resources).
*   **Indexed Joins:** All joins utilize standard Oracle inventory and BOM primary keys (`DEPARTMENT_ID`, `RESOURCE_ID`, `COST_TYPE_ID`).

### FAQ
**Q: Why is the "Resource Rate" blank for some rows?**
A: If the Resource Rate is blank, it means there is no record in `CST_RESOURCE_COSTS` for that resource in the selected Cost Type. This is a setup error if the overhead is based on "Resource Value".

**Q: What happens if an overhead is defined in `CST_DEPARTMENT_OVERHEADS` but not in `CST_RESOURCE_OVERHEADS`?**
A: It will likely not appear in this report (depending on the join type) or will appear with missing resource details. This report focuses on the *setup* of the association. If the association is missing, the overhead will never be charged to WIP.

**Q: Can I use this for "Item" basis overheads?**
A: No, this report is specific to Department/Resource overheads. Item overheads are not linked to departments in this manner.


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
