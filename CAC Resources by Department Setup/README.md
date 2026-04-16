---
layout: default
title: 'CAC Resources by Department Setup | Oracle EBS SQL Report'
description: 'Report to show which resources are assigned to which departments. With the respective resource rates as well. /…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Resources, Department, Setup, cst_activities, bom_departments, bom_resources'
permalink: /CAC%20Resources%20by%20Department%20Setup/
---

# CAC Resources by Department Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-resources-by-department-setup/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show which resources are assigned to which departments.  With the respective resource rates as well.

/* +=============================================================================+
-- |  Copyright 2016 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_resources_by_dept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_cost_type        -- Enter Pending or Frozen or AvgRates for the Cost Type.  
-- |                        Optional, defaults to your AvgRates or Frozen Cost Type,
-- |                        depending on your Costing Method.
-- |  Description:
-- |  Report to show which resources are assigned to which departments.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     21 Jan 2017 Douglas Volz   Initial Coding
-- |  1.1     20 Jan 2020 Douglas Volz   Add operating unit and org code parameters.
-- |  1.2     20 Apr 2020 Douglas Volz   Make Cost Type default work for all cost methods
-- +=============================================================================+*/

## Report Parameters
Resource/Overhead Cost Type, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [bom_department_resources](https://www.enginatics.com/library/?pg=1&find=bom_department_resources), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC Resource Costs](/CAC%20Resource%20Costs/ "CAC Resource Costs Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Resources by Department Setup 08-Jul-2022 195451.xlsx](https://www.enginatics.com/example/cac-resources-by-department-setup/) |
| Blitz Report™ XML Import | [CAC_Resources_by_Department_Setup.xml](https://www.enginatics.com/xml/cac-resources-by-department-setup/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-resources-by-department-setup/](https://www.enginatics.com/reports/cac-resources-by-department-setup/) |

## Case Study & Technical Analysis: CAC Resources by Department Setup

### Executive Summary
The **CAC Resources by Department Setup** report validates the manufacturing topology. It shows which Resources are available in which Departments. This setup controls both Scheduling (Capacity Planning) and Costing (Departmental Rates).

### Business Challenge
*   **Routing Errors**: You cannot add a Resource to a Routing Operation if that Resource is not assigned to the Department.
*   **Capacity Planning**: "Do we have enough 'Welding' capacity in the 'Fabrication' department?"
*   **Costing**: Some overheads are Department-specific. This setup links the resource to the department context.

### Solution
This report lists the assignments.
*   **Hierarchy**: `Department` -> `Resource`.
*   **Capacity**: Shows "Capacity Units" (e.g., 2 machines) and "Available 24 Hours" flags.
*   **Costing**: Shows the resource rate (for convenience).

### Technical Architecture
*   **Tables**: `bom_departments`, `bom_department_resources`, `bom_resources`.
*   **Logic**: Standard join of the BOM setup tables.

### Parameters
*   **Organization Code**: (Optional) Filter by plant.

### Performance
*   **Fast**: Master data.

### FAQ
**Q: Can a resource be in multiple departments?**
A: Yes, "General Labor" might be assigned to every department. "Specialized CNC" might be in only one.


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
