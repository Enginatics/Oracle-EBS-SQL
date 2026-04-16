---
layout: default
title: 'CAC Resource Costs | Oracle EBS SQL Report'
description: 'Report to show the resource and outside processing costs by organization and cost type. Parameters: Cost Type: enter the cost type you wish to report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Resource, Costs, cst_activities, cst_resource_costs, bom_resources'
permalink: /CAC%20Resource%20Costs/
---

# CAC Resource Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-resource-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the resource and outside processing costs by organization and cost type.

Parameters:
Cost Type:  enter the cost type you wish to report, defaults to your Costing Method (mandatory).
Include Non-Costed Resources:  choose No to exclude non-costed resources, choose Yes to include them.  You normally use non-costed resources for scheduling purposes (mandatory).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006-2023 Douglas Volz Consulting, Inc.
-- |  All rights reserved. 
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission. 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_resource_costs_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 Nov 2010 Douglas Volz   Initial Coding
-- |  1.1     15 Dec 2010 Douglas Volz   Final Coding
-- |  1.2     28 Dec 2010 Douglas Volz   Removed condition to omit Orgs 108, 109, 110 
-- |                                     and 331 as these may be used at any time
-- |  1.3     18 Nov 2015 Douglas Volz   Removed organization restrictions
-- |  1.4     15 Nov 2016 Douglas Volz   Added DFF for Resource_Type, changed
-- |                                     cancatenated segments to separate columns.
-- |  1.5     18 Nov 2016 Douglas Volz   Added Activity to this report
-- |  1.6     16 Feb 2017 Douglas Volz   Added Creation_Date and Who Created
-- |  1.7     17 Feb 2017 Douglas Volz   Add Resource_Description
-- |  1.8     18 Sep 2019 Douglas Volz   Added last update by and last update date
-- |  1.9     27 Jan 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.10    21 Jul 2021 Douglas Volz   Add Basis Type, UOM Code and changed Allow
-- |                                     Costs and Std Rate to lookup codes.
-- |  1.11    11 Oct 2023 Douglas Volz   Modified for invalid created by, invalid 
-- |                                     last updated by and invalid code_combination_id
-- |                                     values, to ensure resources are reported.
-- |                                     Removed tabs and added inventory org access controls.
-- |                                     Reversed revision 1.4, added back concatentated
-- |                                     account number values.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Include Non-Costed Resources, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC Load More4Apps Buy Item Costs](/CAC%20Load%20More4Apps%20Buy%20Item%20Costs/ "CAC Load More4Apps Buy Item Costs Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Resource Costs 12-Jul-2022 220258.xlsx](https://www.enginatics.com/example/cac-resource-costs/) |
| Blitz Report™ XML Import | [CAC_Resource_Costs.xml](https://www.enginatics.com/xml/cac-resource-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-resource-costs/](https://www.enginatics.com/reports/cac-resource-costs/) |

## Case Study & Technical Analysis: CAC Resource Costs

### Executive Summary
The **CAC Resource Costs** report is a master data management tool for Manufacturing Costing. It lists the setup of all Resources (Labor, Machine, Outside Processing) and their associated Standard Rates. This is the foundation of the "Value Added" portion of a product's standard cost.

### Business Challenge
*   **Cost Accuracy**: If the "Assembly Labor" rate is outdated ($20/hr vs. actual $25/hr), every product made will be under-costed.
*   **Consistency**: Ensuring that similar resources (e.g., "Forklift Driver") have consistent rates across different inventory organizations.
*   **Audit**: Verifying that all active resources have a non-zero cost.

### Solution
This report dumps the resource definition.
*   **Details**: Resource Name, Unit of Measure (HR, EA, DOL), Activity (Run, Setup).
*   **Rates**: The standard rate per unit.
*   **Type**: Cost Element (Labor, Outside Processing, Overhead).

### Technical Architecture
*   **Tables**: `bom_resources`, `cst_resource_costs`, `cst_cost_types`.
*   **Logic**: Joins the resource definition to its cost record for the specified Cost Type.

### Parameters
*   **Cost Type**: (Mandatory) Usually "Frozen" or "AverageRates".
*   **Include Non-Costed Resources**: (Mandatory) Toggle to show scheduling-only resources.

### Performance
*   **Fast**: Master data tables are small.

### FAQ
**Q: What is "Outside Processing" (OSP)?**
A: A resource representing a service performed by a vendor (e.g., Plating). The "Rate" is the standard price we pay the vendor.


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
