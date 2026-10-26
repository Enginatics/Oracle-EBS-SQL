---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Resource Costs | Oracle EBS SQL Report'
description: 'Report to show the resource and outside processing costs by organization and cost type. Parameters: Cost Type: enter the cost type you wish to report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Resource, Costs, cst_activities, mtl_parameters, hr_organization_information'
permalink: /CAC%20Resource%20Costs/
report_name: 'CAC Resource Costs'
report_web_name: cac-resource-costs
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Resource Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-resource-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.12    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Include Non-Costed Resources, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)

## Related Reports
[CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report"), [CAC Load More4Apps Buy Item Costs](/CAC%20Load%20More4Apps%20Buy%20Item%20Costs/ "CAC Load More4Apps Buy Item Costs Oracle EBS SQL Report"), [CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Resource%20Costs/CAC%20Resource%20Costs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Resource Costs 12-Jul-2022 220258.xlsx](https://www.enginatics.com/example/cac-resource-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs) |
| Blitz Report™ XML Import | [CAC_Resource_Costs.xml](https://www.enginatics.com/xml/cac-resource-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs) |
| SQL Source | [CAC Resource Costs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Resource%20Costs/CAC%20Resource%20Costs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-resource-costs/](https://www.enginatics.com/reports/cac-resource-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resource-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
