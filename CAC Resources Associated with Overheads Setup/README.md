---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Resources Associated with Overheads Setup | Oracle EBS SQL Report'
description: 'Report to show which resources are associated with which overheads and which resources are associated with which departments. And find any resources which…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Resources, Associated, Overheads, cst_resource_costs, mtl_parameters, hr_organization_information'
permalink: /CAC%20Resources%20Associated%20with%20Overheads%20Setup/
report_name: 'CAC Resources Associated with Overheads Setup'
report_web_name: cac-resources-associated-with-overheads-setup
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Resources Associated with Overheads Setup – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-resources-associated-with-overheads-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show which resources are associated with which overheads and which resources are associated with which departments.  And find any resources which do not have any overhead associations.  If there are no overhead associations the first report column will say "Missing".
If the resource/overhead association exists, the first column of the report will say "Set Up".

Note:  if a resource does not have a cost, the Resource Rate column has a blank or empty value.

Parameters:
===========
Resource/Overhead Cost Type:  enter the cost type you wish to report for your resources and overheads.  If left blank, depending on your Costing Method, it defaults to your AvgRates or Frozen Cost Type (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2016 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_res_ovhd_setup.sql
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     11 Nov 2016 Douglas Volz   Initial Coding
-- |  1.1     16 Jun 2017 Douglas Volz   Add check for resources which are not
-- |                                     associated with overheads and added the
-- |                                     resource cost element.
-- |  1.2     17 Jul 2018 Douglas Volz   Made Cost Type parameter optional
-- |  1.3     16 Jan 2020 Douglas Volz   Added org code and operating unit parameters.
-- |  1.4     20 Apr 2020 Douglas Volz   Make Cost Type default work for all cost methods
-- |  1.5     09 Jul 2022 Douglas Volz   Changes for multi-language lookup values.
-- |  1.6     22 Jan 2024 Douglas Volz   Add with statement for cst_resource_costs, overheads
-- |                                     were not reported if the resource cost was missing.
-- |                                     Added resource "Allow Costs" column.  Removed
-- |                                     tabs and added inventory access controls.
-- |  1.7     31 Jan 2024 Douglas Volz   Add Currency Code, Resource Type and Charge Type columns.
-- |  1.8     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Resource/Overhead Cost Type, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [bom_department_resources](https://www.enginatics.com/library/?pg=1&find=bom_department_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup), [cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)

## Related Reports
[CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Department Overhead Setup](/CAC%20Department%20Overhead%20Setup/ "CAC Department Overhead Setup Oracle EBS SQL Report"), [CAC Department Overhead Setup Errors](/CAC%20Department%20Overhead%20Setup%20Errors/ "CAC Department Overhead Setup Errors Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CST Supply Chain Indented Bills of Material Cost](/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/ "CST Supply Chain Indented Bills of Material Cost Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Resources%20Associated%20with%20Overheads%20Setup/CAC%20Resources%20Associated%20with%20Overheads%20Setup.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Resources Associated with Overheads Setup 08-Jul-2022 194540.xlsx](https://www.enginatics.com/example/cac-resources-associated-with-overheads-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup) |
| Blitz Report™ XML Import | [CAC_Resources_Associated_with_Overheads_Setup.xml](https://www.enginatics.com/xml/cac-resources-associated-with-overheads-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup) |
| SQL Source | [CAC Resources Associated with Overheads Setup.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Resources%20Associated%20with%20Overheads%20Setup/CAC%20Resources%20Associated%20with%20Overheads%20Setup.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-resources-associated-with-overheads-setup/](https://www.enginatics.com/reports/cac-resources-associated-with-overheads-setup/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup) |

## Case Study & Technical Analysis: CAC Resources Associated with Overheads Setup

### Executive Summary
The **CAC Resources Associated with Overheads Setup** report is a configuration audit tool. In Oracle Costing, Overheads (like "Factory Burden") are often applied based on Resource usage (e.g., "$10 of Overhead for every 1 hour of Labor"). This report validates that the links between Resources and Overheads are correctly established.

### Business Challenge
*   **Under-Absorption**: If "Labor" is not linked to "Fringe Benefits", the product cost will exclude the benefit cost, leading to under-pricing.
*   **Complexity**: A plant might have 50 resources and 10 overheads. Checking the 500 potential combinations manually is error-prone.
*   **Troubleshooting**: "Why is the overhead calculation zero?"

### Solution
This report visualizes the matrix.
*   **Mapping**: Shows `Resource` -> `Overhead`.
*   **Status**: Explicitly flags "Missing" associations where a resource exists but has no overheads linked (if that is the business rule).
*   **Rates**: Shows the basis (Item or Lot) and the rate.

### Technical Architecture
*   **Tables**: `cst_resource_overheads`, `bom_resources`.
*   **Logic**: Uses a `LEFT JOIN` to find resources that *should* have overheads but don't.

### Parameters
*   **Resource/Overhead Cost Type**: (Optional) Defaults to the costing method.

### Performance
*   **Fast**: Configuration data.

### FAQ
**Q: Can a resource have multiple overheads?**
A: Yes, Labor might attract "Fringe", "Supervision", and "Occupancy" overheads. All will be listed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-resources-associated-with-overheads-setup)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
